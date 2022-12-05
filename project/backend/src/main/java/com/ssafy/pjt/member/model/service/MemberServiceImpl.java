package com.ssafy.pjt.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.pjt.member.dto.MemberDto;
import com.ssafy.pjt.member.model.mapper.MemberDao;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private SqlSession sqlSession;
	
	private final MemberDao memberDao;
	
	@Autowired
	public MemberServiceImpl(MemberDao userDao) {
		this.memberDao = userDao;
	}

	@Override
	public MemberDto login(MemberDto member) {
		return memberDao.login(member);
	}

	@Override
	public int join(MemberDto member) {
		return memberDao.insert(member);
	}

	@Override
	public int idCheck(String userId) {
		return memberDao.getCount(userId);
	}

	@Override
	public MemberDto getUser(String userId) {
		return memberDao.select(userId);
	}

	@Override
	public int editUserInfo(MemberDto member) {
		return memberDao.update(member);
	}

	@Override
	public int deleteMember(String id) {
		return memberDao.delete(id);
	}

	@Override
	public List<MemberDto> getUsers() {
		return memberDao.getUsers();
	}

	@Override
	public List<MemberDto> searchUsers(String userId) {
		return memberDao.searchUsers(userId);
	}

	@Override
	public void saveRefreshToken(String userId, String refreshToken) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userid", userId);
		map.put("token", refreshToken);
		sqlSession.getMapper(MemberDao.class).saveRefreshToken(map);
		
	}

	@Override
	public void deleRefreshToken(String userid) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("token", null);
		sqlSession.getMapper(MemberDao.class).deleteRefreshToken(map);
	}

	@Override
	public Object getRefreshToken(String userId) {
		return sqlSession.getMapper(MemberDao.class).getRefreshToken(userId);
	}

	@Override
	public MemberDto getPw(String emailId, String emailDomain) {
		return memberDao.getPw(emailId, emailDomain);
	} 

}
