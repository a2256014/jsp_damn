package fintech_pj_damn;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
// import java.security.MessageDigest;
// import java.security.SecureRandom;
// import java.math.BigInteger;
// import java.util.Base64;
import org.mindrot.jbcrypt.BCrypt;

public class UserPostDao {
	public UserVo getUser(String Id, String Password, String UserName, String Email, String PhoneNum) throws Exception{
		DBcpBean db = new DBcpBean();
		Connection conn = null;
		UserVo vo = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query1 = "select *";
		   query1 += "  from customer									";	
		   query1 += " where id = ?								";


		// SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
		// byte[] bytes = new byte[16];
		// random.nextBytes(bytes);

		// String Salt = new String(Base64.getEncoder().encode(bytes));
		// MessageDigest md = MessageDigest.getInstance("SHA-256");

		// String SaltPass = Password + Salt;  
		// md.update(SaltPass.getBytes());

		// String hex = "";
		// hex = String.format("%064x", new BigInteger(1,md.digest()));

		String hashed = BCrypt.hashpw(Password,BCrypt.gensalt());
		String query2 = "insert into Customer (id, password, name, email, phonenum) values(?, ?, ?, ?, ?)";

		try {
			conn = db.getConn();
			pstmt = conn.prepareStatement(query1);
			pstmt.setString(1, Id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 아이디 중복 됨
				System.out.println("중복");
			}else{
				db = new DBcpBean();
				conn = db.getConn();
				pstmt = conn.prepareStatement(query2);

				pstmt.setString(1, Id);
				pstmt.setString(2, hashed);
				pstmt.setString(3, UserName);
				pstmt.setString(4, Email);
				pstmt.setString(5, PhoneNum);

				int result = pstmt.executeUpdate();

				if(result == 1){
					vo = new UserVo();
					vo.setId(Id);
					vo.setPassWord(Password);
					vo.setUserName(UserName);
					vo.setEmail(Email);
					vo.setPhoneNum(PhoneNum);
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		return vo;
	}
	
	public boolean setPass(String id, String password) throws Exception{
		boolean result = false;

		DBcpBean db = new DBcpBean();
		Connection conn = null;
		UserVo vo = null;
		
		Statement stmt = null;
		ResultSet rs = null;
		
		String hashed = BCrypt.hashpw(password,BCrypt.gensalt(12));
		
		String query = "UPDATE CUSTOMER SET password='" + hashed + "' WHERE id = '" + id + "'";

		try{
			conn = db.getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			if(rs.next()){
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		}

		return result;
	}

	public boolean setPriv(String id, String privilege) throws Exception{
		boolean result = false;

		DBcpBean db = new DBcpBean();
		Connection conn = null;
		
		Statement stmt = null;
		ResultSet rs = null;
		
		String query = "UPDATE CUSTOMER SET privilege='" + privilege + "' WHERE id = '" + id + "'";

		try{
			conn = db.getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			if(rs.next()){
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		}

		return result;
	}
}
