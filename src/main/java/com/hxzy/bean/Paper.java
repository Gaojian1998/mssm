package com.hxzy.bean;




import java.sql.Timestamp;

/**
 * 试卷实体类
 * @author Administrator
 *
 */
public class Paper {
	//试卷id
	private int pid;
	//试卷名字
	private String pname;
	//考试时长
	private int ptimes;
	//考试开始时间
	
	private Timestamp statime;
	//试卷试题id
	private String qids;
	//试卷状态
	private String status;
	//技能题路径
	private String url;
	//试卷课程类型
	private String pcourse;
	private Scores scores; //试卷分数
	
	
	
	public Paper() {
		super();
		// TODO Auto-generated constructor stub
	}


	public Paper(int pid, String pname, int ptimes, Timestamp statime,
			String qids, String status, String url, String pcourse) {
		super();
		this.pid = pid;
		this.pname = pname;
		this.ptimes = ptimes;
		this.statime = statime;
		this.qids = qids;
		this.status = status;
		this.url = url;
		this.pcourse = pcourse;
	}

    
	public Scores getScores() {
		return scores;
	}


	public void setScores(Scores scores) {
		this.scores = scores;
	}


	public String getPcourse() {
		return pcourse;
	}


	public void setPcourse(String pcourse) {
		this.pcourse = pcourse;
	}


	public int getPid() {
		return pid;
	}


	public void setPid(int pid) {
		this.pid = pid;
	}


	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public int getPtimes() {
		return ptimes;
	}

	public void setPtimes(int ptimes) {
		this.ptimes = ptimes;
	}
    

	public Timestamp getStatime() {
		return statime;
	}


	public void setStatime(Timestamp statime) {
		this.statime = statime;
	}


	public String getQids() {
		return qids;
	}

	public void setQids(String qids) {
		this.qids = qids;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}


	@Override
	public String toString() {
		return "Paper [pid=" + pid + ", pname=" + pname + ", ptimes=" + ptimes + ", statime=" + statime + ", qids="
				+ qids + ", status=" + status + ", url=" + url + ", pcourse=" + pcourse + ", scores=" + scores + "]";
	}


	
	


}
