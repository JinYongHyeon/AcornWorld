package org.dotoryWorld.model;


import javax.sql.DataSource;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

public class DataSourceManager {
	private static DataSourceManager instance = new DataSourceManager();
	private DataSource dataSource;
	
	private DataSourceManager() {
		BasicDataSource dbcp = new BasicDataSource();
		dbcp.setDriverClassName("oracle.jdbc.OracleDriver");
		dbcp.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		dbcp.setUsername("dotory");
		dbcp.setPassword("kosta");
		dbcp.setInitialSize(3);
		dbcp.setMaxTotal(10);
		this.dataSource=dbcp;
	}
		
	}
	public DataSource getDataSource() {
		return this.dataSource;
	}
	public static DataSourceManager getInstance() {
		return instance;
	}
}
