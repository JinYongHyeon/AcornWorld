package org.dotoryWorld.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

public class MemberDAO {
	private static MemberDAO instance = new MemberDAO();
	private DataSource dataSource;

	private MemberDAO() {
		this.dataSource = DataSourceManager.getInstance().getDataSource();
	}

	public static MemberDAO getInstance() {
		return instance;
	}

	public void closeAll(PreparedStatement pstmt, Connection con) throws SQLException {
		if (pstmt != null)
			pstmt.close();
		if (con != null)
			con.close();
	}

	public void closeAll(ResultSet rs, PreparedStatement pstmt, Connection con) throws SQLException {
		if (rs != null)
			rs.close();
		closeAll(pstmt, con);
	}

	// 회원 탈퇴 - 유리
	public void deleteMember(String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		MemberVO vo=null;
		try {
			con = dataSource.getConnection();
			String sql = "delete from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		} finally {
			// TODO: handle finally clause
			closeAll(pstmt, con);
		}

	}

	// 로그인
	public MemberVO login(String id,String password) throws SQLException {
		MemberVO memberVO=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=dataSource.getConnection();
			String sql="SELECT name,address,email,nickname,profile_photo,profile_content,grade FROM member WHERE id=? AND password=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			rs=pstmt.executeQuery();
			if(rs.next())
				memberVO=new MemberVO(id,password,rs.getString("name"),rs.getString("address"),
			rs.getString("email"),rs.getString("nickname"),rs.getString("profile_content"),rs.getString("profile_photo"),
			rs.getString("grade"));
		}finally {
			closeAll(rs, pstmt, con);
		}
		return memberVO;
	}

	// 회원가입 - 지윤
	public void registerMember(MemberVO memberVO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = dataSource.getConnection();
			// 회원가입 시 아이디,패스워드,이름,주소,이메일,닉네임,소개글을 입력받고 등급은 도토리로 고정
			// 관리자인 다람쥐는 DB상에 한 사람으로 고정되어 있음
			String sql = "INSERT INTO member(id,password,name,address,email,nickname,profile_content,grade) VALUES(?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberVO.getId());
			pstmt.setString(2, memberVO.getPassword());
			pstmt.setString(3, memberVO.getName());
			pstmt.setString(4, memberVO.getAddress());
			pstmt.setString(5, memberVO.getEmail());
			pstmt.setString(6, memberVO.getNickname());
			pstmt.setString(7, memberVO.getProfileContent());
			pstmt.setString(8, "도토리");
			pstmt.executeUpdate();
		} finally {
			closeAll(pstmt, con);
		}

	}

	// 아이디 중복체크 - 지윤
	public boolean idcheck(String id) throws SQLException {
		boolean flag = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			String sql = "SELECT COUNT(*) FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next() && rs.getInt(1) > 0)
				flag = true;
		} finally {
			closeAll(rs, pstmt, con);
		}
		return flag;
	}

	/*
	 * 프로필 이미지 등록 및 수정기능 : 이미지 주소 Text DB 컬럼에 등록 *
	 */
	public int toryProfileImgUpload(String id, String profileImgUrl) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		int count = 0;
		try {
			con = dataSource.getConnection();
			String sql = "UPDATE member SET profile_photo=? WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, profileImgUrl);
			pstmt.setString(2, id);
			count = pstmt.executeUpdate();
		} finally {
			closeAll(pstmt, con);
		}
		return count;

	}

	/*
	 * 프로필 수정 : 소개글 닉네임 수정
	 */
	public void toryProfileUpdate(String ninkName, String profileContent, String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = dataSource.getConnection();
			String sql = "UPDATE member SET nickname =?,profile_content =? WHERE id =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, ninkName);
			pstmt.setString(2, profileContent);
			pstmt.setString(3, id);
			pstmt.executeUpdate();
		} finally {
			closeAll(pstmt, con);
		}
	}

	/*
	 * 도토리 추가 : 첫번째 물음표 : 친구 두번째 물음표 : 자기자신
	 */
	public void addDotory(String dotoryId, String MyId) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = dataSource.getConnection();
			String sql = "INSERT INTO dotorylist(dotory_id,id) VALUES(?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dotoryId);
			pstmt.setString(2, MyId);
			pstmt.executeUpdate();
		} finally {
			closeAll(pstmt, con);
		}
	}

	// 회원 정보 수정 - 정콰이어트
	public void updateMemberInfo(MemberVO updateMember) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = new StringBuilder();
		try {
			con = dataSource.getConnection();
			sql.append("update member set password=?,name=?,");
			sql.append("address=?,email=? where id=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, updateMember.getPassword());
			pstmt.setString(2, updateMember.getName());
			pstmt.setString(3, updateMember.getAddress());
			pstmt.setString(4, updateMember.getEmail());
			pstmt.setString(5, updateMember.getId());
			pstmt.executeUpdate();
		} finally {
			closeAll(pstmt, con);
		}

	}

	// 내 도토리들 조회하기 - 배배
	public ArrayList<MemberVO> mydotorylist() throws SQLException {
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			String sql = "select id from dotorylist";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberVO mvo = new MemberVO();
				mvo.setId(rs.getString("id"));
				/*
				 * mvo.setId(rs.getString("grade")); mvo.setId(rs.getString("name"));
				 * mvo.setId(rs.getString("email"));
				 */
				list.add(mvo);
			}
			System.out.println(list.size());
		} finally {
			closeAll(rs, pstmt, con);
			// TODO: handle finally clause
		}
		return list;
	}
	
	//미니홈피 정보 가져오기
	public MemberVO addToryHomeInformation(String id) throws SQLException {
		MemberVO memberVO=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=dataSource.getConnection();
			String sql="SELECT password,name,address,email,nickname,profile_photo,profile_content,grade FROM member WHERE id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next())
				memberVO=new MemberVO(id,rs.getString("password"),rs.getString("name"),rs.getString("address"),
			rs.getString("email"),rs.getString("nickname"),rs.getString("profile_content"),rs.getString("profile_photo"),
			rs.getString("grade"));
		}finally {
			closeAll(rs, pstmt, con);
		}
		return memberVO;
	}

}
