package org.dotoryWorld.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;



public class PostDAO {
	private static PostDAO instance = new PostDAO();
	private DataSource dataSource;

	public PostDAO() {
		this.dataSource = DataSourceManager.getInstance().getDataSource();
	}

	public static PostDAO getInstance() {
		return instance;
	}

	public Connection getConnection() throws SQLException {
		return dataSource.getConnection();
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

	/**
	 * 페이지 번호에 해당하는 게시물 목록 리스트를 반환하는 메서드 LIST SQL -> Test 후 반영하세요 SELECT
	 * b.no,b.title,b.hits,to_char(time_posted,'YYYY.MM.DD') as
	 * time_posted,m.id,m.name FROM board b , board_member m WHERE b.id=m.id order
	 * by no desc
	 * 
	 * @param pageNo
	 * @return
	 * @throws SQLException
	 */

	public ArrayList<PostVO> getPostingList(PagingBean pagingBean, String hobbyBoardNo) throws SQLException{
		ArrayList<PostVO> list=new ArrayList<PostVO>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			System.out.println(hobbyBoardNo+"번호확인"+pagingBean.getEndRowNumber());
			con=getConnection(); 
			StringBuilder sql=new StringBuilder();	
			System.out.println("postDAO 실행");
			sql.append("SELECT B.hobbypost_no,B.hobby_title,B.hobbypost_viewcount,B.time_posted,M.id,M.name FROM( ");
			sql.append("SELECT row_number() over(ORDER BY hobbypost_no DESC) as rnum,hobbypost_no,hobby_title,hobbypost_viewcount, ");
			sql.append("to_char(hobbypost_date,'YYYY.MM.DD') as time_posted,id,hobbyboard_no FROM hobby_post WHERE hobbyboard_no = ? ");
			sql.append(")B, member M WHERE B.id=M.id AND rnum BETWEEN ? AND ? ");	
			pstmt=con.prepareStatement(sql.toString());	
			//start, endRowNumber를 할당한다
			pstmt.setString(1, hobbyBoardNo);
			pstmt.setInt(2, pagingBean.getStartRowNumber());
			pstmt.setInt(3, pagingBean.getEndRowNumber());
			rs=pstmt.executeQuery();	
			//목록에서 게시물 content는 필요없으므로 null로 setting
			//select no,title,time_posted,hits,id,name
			while(rs.next()){		
				PostVO pvo=new PostVO();
				pvo.setPostNo(rs.getString(1));
				pvo.setPostTitle(rs.getString(2));
				pvo.setViewCount(rs.getInt(3));
				pvo.setPostDate(rs.getString(4));
				MemberVO mvo = new MemberVO();
				mvo.setId(rs.getString(5));
				mvo.setName(rs.getString(6));
				pvo.setMemberVO(mvo);

				list.add(pvo);
			}
		} finally {
			closeAll(rs, pstmt, con);		
		}
		return list;
		}
	
