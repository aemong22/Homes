package com.ssafy.pjt.remove;
//package com.ssafy.pjt.member.model.service;
//
//import java.sql.SQLException;
//import java.util.List;
//
//import com.ssafy.pjt.member.MemberDto;
//import com.ssafy.pjt.member.model.mapper.MemberDao2;
//
//public class MemberService2 {
//	
//	private MemberDao2 memberDao = new MemberDao2();
//
//	
//	public int idCheck(String userId) throws SQLException {
//		int cnt =  memberDao.idCheck(userId);
//		return cnt;
//	}
//
//	public void joinMember(MemberDto memberDto) throws SQLException {
//		memberDao.joinMember(memberDto);
//		
//	}
//
//	public MemberDto loginMember(String userId, String userPwd) throws SQLException {
//		return memberDao.loginMember(userId, userPwd);
//	}
//
//	public MemberDto mypage(String userId) throws SQLException {
//		return memberDao.mypage(userId);
//	}
//
//	public void delete(String userId) throws SQLException {
//		memberDao.delete(userId);
//	}
//
//	public void editProfile(MemberDto memberDto) throws SQLException {
//		memberDao.editProfile(memberDto);
//		
//	}
//
//	public List<MemberDto> getlist() throws SQLException {
//		return memberDao.getList();
//	}
//
//
//
//}
