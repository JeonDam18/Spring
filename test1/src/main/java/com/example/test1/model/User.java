package com.example.test1.model;

import lombok.Data;

@Data
public class User {
	
	private String userId;
	private String pwd;
	private String userName;
	private String email;
	private String phone;
	private String gender;
	private String status;
	
	public String getUserId() {
		return userId;
	}
	public String getStatus() {
		return status;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPwd() {
		return pwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
}
