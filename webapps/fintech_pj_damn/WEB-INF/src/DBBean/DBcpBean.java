package fintech_pj_damn;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBcpBean {
	private Connection conn;
	
	public DBcpBean() {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
			conn = ds.getConnection();
			System.out.println("Connection");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConn() {
		return conn;
	}
}