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
	
	
	/*
	 * 프로필 이미지 등록 및 수정기능 : 이미지 주소 Text DB 컬럼에 등록
	 * 	 * */
	public void toryProfileImgUpload(String id,String profileImgUrl) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt =null;
		try {
			con = dataSource.getConnection();
			String sql = "UPDATE member SET profile_photo=? WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, profileImgUrl);
		    pstmt.setString(2, id);
			pstmt.executeUpdate();
		}finally {
			closeAll(pstmt, con);
		}
		
	}
	
	
}
