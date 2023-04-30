package fintech_pj_damn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Types;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.Arrays;
import java.util.List;
import java.util.regex.*;
import java.io.*;

public class CommentDao{
	DBcpBean db = new DBcpBean();
	private Connection conn;
	private ResultSet rs;
	
	public CommentDao() {
		try {
			conn = db.getConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
    public int getNext() {
		String SQL = "SELECT commentID FROM BComment ORDER BY commentID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 댓글인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public String getDate() {
		String SQL = "SELECT SYSDATE FROM DUAL";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}

    public ArrayList<CommentVo> getComments(int boardId){
        ArrayList<CommentVo> comments = new ArrayList<>();
		try{
			PreparedStatement preparedStatement = conn.prepareStatement(
                "SELECT * FROM Bcomment WHERE boardId = ? order by commentdate DESC"
			);
			preparedStatement.setInt(1, boardId);
			rs = preparedStatement.executeQuery();
			while (rs.next()) {
				CommentVo cv = new CommentVo();
				cv.setCommentID(rs.getInt("commentID"));
				cv.setBoardID(rs.getInt("BoardID"));
				cv.setuserID(rs.getString("userID"));
				cv.setCommentDate(rs.getString("commentDate"));
				cv.setComment(rs.getString("CommentContent"));
				cv.setisSecret(rs.getString("isSecret"));
				
				comments.add(cv);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
        return comments;
    }

	public int addComment(int boardID, String userID, String comment, String isSecret) {
		try{
			PreparedStatement preparedStatement = conn.prepareStatement(
                "INSERT INTO Bcomment VALUES (?, ?, ?, ?, ?, ?)"
			);
			preparedStatement.setInt(1, getNext());
			preparedStatement.setInt(2, boardID);
			preparedStatement.setString(3, userID);
			preparedStatement.setString(4, getDate());
			preparedStatement.setString(5, comment);
			preparedStatement.setString(6, isSecret);
			preparedStatement.executeUpdate();

			return 1;
		} catch(Exception e){
			e.printStackTrace();
		}
       return 0;
    }

	public CommentVo getComment(int commentID, String isSecret){
		CommentVo cv = new CommentVo();
		try{
			
			if(isSecret==null){
				PreparedStatement preparedStatement = conn.prepareStatement(
					"SELECT * FROM Bcomment WHERE commentID = ? AND isSecret IS NULL"
				);
				preparedStatement.setInt(1, commentID);
				rs = preparedStatement.executeQuery();
			}else{
				PreparedStatement preparedStatement = conn.prepareStatement(
                "SELECT * FROM Bcomment WHERE commentID = ? AND isSecret = ?"
				);
				preparedStatement.setInt(1, commentID);
				preparedStatement.setString(2, isSecret);
				rs = preparedStatement.executeQuery();
			}
			
			if(rs.next()){
				cv.setCommentID(rs.getInt(1));
				cv.setBoardID(rs.getInt(2));
				cv.setuserID(rs.getString(3));
				cv.setComment(rs.getString(4));
				cv.setCommentDate(rs.getString(5));
				cv.setisSecret(rs.getString(6));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return cv;
	}

	public int deleteComment(int commentID, String userID, String isSecret) {
		String passwd = null;
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(
				"SELECT * FROM BComment WHERE commentID=?"
			);
			pstmt.setInt(1, commentID);
			rs = pstmt.executeQuery();
			if(rs.next()){
				passwd = rs.getString("isSecret");
			}

			if(isSecret==null || (isSecret!=null && passwd.equals(isSecret))){
				PreparedStatement pstmt1 = conn.prepareStatement(
				"DELETE FROM BComment WHERE commentID=?"
				);
				pstmt1.setInt(1, commentID);
				
				return pstmt1.executeUpdate();
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
}