	public ArrayList<PostVO> getPostingListById(PagingBean pagingBean, String id) throws SQLException{
		ArrayList<PostVO> list=new ArrayList<PostVO>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			System.out.println(id+"아이디확인"+pagingBean.getEndRowNumber());
			con=getConnection(); 
			StringBuilder sql=new StringBuilder();	
			System.out.println("postDAO 실행");
			sql.append("SELECT B.hobbypost_no,B.hobby_title,B.hobbypost_viewcount,B.time_posted, H.hobbyboard_title FROM( ");
			sql.append("SELECT row_number() over(ORDER BY hobbypost_no DESC) as rnum,hobbypost_no,hobby_title,hobbypost_viewcount, ");
			sql.append("to_char(hobbypost_date,'YYYY.MM.DD') as time_posted,hobbyboard_no FROM hobby_post WHERE id = ? ");
			sql.append(")B, hobbyboard H WHERE B.hobbyboard_no=H.hobbyboard_no AND rnum BETWEEN ? AND ? ");	
			pstmt=con.prepareStatement(sql.toString());	
			//start, endRowNumber를 할당한다
			pstmt.setString(1, id);
			pstmt.setInt(2, pagingBean.getStartRowNumber());
			pstmt.setInt(3, pagingBean.getEndRowNumber());
			rs=pstmt.executeQuery();	
			//목록에서 게시물 content는 필요없으므로 null로 setting
			//select no,title,time_posted,hits,id,name
			while(rs.next()){		
				PostVO pvo=new PostVO();
				pvo.setPostNo(rs.getString(1));
				pvo.setPostTitle(rs.getString(2));
				pvo.setViewCount(rs.getInt(3));
				pvo.setPostDate(rs.getString(4));
				BoardVO bvo = new BoardVO();
				bvo.setBoardTitle(rs.getString(5));
				pvo.setBoardVO(bvo);
				list.add(pvo);
			}
		} finally {
			closeAll(rs, pstmt, con);		
		}
		return list;
	}
	
	/**
	 * Sequence 글번호로 게시물을 검색하는 메서드
	 * 
	 * @param no
	 * @return
	 * @throws SQLException
	 */
	public PostVO getPostingByNo(String no) throws SQLException {
		PostVO pvo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select b.hobby_title,to_char(b.hobbypost_date,'YYYY.MM.DD  HH24:MI:SS') as time_posted");
			sql.append(",b.hobby_content,b.hobbypost_viewcount,b.id,m.name,b.hobbyboard_no");
			sql.append(" from hobby_post b,member m");
			sql.append(" where b.id=m.id and b.hobbypost_no=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pvo = new PostVO();
				pvo.setPostNo(no);
				pvo.setPostTitle(rs.getString("hobby_title"));
				pvo.setPostContent(rs.getString("hobby_content"));
				pvo.setViewCount(rs.getInt("hobbypost_viewcount"));
				pvo.setPostDate(rs.getString("time_posted"));
				BoardVO bvo = new BoardVO();
				bvo.setBoardNo(rs.getString("hobbyboard_no"));
				pvo.setBoardVO(bvo);
				MemberVO mvo = new MemberVO();
				mvo.setId(rs.getString("id"));
				mvo.setName(rs.getString("name"));
				pvo.setMemberVO(mvo);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return pvo;
	}

	/**
	 * 조회수 증가
	 * 
	 * @param no
	 * @throws SQLException
	 */
	public void updateViewcount(String no) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "UPDATE hobby_post SET hobbypost_viewcount=hobbypost_viewcount+1 where hobbypost_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, no);
			pstmt.executeUpdate();
		} finally {
			closeAll(pstmt, con);
		}
	}

	/**
	 * 게시물 등록 메서드 게시물 등록 후 생성된 시퀀스를 BoardVO에 setting 한다. insert into
	 * board(no,title,content,id,time_posted)
	 * values(board_seq.nextval,?,?,?,sysdate)
	 * 
	 * @param vo
	 * @throws SQLException
	 */
	public String postWrite(PostVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO hobby_post(hobbypost_no,hobby_title,hobby_content,hobbypost_date,hobbyboard_no,id) ");
			sql.append("VALUES(hobbypost_no_seq.NEXTVAL,?,?,sysdate,?,?)");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, vo.getPostTitle());
			pstmt.setString(2, vo.getPostContent());
			pstmt.setString(3, vo.getBoardVO().getBoardNo());
			pstmt.setString(4, vo.getMemberVO().getId());
			pstmt.executeUpdate();
			pstmt.close();
			pstmt = con.prepareStatement("select hobbypost_no_seq.currval from dual");
			rs = pstmt.executeQuery();
			String postNo = null;
			if (rs.next()) {
				postNo = rs.getString(1);
			}
			return postNo;
		} finally {
			closeAll(rs, pstmt, con);
		}
	}

	/**
	 * 글번호에 해당하는 게시물을 삭제하는 메서드
	 * 
	 * @param no
	 * @throws SQLException
	 */
	
	public void deletePosting(int no) throws SQLException{
		Connection con=null;
		PreparedStatement pstmt=null;
		try{
			con=getConnection();
			pstmt=con.prepareStatement("delete from hobby_post where hobbypost_no=?");
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
			}finally{
				closeAll(pstmt,con);
			}
	}
	
	/**
	 * 게시물 정보 업데이트하는 메서드
	 * 
	 * @param vo
	 * @throws SQLException
	 */
	
	public void updatePosting(PostVO vo) throws SQLException{ Connection
		con=null; PreparedStatement pstmt=null;
		try{
			con=getConnection();
			pstmt=con.prepareStatement("update hobby_post set hobby_title=?,hobby_content=? where hobbypost_no=?");
			pstmt.setString(1, vo.getPostTitle());
			pstmt.setString(2, vo.getPostContent());
			pstmt.setString(3, vo.getPostNo()); pstmt.executeUpdate();
		}finally{
			closeAll(pstmt,con);
		}
	}
	
	public int getTotalPostCount(String hobbyBoardNo) throws SQLException {
		int totalCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select count(*) from hobby_post where hobbyboard_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, hobbyBoardNo);
			rs = pstmt.executeQuery();
			if (rs.next())
				totalCount = rs.getInt(1);
		} finally {
			closeAll(rs, pstmt, con);
		}
		return totalCount;
	}
	
	public int getTotalPostCountById(String id) throws SQLException {
		int totalCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select count(*) from hobby_post where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next())
				totalCount = rs.getInt(1);
		} finally {
			closeAll(rs, pstmt, con);
		}
		return totalCount;
	}

	// 게시물 검색 메서드
	// 게시물 갯수만 알고싶은거임
	public int searchPost(String postTitle) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;
		try {
			con = getConnection();
			String sql ="select count(*) from hobby_post where hobby_title LIKE ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,"%" + postTitle +"%");
			rs=pstmt.executeQuery();
			while(rs.next()) {
				count=rs.getInt(1);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return count;
	}
	public ArrayList<PostVO> searchPost(String postTitle,PagingBean pgb) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<PostVO> searchList = new ArrayList<PostVO>();
		
		try {
			con = getConnection();
			StringBuilder sql= new StringBuilder();
			sql.append("select hobbypost_no,hobby_title,id,hobbypost_date,hobbypost_viewcount ");
			sql.append("from(select row_number() over(order by hobbypost_no asc) as rnum, ");
			sql.append("hobbypost_no,hobby_title,id,hobbypost_date,hobbypost_viewcount ");
			sql.append("from hobby_post where hobby_title LIKE ? )");
			sql.append("where rnum between ? and ? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1,"%" + postTitle +"%");
			pstmt.setInt(2, pgb.getStartRowNumber());
			pstmt.setInt(3, pgb.getEndRowNumber());
			rs=pstmt.executeQuery();
			while(rs.next()) {
				PostVO pvo = new PostVO();
				pvo.setPostNo(rs.getString(1));
				pvo.setPostTitle(rs.getString(2));
				MemberVO mvo = new MemberVO();
				mvo.setId(rs.getString(3));
				pvo.setMemberVO(mvo);
				pvo.setPostDate(rs.getString(4));
				pvo.setViewCount(rs.getInt(5));
				searchList.add(pvo);
			}
			System.out.println(pgb.getStartRowNumber());
			System.out.println(searchList.size());
			System.out.println(postTitle);
		} finally {
			closeAll(rs, pstmt, con);
		}
		return searchList;
	}



	
	// 소카테고리 리스트(운동-축구,복싱 등) 불러오는 메서드 - 지윤
	public ArrayList<BoardVO> getBoardList(String categoryNo) throws SQLException {
		ArrayList<BoardVO> boardList=new ArrayList<BoardVO>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=dataSource.getConnection();
			String sql="SELECT h.hobbyboard_title,h.hobbyboard_no,h.hobbyboard_imgName,c.category_content FROM hobbyboard h, category c WHERE h.category_no=c.category_no AND c.category_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, categoryNo);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardVO boardVO=new BoardVO();
				boardVO.setBoardTitle(rs.getString(1));
				boardVO.setBoardNo(rs.getString(2));
				boardVO.setBoardImage(rs.getString(3));
				CategoryVO categoryVO=new CategoryVO();
				categoryVO.setCategoryContent(rs.getString(4));
				boardVO.setCategoryVO(categoryVO);
				boardList.add(boardVO);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return boardList;
	}
	
	/**
	 * 모든 게시물수[어드민 게시물 관리]
	 * @return
	 * @throws SQLException
	 */
	public int getAllCountPost() throws SQLException {
		int count=0;
		Connection con=null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		try {
			con = dataSource.getConnection();
			String sql = "SELECT COUNT(*) FROM hobby_post";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}finally {
			closeAll(rs,pstmt,con);
		}
		return count;
	}
	
	/**
	 * 어드민 게시물 관리 페이지
	 * @param paginBean
	 * @return
	 * @throws SQLException
	 */
	public ArrayList<PostVO> getAllPostList(PagingBean paginBean) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		ArrayList<PostVO> pvoList = new ArrayList<PostVO>();
		try {
			con = dataSource.getConnection();
			StringBuilder sb= new StringBuilder();
			sb.append("SELECT rnum,hobbypost_no,hobby_title,id,hobbypost_date,hobbypost_viewcount FROM ");
			sb.append("(SELECT hobbypost_no,ROW_NUMBER() OVER(ORDER BY hobbypost_no ASC) AS rnum,hobby_title,id,TO_CHAR(hobbypost_date,'yyyy-mm-dd') as hobbypost_date,hobbypost_viewcount");
			sb.append(" FROM hobby_post");
			sb.append(")h WHERE rnum BETWEEN ? AND ?");
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setInt(1, paginBean.getStartRowNumber());
			pstmt.setInt(2, paginBean.getEndRowNumber());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PostVO pvo = new PostVO();
				pvo.setPostNo(rs.getString("hobbypost_no"));
				pvo.setPostTitle(rs.getString("hobby_title"));
				
				MemberVO mvo = new MemberVO();
				mvo.setId(rs.getString("id"));
				pvo.setMemberVO(mvo);
				
				pvo.setPostDate(rs.getString("hobbypost_date"));
				pvo.setViewCount(rs.getInt("hobbypost_viewcount"));
				
				pvoList.add(pvo);
				
			}
			}finally {
			closeAll(rs,pstmt,con);
		}
		return pvoList;
	}
	
	/**
	 * 어드민 게시물 삭제
	 * @param no
	 * @throws SQLException
	 */
	public void adminManageDelete(int no) throws SQLException {
		Connection con =null;
		PreparedStatement pstmt = null;
		try {
			con = dataSource.getConnection();
			String sql="DELETE FROM hobby_post WHERE hobbypost_no =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
		}finally {
			closeAll(pstmt, con);
		}
	}
	
	/**
	 * 좋아요 중복 방지를 위한 테이블에 추가
	 * @param id
	 * @param no
	 * @throws SQLException
	 */
	public void postLike(String id, String no) throws SQLException {
		Connection con =null;
		PreparedStatement pstmt= null;
		try {
			con = dataSource.getConnection();
			String sql = "INSERT INTO hobbypostlike VALUES(?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, no);
			pstmt.executeUpdate();
		}finally {
			closeAll(pstmt, con);
		}
	}
	public void postLikeRemove(String id, String no) throws SQLException {
		Connection con =null;
		PreparedStatement pstmt = null;
		try {
			con =dataSource.getConnection();
			String sql = "DELETE FROM hobbypostlike WHERE id=? AND HOBBYPOST_NO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, no);
			pstmt.executeQuery();
		}finally {
			
		}
	}
	
	
	/**
	 * 좋아요 중복체크
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public int postLikeCheck(String id,String no) throws SQLException{
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count =-1;
		try {
			con = dataSource.getConnection();
			String sql ="SELECT count(*) FROM hobbypostlike WHERE id=? AND hobbypost_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.setString(2,no);
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
	 * 좋아요 기능
	 * @param no
	 * @throws SQLException
	 */
	public void postLikeUp(String no) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = dataSource.getConnection();
			String sql="UPDATE hobby_post SET hobby_like = hobby_like+1 WHERE hobbypost_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, no);
			pstmt.executeUpdate();
		}finally {
			closeAll(pstmt, con);
		}
	}
	/**
	 * 좋아요 뺴기
	 * @param no
	 * @throws SQLException
	 */
	public void postLikeMinus(String no) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = dataSource.getConnection();
			String sql="UPDATE hobby_post SET hobby_like = hobby_like-1 WHERE hobbypost_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, no);
			pstmt.executeUpdate();
		}finally {
			closeAll(pstmt, con);
		}
	}
	
}
