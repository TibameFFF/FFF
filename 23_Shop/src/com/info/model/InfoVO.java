package com.info.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class InfoVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer user_id;
	private Integer user_status;
	private String user_nickname;
	private String user_name;
	private String account;
	private String email;
	private Date bitrhday;
	private String password;
	private Integer sex;
	private Integer mapping;
	private Integer age_min;
	private Integer age_max;
	private Integer mapping_sex;
	private byte[] photo;
	private String intro;
	private Timestamp created_time;
	private Integer violation_count;

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public Integer getUser_status() {
		return user_status;
	}

	public void setUser_status(Integer user_status) {
		this.user_status = user_status;
	}

	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getBitrhday() {
		return bitrhday;
	}

	public void setBitrhday(Date bitrhday) {
		this.bitrhday = bitrhday;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Integer getMapping() {
		return mapping;
	}

	public void setMapping(Integer mapping) {
		this.mapping = mapping;
	}

	public Integer getAge_min() {
		return age_min;
	}

	public void setAge_min(Integer age_min) {
		this.age_min = age_min;
	}

	public Integer getAge_max() {
		return age_max;
	}

	public void setAge_max(Integer age_max) {
		this.age_max = age_max;
	}

	public Integer getMapping_sex() {
		return mapping_sex;
	}

	public void setMapping_sex(Integer mapping_sex) {
		this.mapping_sex = mapping_sex;
	}

	public byte[] getPhoto() {
		return photo;
	}

	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public Timestamp getCreated_time() {
		return created_time;
	}

	public void setCreated_time(Timestamp created_time) {
		this.created_time = created_time;
	}

	public Integer getViolation_count() {
		return violation_count;
	}

	public void setViolation_count(Integer violation_count) {
		this.violation_count = violation_count;
	}

	@Override
	public String toString() {
		return "InfoVO [user_id=" + user_id + ", user_status=" + user_status + ", user_nickname=" + user_nickname
				+ ", user_name=" + user_name + ", account=" + account + ", email=" + email + ", bitrhday=" + bitrhday
				+ ", password=" + password + ", sex=" + sex + ", mapping=" + mapping + ", age_min=" + age_min
				+ ", age_max=" + age_max + ", mapping_sex=" + mapping_sex + ", photo=" + photo
				+ ", intro=" + intro + ", created_time=" + created_time + ", violation_count=" + violation_count + "]";
	}

}
