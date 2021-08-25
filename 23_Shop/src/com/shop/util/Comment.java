package com.shop.util;

import java.io.Serializable;
import java.util.List;

public class Comment implements Serializable{
	private String name;
	private String userPic;
	private Integer star;
	private String text;
	private List<String> pic;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserPic() {
		return userPic;
	}
	public void setUserPic(String userPic) {
		this.userPic = userPic;
	}
	public Integer getStar() {
		return star;
	}
	public void setStar(Integer star) {
		this.star = star;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public List<String> getPic() {
		return pic;
	}
	public void setPic(List<String> pic) {
		this.pic = pic;
	}
	@Override
	public String toString() {
		return "Comment [name=" + name + ", userPic=" + userPic + ", star=" + star + ", text=" + text + ", pic=" + pic
				+ "]";
	}
	
	
}
