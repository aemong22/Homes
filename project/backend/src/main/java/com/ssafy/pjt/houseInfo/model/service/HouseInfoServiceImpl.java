package com.ssafy.pjt.houseInfo.model.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.pjt.houseInfo.dto.HouseCombDealDto;
import com.ssafy.pjt.houseInfo.dto.HouseCombDto;
import com.ssafy.pjt.houseInfo.dto.HouseInfoDto;
import com.ssafy.pjt.houseInfo.model.mapper.HouseInfoDao;
@Service
public class HouseInfoServiceImpl implements HouseInfoService{
	
	private HouseInfoDao houseInfoDao;

	@Autowired
	public HouseInfoServiceImpl(HouseInfoDao houseInfoDao) {
		this.houseInfoDao = houseInfoDao;
	}

	@Override
	public List<HouseCombDto> getHouseDeal(Map<String, Object> map) {
		return houseInfoDao.getHouseDeal(map);
	}

	@Override
	public HouseCombDto selectApt(long no) {
		return houseInfoDao.selectApt(no);
	}
	
	@Override
	public Map<String, Object> getJutaek(String code, String dealYM) throws Exception {
		StringBuilder urlBuilder = new StringBuilder("http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcRHTrade"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=1CCpQofcu%2BF732VXbRualdEBulu%2BXJO9eWA4Y69MOKFgF2RC2mEJ8VGNS4xoDPgLGfH0AU9h0ED1l8s121pL0A%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("LAWD_CD","UTF-8") + "=" + URLEncoder.encode(code, "UTF-8")); /*각 지역별 코드*/
        urlBuilder.append("&" + URLEncoder.encode("DEAL_YMD","UTF-8") + "=" + URLEncoder.encode(dealYM, "UTF-8")); /*월 단위 신고자료*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        JSONObject json = XML.toJSONObject(sb.toString());

		Map<String, Object> result = new ObjectMapper().readValue(json.toString(), Map.class);
		return result;
	}

	@Override
	public List<HouseInfoDto> selectHouseInfolist() {
		return houseInfoDao.selectHouseInfolist();
	}

	@Override
	public HouseInfoDto selectHouseInfoOne(long aptCode) {
		return houseInfoDao.selectHouseInfoOne(aptCode);
	}


	@Override
	public List<HouseCombDealDto> getAptDealHistory(String aptCode) {
		return houseInfoDao.getAptDealHistory(aptCode);
	}

	@Override
	public List<Map<String, Object>> getAvgDealBydealYear() {
		return houseInfoDao.getAvgDealBydealYear();
	}

	@Override
	public List<Map<String, Object>> getAvgDealBydealYearConcern(List<String> list) {
		return houseInfoDao.getAvgDealBydealYearConcern(list);
	}
}
