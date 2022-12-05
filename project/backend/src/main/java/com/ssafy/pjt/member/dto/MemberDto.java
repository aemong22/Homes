package com.ssafy.pjt.member.dto;

public class MemberDto {

	private String userId;
	private String userName;
	private String userPwd;
	private String emailId;
	private String emailDomain;
	private String phonenumber;
	private String address;
	private Boolean admin;


	public MemberDto() {

	}


	public MemberDto(String userId, String userName, String userPwd, String emailId, String emailDomain,
			String phonenumber, String address, Boolean admin) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.userPwd = userPwd;
		this.emailId = emailId;
		this.emailDomain = emailDomain;
		this.phonenumber = phonenumber;
		this.address = address;
		this.admin = admin;
	}


	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getEmailDomain() {
		return emailDomain;
	}
	public void setEmailDomain(String emailDomain) {
		this.emailDomain = emailDomain;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Boolean getAdmin() {
		return admin;
	}
	public void setAdmin(Boolean admin) {
		this.admin = admin;
	}


	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("MemberDto [userId=");
		builder.append(userId);
		builder.append(", userName=");
		builder.append(userName);
		builder.append(", userPwd=");
		builder.append(userPwd);
		builder.append(", emailId=");
		builder.append(emailId);
		builder.append(", emailDomain=");
		builder.append(emailDomain);
		builder.append(", phonenumber=");
		builder.append(phonenumber);
		builder.append(", address=");
		builder.append(address);
		builder.append(", admin=");
		builder.append(admin);
		builder.append("]");
		return builder.toString();
	}


}
