package com.chat.model;

import java.io.Serializable;

public class Friend implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer friend_list_id;
	private Integer friend_id;
	private Integer user_id;
	private Integer friend_mode;
	private Boolean notification = false;
	private String lastMessage;
	
	
	public String getLastMessage() {
		return lastMessage;
	}
	public void setLastMessage(String lastMessage) {
		this.lastMessage = lastMessage;
	}
	public Boolean getNotification() {
		return notification;
	}
	public void setNotification(Boolean notification) {
		this.notification = notification;
	}
	public Integer getFriend_list_id() {
		return friend_list_id;
	}
	public void setFriend_list_id(Integer friend_list_id) {
		this.friend_list_id = friend_list_id;
	}
	public Integer getFriend_id() {
		return friend_id;
	}
	public void setFriend_id(Integer friend_id) {
		this.friend_id = friend_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Integer getFriend_mode() {
		return friend_mode;
	}
	public void setFriend_mode(Integer friend_mode) {
		this.friend_mode = friend_mode;
	}
	@Override
	public String toString() {
		return "Friend [friend_list_id=" + friend_list_id + ", friend_id=" + friend_id + ", user_id=" + user_id
				+ ", friend_mode=" + friend_mode + "]";
	}
	
	
}
