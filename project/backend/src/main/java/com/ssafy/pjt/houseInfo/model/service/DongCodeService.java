package com.ssafy.pjt.houseInfo.model.service;

import java.util.List;
import java.util.Map;

public interface DongCodeService {
	List<Map<String, Object>> getSidoNames();
	List<Map<String, Object>> getGugunNames(String sidoCode);
	List<Map<String, Object>> getDongNames(String gugunCode);
}
