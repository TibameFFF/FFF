package com.chat.model;

import java.io.Serializable;

public class GroupChat implements Serializable{
	private Integer chat_no;
	private Integer chat_theme_no;
	private Integer chat_leader;
	private String chat_name;
	private String chat_theme;
	public Integer getChat_no() {
		return chat_no;
	}
	public void setChat_no(Integer chat_no) {
		this.chat_no = chat_no;
	}
	public Integer getChat_theme_no() {
		return chat_theme_no;
	}
	public void setChat_theme_no(Integer chat_theme_no) {
		this.chat_theme_no = chat_theme_no;
	}
	public Integer getChat_leader() {
		return chat_leader;
	}
	public void setChat_leader(Integer chat_leader) {
		this.chat_leader = chat_leader;
	}
	public String getChat_name() {
		return chat_name;
	}
	public void setChat_name(String chat_name) {
		this.chat_name = chat_name;
	}
	public String getChat_theme() {
		return chat_theme;
	}
	public void setChat_theme(String chat_theme) {
		this.chat_theme = chat_theme;
	}
	@Override
	public String toString() {
		return "GroupChat [chat_no=" + chat_no + ", chat_theme_no=" + chat_theme_no + ", chat_leader=" + chat_leader
				+ ", chat_name=" + chat_name + ", chat_theme=" + chat_theme + "]";
	}
	
	
}
