package com.hxzy.bean;
/**
 * 试题选项实体类
 * @author home
 *
 */
public class Option {
	
	private int id;//选项id
	private String opcontent ;//选项内容
	private int qid;//试题id
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOpcontent() {
		return opcontent;
	}
	public void setOpcontent(String opcontent) {
		this.opcontent = opcontent;
	}
	public int getQid() {
		return qid;
	}
	public void setQid(int qid) {
		this.qid = qid;
	}
	public Option(int id, String opcontent, int qid) {
		super();
		this.id = id;
		this.opcontent = opcontent;
		this.qid = qid;
	}
	public Option() {
		super();
	}
	@Override
	public String toString() {
		return "Option [id=" + id + ", opcontent=" + opcontent + ", qid=" + qid + "]";
	}
	

}
