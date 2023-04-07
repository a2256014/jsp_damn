package fintech_pj_damn;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import org.mindrot.jbcrypt.BCrypt;

public class UserGetDao2 {
	public UserVo getUser(String Id, String Password) throws Exception{
		DBcpBean db = new DBcpBean();
		Connection conn = null;
		Statement stmt = null;
		UserVo vo = null;
		
		ResultSet rs = null;

		String query = "select password from customer where id = '" + Id + "'";

		try {
			conn = db.getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
				
			if(rs.next()) {
				if(BCrypt.checkpw(Password,rs.getString(1))){
					vo = new UserVo();
					vo.setId(Id);
					vo.setPassWord(rs.getString(1));
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
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
		System.out.println(query);
		try {
			conn = db.getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);

			while(rs.next()) {
				vo = new UserVo();

				vo.setId(rs.getString(1));

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
