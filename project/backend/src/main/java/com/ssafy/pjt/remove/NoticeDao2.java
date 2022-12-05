package com.ssafy.pjt.remove;
//package com.ssafy.pjt.notice.model.dao;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//
//import com.ssafy.pjt.notice.model.NoticeDto;
//import com.ssafy.pjt.util.DBUtil;
//
//public class NoticeDao {
//	private static NoticeDao noticeDao = new NoticeDao();
//	private DBUtil dbUtil;
//	
//	private NoticeDao() {
//		dbUtil = DBUtil.getInstance();
//	}
//	
//	public static NoticeDao getNoticeDao() {
//		return noticeDao;
//	}
//
//	public int write(NoticeDto noticeDto) throws SQLException {
//		Connection conn = null;
//		PreparedStatement pstmt =null;
//		int cnt=0;
//		try {
//			conn = dbUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("insert into notice (user_id, subject, content, register_time) \n");
//			sql.append("values (?, ?, ?, now()) \n");
//			pstmt = conn.prepareStatement(sql.toString());
//			
//			pstmt.setString(1, noticeDto.getUserId());
//			pstmt.setString(2, noticeDto.getSubject());
//			pstmt.setString(3, noticeDto.getContent());
//			
//			//insert 결과 얻어오기
//			cnt = pstmt.executeUpdate();
//		}
//		finally {
//			dbUtil.close(pstmt, conn);
//		}
//		return cnt;
//	}
//
//	public List<NoticeDto> getlist() throws SQLException {
//		Connection conn = null;
//		PreparedStatement pstmt =null;
//		ResultSet rs = null;
//		List<NoticeDto> notices= new ArrayList<>();
//		
//		try {
//			conn = dbUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("select notice_no, user_id, subject, content, register_time \n");
//			sql.append("from notice \n");
//			sql.append("order by notice_no desc \n");
//			pstmt = conn.prepareStatement(sql.toString());
//			rs = pstmt.executeQuery();
//			
//			//rs 결과 list 에 담기
//			while(rs.next()) {
//				NoticeDto noticeDto = new NoticeDto();
//				noticeDto.setNoticeNo(rs.getInt("notice_no"));
//				noticeDto.setUserId(rs.getString("user_id"));
//				noticeDto.setSubject(rs.getString("subject"));
//				noticeDto.setContent(rs.getString("content"));
//				noticeDto.setRegisterTime(rs.getString("register_time"));
//				
//				notices.add(noticeDto);
//			}
//		}
//		finally {
//			dbUtil.close(rs, pstmt, conn);
//		}
//		
//		return notices;
//	}
//
//	public int delete(String noticeNo) throws SQLException {
//		Connection conn = null;
//		PreparedStatement pstmt =null;
//		int cnt=0;
//		
//		try {
//			conn = dbUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("delete from notice \n");
//			sql.append("where notice_no = ? \n");
//			pstmt = conn.prepareStatement(sql.toString());
//			
//			pstmt.setInt(1, Integer.parseInt(noticeNo));
//			
//			//insert 결과 얻어오기
//			cnt = pstmt.executeUpdate();
//		}
//		finally {
//			dbUtil.close(pstmt, conn);
//		}
//		return cnt;
//	}
//
//	public NoticeDto getNotice(String noticeNo) throws SQLException {
//		Connection conn = null;
//		PreparedStatement pstmt =null;
//		ResultSet rs = null;
//		NoticeDto notice= null;
//		
//		try {
//			conn = dbUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("select notice_no, user_id, subject, content, register_time \n");
//			sql.append("from notice \n");
//			sql.append("where notice_no = ? \n");
//			pstmt = conn.prepareStatement(sql.toString());
//			
//			
//			pstmt.setInt(1, Integer.parseInt(noticeNo));
//			rs = pstmt.executeQuery();
//			
//			if(rs.next()) {
//				notice = new NoticeDto();
//				
//				notice.setNoticeNo(rs.getInt("notice_no"));
//				notice.setUserId(rs.getString("user_id"));
//				notice.setSubject(rs.getString("subject"));
//				notice.setContent(rs.getString("content"));
//				notice.setRegisterTime(rs.getString("register_time"));
//			}
//		}
//		finally {
//			dbUtil.close(rs, pstmt, conn);
//		}
//		
//		return notice;
//	}
//
//	public int modify(NoticeDto noticeDto) throws SQLException {
//		Connection conn = null;
//		PreparedStatement pstmt =null;
//		int cnt=0;
//		try {
//			conn = dbUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("update notice set subject = ?, content = ? \n");
//			sql.append("where notice_no = ? \n");
//			pstmt = conn.prepareStatement(sql.toString());
//			
//			pstmt.setString(1, noticeDto.getSubject());
//			pstmt.setString(2, noticeDto.getContent());
//			pstmt.setInt(3, noticeDto.getNoticeNo());
//			
//			//insert 결과 얻어오기
//			cnt = pstmt.executeUpdate();
//		}
//		finally {
//			dbUtil.close(pstmt, conn);
//		}
//		return cnt;
//	}
//
//}
