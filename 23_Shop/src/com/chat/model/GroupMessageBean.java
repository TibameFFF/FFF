package com.chat.model;

import java.io.Serializable;

public class GroupMessageBean implements Serializable{
	private static final long serialVersionUID = 1L;

	private Integer id;
	private String userName;
	private String message;
	private String date;
	


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}




	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	
	
}
