package com.shop.model;

import java.io.Serializable;
import java.util.Arrays;

public class OrderProd implements Serializable {
	@Override
	public String toString() {
		return "OrderProd [ord_prod_id=" + ord_prod_id + ", ord_no=" + ord_no + ", prod_spec_id=" + prod_spec_id
				+ ", hist_prod_name=" + hist_prod_name + ", hist_prod_spec=" + hist_prod_spec + ", hist_prod_price="
				+ hist_prod_price + ", prod_num=" + prod_num + ", hist_prod_pic=" + Arrays.toString(hist_prod_pic)
				+ ", eval_star=" + eval_star + ", eval_text=" + eval_text + ", re_ex_reason=" + re_ex_reason
				+ ", re_ex_detail=" + re_ex_detail + ", re_ex_price=" + re_ex_price + ", re_ex_num=" + re_ex_num
				+ ", re_ex_pic=" + Arrays.toString(re_ex_pic) + "]";
	}
	private Integer ord_prod_id;
	private Integer ord_no;
	private Integer prod_spec_id;
	private String hist_prod_name;
	private String hist_prod_spec;
	private Integer hist_prod_price;
	private Integer prod_num;
	private byte[] hist_prod_pic;
	private Integer eval_star;
	private String eval_text;
	private String re_ex_reason;
	private String re_ex_detail;
	private Integer re_ex_price;
	private Integer re_ex_num;
	private byte[] re_ex_pic;
	
	
	public Integer getOrd_prod_id() {
		return ord_prod_id;
	}
	public void setOrd_prod_id(Integer ord_prod_id) {
		this.ord_prod_id = ord_prod_id;
	}
	public Integer getOrd_no() {
		return ord_no;
	}
	public void setOrd_no(Integer ord_no) {
		this.ord_no = ord_no;
	}
	public Integer getProd_spec_id() {
		return prod_spec_id;
	}
	public void setProd_spec_id(Integer prod_spec_id) {
		this.prod_spec_id = prod_spec_id;
	}
	public String getHist_prod_name() {
		return hist_prod_name;
	}
	public void setHist_prod_name(String hist_prod_name) {
		this.hist_prod_name = hist_prod_name;
	}
	public String getHist_prod_spec() {
		return hist_prod_spec;
	}
	public void setHist_prod_spec(String hist_prod_spec) {
		this.hist_prod_spec = hist_prod_spec;
	}
	public Integer getHist_prod_price() {
		return hist_prod_price;
	}
	public void setHist_prod_price(Integer hist_prod_price) {
		this.hist_prod_price = hist_prod_price;
	}
	public Integer getProd_num() {
		return prod_num;
	}
	public void setProd_num(Integer prod_num) {
		this.prod_num = prod_num;
	}
	public byte[] getHist_prod_pic() {
		return hist_prod_pic;
	}
	public void setHist_prod_pic(byte[] hist_prod_pic) {
		this.hist_prod_pic = hist_prod_pic;
	}
	public Integer getEval_star() {
		return eval_star;
	}
	public void setEval_star(Integer eval_star) {
		this.eval_star = eval_star;
	}
	public String getEval_text() {
		return eval_text;
	}
	public void setEval_text(String eval_text) {
		this.eval_text = eval_text;
	}
	public String getRe_ex_reason() {
		return re_ex_reason;
	}
	public void setRe_ex_reason(String re_ex_reason) {
		this.re_ex_reason = re_ex_reason;
	}
	public String getRe_ex_detail() {
		return re_ex_detail;
	}
	public void setRe_ex_detail(String re_ex_detail) {
		this.re_ex_detail = re_ex_detail;
	}
	public Integer getRe_ex_price() {
		return re_ex_price;
	}
	public void setRe_ex_price(Integer re_ex_price) {
		this.re_ex_price = re_ex_price;
	}
	public Integer getRe_ex_num() {
		return re_ex_num;
	}
	public void setRe_ex_num(Integer re_ex_num) {
		this.re_ex_num = re_ex_num;
	}
	public byte[] getRe_ex_pic() {
		return re_ex_pic;
	}
	public void setRe_ex_pic(byte[] re_ex_pic) {
		this.re_ex_pic = re_ex_pic;
	}
}
