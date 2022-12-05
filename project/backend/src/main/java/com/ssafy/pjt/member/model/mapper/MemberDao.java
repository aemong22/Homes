package com.ssafy.pjt.member.model.mapper;

import java.util.List;
import java.util.Map;

import com.ssafy.pjt.member.dto.MemberDto;

public interface MemberDao {

	MemberDto login(MemberDto member);

	int insert(MemberDto member);

	int getCount(String userId);

	MemberDto select(String userId);

	int update(MemberDto member);

	int delete(String id);

	List<MemberDto> getUsers();

	List<MemberDto> searchUsers(String userId);

	void saveRefreshToken(Map<String, String> map);

	Object getRefreshToken(String userId);

	void deleteRefreshToken(Map<String, String> map);

	MemberDto getPw(String emailId, String emailDomain);

}
