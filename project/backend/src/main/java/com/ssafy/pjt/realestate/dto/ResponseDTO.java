package com.ssafy.pjt.realestate.dto;

public class ResponseDTO {
    private String msg;
    private String errMsg;
    private String status;
    private int statusCode;
    private Object body;
    
    public ResponseDTO() {
    	
    }
	public ResponseDTO(String msg, String errMsg, String status, int statusCode, Object body) {
		super();
		this.msg = msg;
		this.errMsg = errMsg;
		this.status = status;
		this.statusCode = statusCode;
		this.body = body;
	}
    
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getErrMsg() {
		return errMsg;
	}
	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getStatusCode() {
		return statusCode;
	}
	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}
	public Object getBody() {
		return body;
	}
	public void setBody(Object body) {
		this.body = body;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ResponseDTO [msg=");
		builder.append(msg);
		builder.append(", errMsg=");
		builder.append(errMsg);
		builder.append(", status=");
		builder.append(status);
		builder.append(", statusCode=");
		builder.append(statusCode);
		builder.append(", body=");
		builder.append(body);
		builder.append("]");
		return builder.toString();
	}
	
	
	
	
    
}
