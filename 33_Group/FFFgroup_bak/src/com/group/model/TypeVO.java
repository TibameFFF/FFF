package com.group.model;

public class TypeVO implements java.io.Serializable {
	private Integer g_type_no;
	private String g_type;
	
	public TypeVO() {
		super();
	}
	public Integer getG_type_no() {
		return g_type_no;
	}
	public void setG_type_no(Integer g_type_no) {
		this.g_type_no = g_type_no;
	}
	public String getG_type() {
		return g_type;
	}
	public void setG_type(String g_type) {
		this.g_type = g_type;
	}
	@Override
	public String toString() {
		return "TypeVO [g_type_no=" + g_type_no + ", g_type=" + g_type + "]";
	}
	
}
