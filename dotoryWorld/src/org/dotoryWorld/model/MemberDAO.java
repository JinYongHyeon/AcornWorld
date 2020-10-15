package org.dotoryWorld.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

public class MemberDAO {
	private static MemberDAO instance =new MemberDAO();
	private DataSource dataSource;
	private MemberDAO() {
		this.dataSource = DataSourceManager.getInstance().getDataSource();		
	}
	public static MemberDAO getInstance() {
		return instance;
	}
	
	
	public void closeAll(PreparedStatement pstmt,Connection con) throws SQLException {
		if(pstmt !=null)
			pstmt.close();
		if(con != null)
			con.close();
	}
	
	public void closeAll(ResultSet rs,PreparedStatement pstmt,Connection con) throws SQLException {
		if(rs!=null)
			rs.close();
		closeAll(pstmt, con);
	}
	public int deleteMemberConfirm(String id,String password) throws SQLException{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result = 0; 
	    try {
	    	con=dataSource.getConnection();	        
	    	String sql = "select count(*) from member where id=? and password=?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, id);
	        pstmt.setString(2, password);
	        rs=pstmt.executeQuery();
	        if(rs.next())
	            result=rs.getInt(1);
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        closeAll(rs,pstmt, con);
	    }
	    return result;
		
	}
	public void deleteMember(String id) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=dataSource.getConnection();
			String sql = "delete from member where id = '"+id+"'";
	        pstmt = con.prepareStatement(sql);
	        pstmt.executeUpdate();
		} finally {
			// TODO: handle finally clause
			closeAll(pstmt, con);
		}
			
	}
	}
	
