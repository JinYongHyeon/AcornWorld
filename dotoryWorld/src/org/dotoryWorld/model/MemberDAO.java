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
	public ArrayList<MemberVO> mydotorylist(String id) throws SQLException {
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			String sql = "select dotory_id from dotorylist where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberVO mvo = new MemberVO();
				mvo.setId(rs.getString("dotory_id"));
				
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
	
	//내 도토리 삭제하기
	public void deleteMydotory(String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		MemberVO vo=null;
		try {
			con = dataSource.getConnection();
			String sql = "delete from dotorylist where dotory_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		} finally {
			closeAll(pstmt, con);
		}
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

	// 방명록 정보 가져오는 메서드 - 정콰이어트
	@SuppressWarnings("null")
	public ArrayList<ToryhomeVO> toryHomeLetterList(String toryId, PagingBean letterPaging) throws SQLException {
		ArrayList<ToryhomeVO> toryletter = new ArrayList<ToryhomeVO>();
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		StringBuilder sql = new StringBuilder();
		try {
			con=dataSource.getConnection();
			sql.append("SELECT R.* ");
			sql.append("FROM (SELECT ROWNUM, toryHome.* ");
			sql.append("FROM (SELECT tory.toryhome_title, tory.toryhome_content, to_char(tory.toryhome_date, 'YYYY-MM-DD HH24:MI:SS'), tory.id_writer, m.profile_photo ");
			sql.append("FROM (SELECT toryhome_no, toryhome_title, toryhome_content, toryhome_date, id_writer, id FROM toryhome_board) tory, member m ");
			sql.append("WHERE tory.id_writer = m.id AND tory.id = ? ORDER BY toryhome_no ASC) toryHome ORDER BY ROWNUM DESC) R ");
			sql.append("WHERE ROWNUM BETWEEN ? AND ?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, toryId);
			System.out.println("----test----");
			System.out.println(letterPaging.getStartRowNumber());
			System.out.println(letterPaging.getEndRowNumber());
			System.out.println("----test----");
			pstmt.setInt(2, letterPaging.getStartRowNumber());
			pstmt.setInt(3, letterPaging.getEndRowNumber());
			rs=pstmt.executeQuery();
			while(rs.next()) {
				toryletter.add(new ToryhomeVO(rs.getString(1), rs.getString(2),
						rs.getString(3), rs.getString(4), rs.getString(5),
						new MemberVO(toryId,null,null,null,null,null,null,(rs.getString(6)),null)));
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return toryletter;
	}
	
	/**
	 * 북마크 추가
	 * @param bookmark
	 * @return
	 * @throws SQLException
	 */
	public int addBookMark(BookmarkVO bookmark) throws SQLException {
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   int coin =0;
	   try {
		   con = dataSource.getConnection();
		   StringBuilder sb = new StringBuilder();
		   sb.append("INSERT INTO bookmark(bookmark_no,link,bookmark_divide,id) VALUES(bookmark_no_seq.NEXTVAL,?,?,?)");
		   pstmt = con.prepareStatement(sb.toString());
		   pstmt.setString(1, bookmark.getBookmarkLink());
		   pstmt.setString(2, bookmark.getBookmarkDivide());
		   pstmt.setString(3, bookmark.getMemberVO().getId());
		   coin = pstmt.executeUpdate();
	   }finally {
		   closeAll(pstmt, con);
	   }
	   return coin;
   }
   /**
    * 북마크 중복체크
    * @param bookmark
    * @return
 * @throws SQLException 
    */
   public ArrayList<String> bookmarkCheck(BookmarkVO bookmark) throws SQLException{
	   Connection con =null;
	   PreparedStatement pstmt =null;
	   ResultSet rs =null;
	   ArrayList<String> bookMarkNo = new ArrayList<String>();
	   try {
		   con = dataSource.getConnection();
		   String sql="SELECT link FROM bookmark WHERE id= ? AND bookmark_divide =?";
		   pstmt = con.prepareStatement(sql);
		   pstmt.setString(1, bookmark.getMemberVO().getId());
		   pstmt.setString(2, bookmark.getBookmarkDivide());
		   rs = pstmt.executeQuery();
		   while(rs.next()) {
			   bookMarkNo.add(rs.getString(1));
		   }
	   }finally {
		   closeAll(rs,pstmt, con);
	   }
	   return bookMarkNo;
   }
   /**
    * 내 북마크 갯수
    * @param id
    * @param bookMark
    * @return
    * @throws SQLException
    */
   public int bookmartListCount(String id,String bookMark) throws SQLException {
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   int count =0;
	   try {
		   con =dataSource.getConnection();
		   String sql = "SELECT COUNT(*) FROM BOOKMARK WHERE id=? AND bookmark_divide=?";
		   pstmt = con.prepareStatement(sql);
		   pstmt.setString(1, id);
		   pstmt.setString(2, bookMark);
		   rs = pstmt.executeQuery();
		   while(rs.next()) {
			   count = rs.getInt(1);
		   }
	   }finally {
		   closeAll(rs, pstmt, con);
	   }
	   return count;
   }
   /**
    * 북마크 정보 가져오기(페이징 사용)
    * @param bookmark
    * @return
    * @throws SQLException
    */
   //bookmark_no,link,bookmark_divide,id
   public ArrayList<BookmarkVO> bookmarkListAll(String id,String bookMark,PagingBean paginBean) throws SQLException{ 
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   ArrayList<BookmarkVO> bookmarkList = new ArrayList<BookmarkVO>();
	   try {
		  con = dataSource.getConnection();
		  StringBuilder sb = new StringBuilder();
		  sb.append("SELECT no,b.link,h.hobby_title,h.id,ho.hobbyboard_title FROM(");
		  sb.append("SELECT ROW_NUMBER() OVER(ORDER BY bookmark_no ASC) as no,link FROM bookmark ");
		  sb.append("WHERE id= ? AND bookmark_divide = ?)b,hobby_post h,hobbyboard ho ");
		  sb.append("WHERE b.link =h.hobbypost_no AND h.hobbyboard_no = ho.hobbyboard_no AND no BETWEEN ? AND ?");
		  sb.append(" ORDER BY no ASC");
		  pstmt = con.prepareStatement(sb.toString());
		  pstmt.setString(1, id);
		  pstmt.setString(2, bookMark);
		  pstmt.setInt(3, paginBean.getStartRowNumber());
		  pstmt.setInt(4, paginBean.getEndRowNumber());
		  rs = pstmt.executeQuery();
		  while(rs.next()) {
			  BookmarkVO bookVO = new BookmarkVO();
			  bookVO.setBookmarkNo(rs.getString("no"));
			  
			  PostVO pvo =new PostVO();
			  pvo.setPostTitle(rs.getString("hobby_title"));
			  bookVO.setPostVO(pvo);
			  
			  
			  MemberVO mvo = new MemberVO();
			  mvo.setId(rs.getString("id"));
			  bookVO.setMemberVO(mvo);
			  
			  bookVO.setBookmarkLink(rs.getString("link"));
			  
			  BoardVO bvo = new BoardVO();
			  bvo.setBoardTitle(rs.getString("hobbyboard_title"));
			  bookVO.setBoardVO(bvo);
			  
			  bookmarkList.add(bookVO);
		  }
	   }finally {
		   closeAll(rs, pstmt, con);
	   }
	   return bookmarkList;
   }
   /**
    * 내 즐겨찾기 정보 가져오기
    * @param id
    * @param bookMark
    * @param paginBean
    * @return
    * @throws SQLException
    */
   public ArrayList<BookmarkVO> favoritesListAll(String id,String bookMark,PagingBean paginBean) throws SQLException{ 
	   ArrayList<BookmarkVO> favoritesList = new ArrayList<BookmarkVO>();
	   Connection con =null;
	   PreparedStatement pstmt= null;
	   ResultSet rs =null;
	   try {
		   con = dataSource.getConnection();
		   StringBuilder sb = new StringBuilder();
		   sb.append("SELECT b.rnum, b.LINK,b.ID,h.hobbyboard_title,h.hobbyboard_imgName ");
		   sb.append("FROM(SELECT ROW_NUMBER() OVER(ORDER BY bookmark_no ASC) AS rnum,link,id ");
		   sb.append("FROM bookmark WHERE bookmark_divide=? AND id=?)b,hobbyboard h ");
		   sb.append("WHERE h.hobbyboard_no = b.link AND b.rnum BETWEEN ? AND ?");
		   pstmt = con.prepareStatement(sb.toString());
		   pstmt.setString(1, bookMark);
		   pstmt.setString(2, id);
		   pstmt.setInt(3, paginBean.getStartRowNumber());
		   pstmt.setInt(4, paginBean.getEndRowNumber());
		   rs = pstmt.executeQuery();
		   while(rs.next()) {
			   BookmarkVO bookVO = new BookmarkVO();
			   bookVO.setBookmarkNo(rs.getString("rnum"));
			   bookVO.setBookmarkLink(rs.getString("link"));
			   
			   MemberVO mvo = new MemberVO();
			   mvo.setId(rs.getString("id"));
			   bookVO.setMemberVO(mvo);
			   
			   BoardVO bvo = new BoardVO();
			   bvo.setBoardTitle(rs.getString("hobbyboard_title"));
			   bvo.setBoardImage(rs.getString("hobbyboard_imgName"));
			   bookVO.setBoardVO(bvo);
			   
			   favoritesList.add(bookVO);
		   }
	   }finally {
		   closeAll(rs, pstmt, con);
	   }
	   return favoritesList;
   }
   
   

   // 방명록 페이징 totalCount - 정 콰이어트
   public int getTotalLetterCount(String id) throws SQLException {
	   int totalCount = 0;
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   try {
		   con = dataSource.getConnection();
		   String sql = "SELECT COUNT(*) FROM TORYHOME_BOARD WHERE id=?";
		   pstmt = con.prepareStatement(sql);
		   pstmt.setString(1, id);
		   rs = pstmt.executeQuery();
		   if(rs.next()) {
			   totalCount = rs.getInt(1);
		   }
	   }finally {
		   closeAll(rs, pstmt, con);
	   }
	   return totalCount;
   }

}
