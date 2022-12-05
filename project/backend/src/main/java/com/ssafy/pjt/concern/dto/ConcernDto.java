package com.ssafy.pjt.concern.dto;

public class ConcernDto {
	private int concernId;
	private String userId;
	private String juso;
	private String dongCode;
	
	
	public String getDongCode() {
		return dongCode;
	}

	public void setDongCode(String dongCode) {
		this.dongCode = dongCode;
	}

	public ConcernDto() {}
	
	@Override
	public String toString() {
		return "ConcernDto [userId=" + userId + ", juso=" + juso + "]";
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getJuso() {
		return juso;
	}

	public void setJuso(String juso) {
		this.juso = juso;
	}

	public int getConcernId() {
		return concernId;
	}

	public void setConcernId(int concernId) {
		this.concernId = concernId;
	}
	
}
