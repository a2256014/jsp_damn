package fintech_pj_damn;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import org.mindrot.jbcrypt.BCrypt;

public class UserGetDao {
	public UserVo getUser(String Id, String Password) throws Exception{
		DBcpBean db = new DBcpBean();
		Connection conn = null;
		Statement stmt = null;
		UserVo vo = null;
		
		ResultSet rs = null;

		String query = "select * from customer where id = '" + Id + "'";
		System.out.println(query);
		try {
			conn = db.getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			
			if(rs.next()) {
				vo = new UserVo();
				vo.setId(rs.getString(1));
				vo.setPassWord(rs.getString(2));
				vo.setUserName(rs.getString(3));
				vo.setEmail(rs.getString(4));
				vo.setPhoneNum(rs.getString(5));
				vo.setPrivilege(rs.getString(6));
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
		
		
			conn = db.getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);

			while(rs.next()) {
				vo = new UserVo();

				vo.setId(rs.getString(1));

				list.add(vo);
			}


			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();

		
		return list;
	}
}
