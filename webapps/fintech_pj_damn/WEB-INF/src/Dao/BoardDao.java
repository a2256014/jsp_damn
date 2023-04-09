package fintech_pj_damn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.Arrays;
import java.util.List;


public class BoardDao{
	DBcpBean db = new DBcpBean();
	private Connection conn;
	private ResultSet rs;
	
	public BoardDao() {
		try {
			conn = db.getConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
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
	
	public int getNext() {
		String SQL = "SELECT boardID FROM BOARD WHERE BOARDAVAILABLE =1 ORDER BY boardID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // ù ��° �Խù��� ���
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}

	public int getAllNext() {
		String SQL = "SELECT boardID FROM BOARD ORDER BY boardID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // ù ��° �Խù��� ���
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int write(String boardTitle, String userID, String boardContent, String fName) {
		String SQL = "INSERT INTO BOARD VALUES (?, ?, ?, ?, ?, ?, ?)";
		System.out.println(fName);
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getAllNext());
			pstmt.setString(2, boardTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, boardContent);
			pstmt.setString(6, fName);
			pstmt.setInt(7, 1);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
		
	public ArrayList<BoardVo> getList(int pageNumber) {
		String SQL = "SELECT * FROM (SELECT * FROM BOARD WHERE boardID < ? AND boardAvailable = 1 ORDER BY boardID DESC) WHERE ROWNUM <= 10";
		ArrayList<BoardVo> list = new ArrayList<BoardVo>();

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardVo vo = new BoardVo();
				
				vo.setBoardID(rs.getInt(1));
				vo.setBoardTitle(rs.getString(2));
				vo.setUserID(rs.getString(3));
				vo.setBoardDate(rs.getString(4));
				vo.setBoardContent(rs.getString(5));
				vo.setBoardAvailable(rs.getInt(1));
				list.add(vo);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BOARD WHERE boardID < ? AND boardAvailable = 1";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public BoardVo getBoardVo(int boardID) {
		String SQL = "SELECT * FROM BOARD WHERE boardID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				BoardVo vo = new BoardVo();
				
				vo.setBoardID(rs.getInt(1));
				vo.setBoardTitle(rs.getString(2));
				vo.setUserID(rs.getString(3));
				vo.setBoardDate(rs.getString(4));
				vo.setBoardContent(rs.getString(5));
				vo.setFName(rs.getString(6));
				vo.setBoardAvailable(rs.getInt(1));
				return vo;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public BoardVo getBoardVo(String getType, String boardTitle) {
		String SQL = "SELECT * FROM BOARD WHERE " + getType + " = '" + boardTitle + "'";

		try {
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL);

			if (rs.next()) {
				BoardVo vo = new BoardVo();
				
				vo.setBoardID(rs.getInt(1));
				vo.setBoardTitle(rs.getString(2));
				vo.setUserID(rs.getString(3));
				vo.setBoardDate(rs.getString(4));
				vo.setBoardContent(rs.getString(5));
				vo.setBoardAvailable(rs.getInt(1));
				return vo;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int boardID, String boardTitle, String boardContent, String fName) {
		String SQL = "UPDATE BOARD SET boardTitle = ?, boardContent = ?, fName = ? WHERE boardID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, boardTitle);
			pstmt.setString(2, boardContent);
			pstmt.setString(3, fName);
			pstmt.setInt(4, boardID);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public int delete(int boardID) {
		String SQL = "UPDATE BOARD SET boardAvailable = 0 WHERE boardID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}

	public ArrayList<BoardVo> search(String fromDate, String toDate, String searchTitle, String searchText, String level)throws Exception{
		ArrayList<BoardVo> vo_list = new ArrayList<>();

		if(fromDate == ""){
			fromDate = "0001-01-01";
		}
		if(toDate == ""){
			toDate = "3000-12-30";
		}

		if(level.equals("1")){
			String query = "SELECT * FROM board WHERE TO_DATE(boarddate, 'YYYY-MM-DD HH24:MI:SS') BETWEEN TO_DATE('";
					query += fromDate;
					query += "', 'YYYY-MM-DD') AND TO_DATE('";
					query += toDate;
					query += "', 'YYYY-MM-DD') AND ";
					query += searchTitle;
					query += " LIKE '%";
					query += searchText;
					query += "%' AND BOARDAVAILABLE =1";

			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			System.out.println(query);
			while(rs.next()){
				BoardVo vo = new BoardVo();

				vo.setBoardID(rs.getInt(1));
				vo.setBoardTitle(rs.getString(2));
				vo.setUserID(rs.getString(3));
				vo.setBoardDate(rs.getString(4));
				vo.setBoardContent(rs.getString(5));
				vo.setBoardAvailable(rs.getInt(7));

				vo_list.add(vo);
			}

			return vo_list;
		}else if(level.equals("2")){
			System.out.println(level);
			return null;
		}else if(level.equals("3")){
			return null;
		}else if(level.equals("max")){
			String query = "";
			if(searchTitle.equals("boardTitle")){
				query = "SELECT * FROM board WHERE TO_DATE(boarddate, 'YYYY-MM-DD HH24:MI:SS') BETWEEN TO_DATE(? , 'YYYY-MM-DD') AND TO_DATE(? , 'YYYY-MM-DD') AND boardTitle LIKE '%' || ? || '%' AND BOARDAVAILABLE =1";
			}else{
				query = "SELECT * FROM board WHERE TO_DATE(boarddate, 'YYYY-MM-DD HH24:MI:SS') BETWEEN TO_DATE(? , 'YYYY-MM-DD') AND TO_DATE(? , 'YYYY-MM-DD') AND userID LIKE '%' || ? || '%' AND BOARDAVAILABLE =1";
			}
			try{
				PreparedStatement pstmt = conn.prepareStatement(query);
				pstmt.setString(1, fromDate);
				pstmt.setString(2, toDate);
				pstmt.setString(3, searchText);
				
				rs = pstmt.executeQuery();

				while(rs.next()){
					BoardVo vo = new BoardVo();

					vo.setBoardID(rs.getInt(1));
					vo.setBoardTitle(rs.getString(2));
					vo.setUserID(rs.getString(3));
					vo.setBoardDate(rs.getString(4));
					vo.setBoardContent(rs.getString(5));
					vo.setBoardAvailable(rs.getInt(7));

					vo_list.add(vo);
				}
				return vo_list;
			}catch(Exception e){
				e.printStackTrace();
			}
			return null;
		}
		return null;
	}
	// public ArrayList<BoardVo> getOrder(String orderBy, String orderType, String level)throws Exception {
	// 	if(level.equals("1")){
	// 		String query = "select * from board where BOARDAVAILABLE = 1 order by "+ orderBy +" "+ orderType;
	// 		System.out.println(query);
	// 		Statement stmt = conn.createStatement();
	// 		rs = stmt.executeQuery(query);
	// 		ArrayList<BoardVo> orderList = new ArrayList<>();

	// 		while(rs.next()){
	// 			BoardVo vo = new BoardVo();
	// 			vo.setBoardID(rs.getInt(1));
	// 			vo.setBoardTitle(rs.getString(2));
	// 			vo.setUserID(rs.getString(3));
	// 			vo.setBoardDate(rs.getString(4));
	// 			vo.setBoardContent(rs.getString(5));
	// 			vo.setFName(rs.getString(6));
	// 			vo.setBoardAvailable(rs.getInt(1));
	// 			orderList.add(vo);
	// 		}

	// 		return orderList; 	
	// 	}else if(level.equals("2")){
	// 		return null; 
	// 	}else if(level.equals("3")){
	// 		return null;
	// 	}else if(level.equals("max")){
	// 		return null;
	// 	}
	// 	return null;
	// }

	public ArrayList<BoardVo> getOrder(String orderBy, String orderType, String level) throws Exception {
		if (level.equals("1")) {
			String query = "select * from board where BOARDAVAILABLE = 1 order by "+ orderBy +" "+ orderType;
			System.out.println(query);
			
			// ExecutorService ����
			ExecutorService executorService = Executors.newFixedThreadPool(2);
			// 2���� �����带 �����Ͽ� ���� DBcpBean ��ü�� �����Ͽ� ����
			Callable<ArrayList<BoardVo>> task1 = new Callable<ArrayList<BoardVo>>() {
				@Override
				public ArrayList<BoardVo> call() throws Exception {
					Connection conn1 = db.getConn();
					Statement stmt = conn1.createStatement();
					ResultSet rs = stmt.executeQuery(query);
					ArrayList<BoardVo> orderList = new ArrayList<>();
	
					while(rs.next()){
						BoardVo vo = new BoardVo();
						vo.setBoardID(rs.getInt(1));
						vo.setBoardTitle(rs.getString(2));
						vo.setUserID(rs.getString(3));
						vo.setBoardDate(rs.getString(4));
						vo.setBoardContent(rs.getString(5));
						vo.setFName(rs.getString(6));
						vo.setBoardAvailable(rs.getInt(1));
						orderList.add(vo);
					}

					return orderList;
				}
			};
			Callable<ArrayList<BoardVo>> task2 = new Callable<ArrayList<BoardVo>>() {
				@Override
				public ArrayList<BoardVo> call() throws Exception {
					Connection conn2 = db.getConn2();
					Statement stmt = conn2.createStatement();
					ResultSet rs = stmt.executeQuery(query);
					ArrayList<BoardVo> orderList = new ArrayList<>();
	
					while(rs.next()){
						BoardVo vo = new BoardVo();
						vo.setBoardID(rs.getInt(1));
						vo.setBoardTitle(rs.getString(2));
						vo.setUserID(rs.getString(3));
						vo.setBoardDate(rs.getString(4));
						vo.setBoardContent(rs.getString(5));
						vo.setFName(rs.getString(6));
						vo.setBoardAvailable(rs.getInt(1));
						orderList.add(vo);
					}

					return orderList;
				}
			};
			
			// ������ Ǯ�� �۾��� �����ϰ� ����
			List<Future<ArrayList<BoardVo>>> futures = executorService.invokeAll(Arrays.asList(task1, task2));
			
			// �� �����忡�� ��ȯ�� ����� ��� ���ļ� ��ȯ
			ArrayList<BoardVo> result = new ArrayList<>();
			for (Future<ArrayList<BoardVo>> future : futures) {
				result.addAll(future.get());
			}
			return result;
		}
		return null;
	}

}
