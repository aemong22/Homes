package com.ssafy.pjt.houseInfo.model.mapper;

import java.util.List;
import java.util.Map;

public interface DongCodeDao {
	List<Map<String, Object>> getSidoNames();
	int getSidoNameCount();
	List<Map<String, Object>> getGugunNames(String sidoCode);
	List<Map<String, Object>> getDongNames(String gugunCode);
}
