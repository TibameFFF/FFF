package com.chat.model;

import java.io.Serializable;

public class FriendMessageBean implements Serializable{
	private static final long serialVersionUID = 1L;

	private Integer who;
	private String friendName;
	private String message;
	private String date;
	
	public Integer getWho() {
		return who;
	}
	public void setWho(Integer who) {
		this.who = who;
	}
	public String getFriendName() {
		return friendName;
	}
	public void setFriendName(String friendName) {
		this.friendName = friendName;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	


	
	
	
}
