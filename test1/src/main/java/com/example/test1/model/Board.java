package com.example.test1.model;

import lombok.Data;

@Data
public class Board {
	private String boardNo;
	private String title;
	private String userId;
	private String hit;
	private String cdateTime;
	private String contents;
	private String category;
	private String favorite;
	private String tag1;
	private String tag2;
	private String noticeyn;
	private String udateTime;
	
	private String userName;
	
	private String fileNo;
	private String fileName;
	private String fileOrgName;
	private String filePath;
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	private String fileSize;
	private String fileExt;
	private String thumbNailYn;
	
	private String count;
	
}
