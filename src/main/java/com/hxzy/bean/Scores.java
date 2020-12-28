package com.hxzy.bean;

import java.sql.Date;

/**
 * 成绩实体类
 * @author tiantian
 */
public class Scores {
    private String scid; //成绩id
    private Date begintime;//考试开始时间
    private double  scores;//分数
    private Paper paper ;//试卷id
    private User user;//用户id
    private String myanswer;//答案
    private String usetimes;//使用时间
    private String sanswers;//正确答案
    
    
	public String getSanswers() {
		return sanswers;
	}
	public void setSanswers(String sanswers) {
		this.sanswers = sanswers;
	}
	public Paper getPaper() {
		return paper;
	}
	public void setPaper(Paper paper) {
		this.paper = paper;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getScid() {
		return scid;
	}
	public void setScid(String scid) {
		this.scid = scid;
	}
	public Date getBegintime() {
		return begintime;
	}
	public void setBegintime(Date date) {
		this.begintime = date;
	}
	public double getScores() {
		return scores;
	}
	public void setScores(double scores) {
		this.scores = scores;
	}
	
	public String getMyanswer() {
		return myanswer;
	}
	public void setMyanswer(String myanswer) {
		this.myanswer = myanswer;
	}
	public String getUsetimes() {
		return usetimes;
	}
	public void setUsetimes(String usetimes) {
		this.usetimes = usetimes;
	}
	@Override
	public String toString() {
		return "Scores [scid=" + scid + ", begintime=" + begintime + ", scores=" + scores + ", paper=" + paper
				+ ", user=" + user + ", myanswer=" + myanswer + ", usetimes=" + usetimes + "]";
	}
	
    
}
