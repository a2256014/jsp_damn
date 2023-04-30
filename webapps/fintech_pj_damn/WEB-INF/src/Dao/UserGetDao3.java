package fintech_pj_damn;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.regex.*;
import org.mindrot.jbcrypt.BCrypt;

public class UserGetDao3 {
	public UserVo getUser(String Id, String Password) throws Exception{
		DBcpBean db = new DBcpBean();
		Connection conn = null;
		Statement stmt = null;
		UserVo vo = null;
		ResultSet rs = null;
		boolean Attack = false;

		final Pattern SpecialChars = Pattern.compile("['\"\\-#()@;=*/+]");
		Id = SpecialChars.matcher(Id).replaceAll("");

		final String regex="(union|select|from|where)";

		final Pattern pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
		final Matcher matcher = pattern.matcher(Id);

		
		String query = "select * from customer where id = '" + Id + "'";
	
		if(matcher.find()){
			Attack = true;
		}
		if(!Attack){
			try {
				conn = db.getConn();
				stmt = conn.createStatement();
				rs = stmt.executeQuery(query);
					
				if(rs.next()) {
					if(BCrypt.checkpw(Password,rs.getString(2))){
						vo = new UserVo();
						vo.setId(Id);
						vo.setPassWord(rs.getString(2));
						vo.setPrivilege(rs.getString(6));
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			}
		}
		return vo;
	}
	public ArrayList<UserVo> getUserList(String Id) throws Exception{
		DBcpBean db = new DBcpBean();
		Connection conn = null;
		Statement stmt = null;
		UserVo vo = null;
		ResultSet rs = null;

		String query = "select id from customer where id ='" + Id + "'";
		ArrayList<UserVo> list = new ArrayList<UserVo>();

		try {
			conn = db.getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);

			while(rs.next()) {
				vo = new UserVo();

				vo.setId(rs.getString(1));
				vo.setPrivilege(rs.getString(6));

				list.add(vo);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		}
		
		return list;
	}
}
