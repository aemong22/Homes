package com.ssafy.pjt.concern.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.pjt.concern.dto.ConcernDto;

public interface ConcernService {
	boolean register(Map<String, Object> map);
	List<ConcernDto> getlist(String userId);
	int countlist(String userId);
	int deleteAll(String userId);
	int countlistAll();
	String hashShop(String name);
	boolean ckConcern(Map<String, Object> map);
	boolean deleteConcern(Map<String, Object> map);
}
