package com.ssafy.pjt.concern.model.mapper;

import java.util.List;
import java.util.Map;

import com.ssafy.pjt.concern.dto.ConcernDto;

public interface ConcernDao {
	int register(Map<String, Object> map);
	List<ConcernDto> getlist(String userId);
	int countlist(String userId);
	int deleteAll(String userId);
	int countlistAll();
	int ckConcern(Map<String, Object> map);
	int deleteConcern(Map<String, Object> map);
}
