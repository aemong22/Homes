package com.ssafy.pjt.remove;
//package com.ssafy.pjt.member.model.mapper;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//
//import com.ssafy.pjt.member.MemberDto;
//import com.ssafy.pjt.util.DBUtil;
//
//public class MemberDao2 {
//
//	private DBUtil dbUtil = DBUtil.getInstance();
//
//	public int idCheck(String userId) throws SQLException {
//		int cnt = 1;
//
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//			conn = dbUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("select count(user_id) \n");
//			sql.append("from members \n");
//			sql.append("where user_id = ?");
//
//
//			pstmt = conn.prepareStatement(sql.toString());
//			pstmt.setString(1, userId);
//
//			rs = pstmt.executeQuery();
//			rs.next();
//			cnt = rs.getInt(1);
//		}
//		finally {
//			dbUtil.close(rs, pstmt, conn);
//		}
//
//		return cnt;
//	}
//
//
//	public int joinMember(MemberDto memberDto) throws SQLException {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//
//		try {
//			conn = dbUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("INSERT INTO members (user_id, user_name, user_password, email_id, email_domain,user_phone, address) \n");
//			sql.append("VALUES (?, ?, ?, ?, ?, ?, ?)");
//			pstmt = conn.prepareStatement(sql.toString());
//			int idx = 0;
//			pstmt.setString(++idx, memberDto.getUserId());
//			pstmt.setString(++idx, memberDto.getUserName());
//			pstmt.setString(++idx, memberDto.getUserPwd());
//			pstmt.setString(++idx, memberDto.getEmailId());
//			pstmt.setString(++idx, memberDto.getEmailDomain());
//			pstmt.setString(++idx, memberDto.getPhonenumber());
//			pstmt.setString(++idx, memberDto.getAddress());
//			pstmt.executeUpdate();
//		}
//		finally {
//			dbUtil.close(pstmt, conn);
//		}
//
//		return 0;
//	}
//
//
//	public MemberDto loginMember(String userId, String userPwd) throws SQLException {
//
//		MemberDto memberDto = null;
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//			conn = dbUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("SELECT user_id, user_name , admin \n");
//			sql.append("FROM members \n");
//			sql.append("WHERE user_id = ? AND user_password = ?");
//
//			pstmt = conn.prepareStatement(sql.toString());
//			pstmt.setString(1, userId);
//			pstmt.setString(2, userPwd);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				memberDto = new MemberDto();
//				memberDto.setUserId(rs.getString("user_id"));
//				memberDto.setUserName(rs.getString("user_name"));
//				memberDto.setAdmin(rs.getBoolean("admin"));
//			}
//		}
//		finally {
//			dbUtil.close(rs, pstmt, conn);
//		}
//
//		return memberDto;
//
//	}
//
//
//	public MemberDto mypage(String userId) throws SQLException {
//
//		MemberDto memberDto = null;
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//			conn = dbUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("SELECT * \n");
//			sql.append("FROM members \n");
//			sql.append("WHERE user_id = ?");
//
//			pstmt = conn.prepareStatement(sql.toString());
//			pstmt.setString(1, userId);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				memberDto = new MemberDto();
//				memberDto.setUserId(rs.getString("user_id"));
//				memberDto.setUserName(rs.getString("user_name"));
//				memberDto.setUserPwd(rs.getString("user_password"));
//				memberDto.setEmailId(rs.getString("email_id"));
//				memberDto.setEmailDomain(rs.getString("email_domain"));
//				memberDto.setPhonenumber(rs.getString("user_phone"));
//				memberDto.setAddress(rs.getString("address"));
//				memberDto.setAdmin(rs.getBoolean("admin"));
//			}
//		}
//		finally {
//			dbUtil.close(rs, pstmt, conn);
//		}
//
//		return memberDto;
//	}
//
//
//	public void delete(String userId) throws SQLException {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//
//		try {
//			conn = dbUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("DELETE FROM members \n");
//			sql.append("WHERE user_id = ? \n");
//			pstmt = conn.prepareStatement(sql.toString());
//			pstmt.setString(1, userId);
//			pstmt.executeUpdate();
//		}
//		finally {
//			dbUtil.close(pstmt, conn);
//		}
//	}
//
//
//	public void editProfile(MemberDto memberDto) throws SQLException {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//
//		try {
//			conn = dbUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("UPDATE members \n");
//			sql.append("SET user_name = ?, user_password = ?, email_id = ?, email_domain = ?, user_phone = ?, address = ?");
//			sql.append("WHERE user_id = ? \n");
//			pstmt = conn.prepareStatement(sql.toString());
//			pstmt.setString(1, memberDto.getUserName());
//			pstmt.setString(2, memberDto.getUserPwd());
//			pstmt.setString(3, memberDto.getEmailId());
//			pstmt.setString(4, memberDto.getEmailDomain());
//			pstmt.setString(5, memberDto.getPhonenumber());
//			pstmt.setString(6, memberDto.getAddress());
//			pstmt.setString(7, memberDto.getUserId());
//
//			pstmt.executeUpdate();
//		}
//		finally {
//			dbUtil.close(pstmt, conn);
//		}
//	}
//
//
//	public List<MemberDto> getList() throws SQLException {
//		Connection conn = null;
//		PreparedStatement pstmt =null;
//		ResultSet rs = null;
//		List<MemberDto> members= new ArrayList<>();
//		
//		try {
//			conn = dbUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("select * \n");
//			sql.append("from members \n");
//			sql.append("order by user_id \n");
//			pstmt = conn.prepareStatement(sql.toString());
//			rs = pstmt.executeQuery();
//			
//			//rs 결과 list 에 담기
//			while(rs.next()) {
//				MemberDto member = new MemberDto();
//				member.setAdmin(rs.getBoolean("admin"));
//				member.setUserId(rs.getString("user_id"));
//				member.setUserPwd(rs.getString("user_password"));
//				member.setUserName(rs.getString("user_name"));
//				member.setEmailId(rs.getString("email_id"));
//				member.setEmailDomain(rs.getString("email_domain"));
//				member.setPhonenumber(rs.getString("user_phone"));
//				member.setAddress(rs.getString("address"));
//				members.add(member);
//			}
//		}
//		finally {
//			dbUtil.close(rs, pstmt, conn);
//		}
//		
//		return members;
//	}
//
//
//
//}
