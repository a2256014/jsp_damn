package fintech_pj_damn;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBcpBean {
	private Connection conn;
	private Connection conn2;

	public DBcpBean() {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
			conn = ds.getConnection();
			System.out.println("Connection");

			Context initContext2 = new InitialContext();
			Context envContext2 = (Context)initContext2.lookup("java:/comp/env");
			DataSource ds2 = (DataSource)envContext2.lookup("jdbc/myoracle2");
			conn2 = ds2.getConnection();
			System.out.println("Connection2");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConn() {
		return conn;
	}
	public Connection getConn2() {
		return conn2;
	}
}