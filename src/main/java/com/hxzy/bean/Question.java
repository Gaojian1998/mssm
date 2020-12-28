package com.hxzy.bean;

import java.util.List;

public class Question {
	
	private int id;  //		问题id
	private String  qanswer;	 //		问题正确答案
	private String  qname;	//			问题描述
	private double qscore;	//		问题分值
	private String qtype;  //		问题类型 1单选  2多选  3判断
	private String   qcourse;	//	专业类别 8java  9大数据 10UI设计 11AI智能 12网络营销
	private String   qstage;	//	专业阶段 4 第一阶段 5 第一阶段 6 第一阶段 7 第一阶段
	private List<Option> options; //试题对应的选项
	
	public List<Option> getOptions() {
		return options;
	}
	public void setOptions(List<Option> options) {
		this.options = options;
	}
	//构造方法
	public Question() {
		
	}
	public Question(int id, String qanswer, String qname, double qscore,
			String qtype,String qcourse, String qstage) {
		this.id = id;
		this.qanswer = qanswer;
		this.qname = qname;
		this.qscore = qscore;
		this.qtype = qtype;
		this.qcourse = qcourse;
		this.qstage = qstage;
	}
    //get、set方法
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getQanswer() {
		return qanswer;
	}
	public void setQanswer(String qanswer) {
		this.qanswer = qanswer;
	}


	public String getQname() {
		return qname;
	}
	public void setQname(String qname) {
		this.qname = qname;
	}


	public double getQscore() {
		return qscore;
	}
	public void setQscore(double qscore) {
		this.qscore = qscore;
	}


	public String getQtype() {
		return qtype;
	}
	public void setQtype(String qtype) {
		this.qtype = qtype;
	}


	public String getQcourse() {
		return qcourse;
	}
	public void setQcourse(String qcourse) {
		this.qcourse = qcourse;
	}


	public String getQstage() {
		return qstage;
	}
	public void setQstage(String qstage) {
		this.qstage = qstage;
	}
	@Override
	public String toString() {
		return "Question [id=" + id + ", qanswer=" + qanswer + ", qname=" + qname + ", qscore=" + qscore + ", qtype="
				+ qtype + ", qcourse=" + qcourse + ", qstage=" + qstage + ", options=" + options + "]";
	}


	
	
	
}
