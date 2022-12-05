package com.ssafy.pjt.member.model.service;

import java.util.List;

import com.ssafy.pjt.member.dto.MemberDto;

public interface MemberService {

	MemberDto login(MemberDto member);

	int join(MemberDto member);

	int idCheck(String userId);

	MemberDto getUser(String userId);

	int editUserInfo(MemberDto member);

	int deleteMember(String id);

	List<MemberDto> getUsers();

	List<MemberDto> searchUsers(String userId);

	void saveRefreshToken(String userId, String refreshToken);

	void deleRefreshToken(String userid);

	Object getRefreshToken(String userId);

	MemberDto getPw(String emailId, String emailDomain);
}
