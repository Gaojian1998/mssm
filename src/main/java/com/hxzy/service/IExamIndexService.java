package com.hxzy.service;

import com.hxzy.bean.Paper;
import com.hxzy.bean.Scores;

import java.util.List;

/**
 * 考试主页面
 * @author home
 *
 */
public interface IExamIndexService {
	/**
	 * 获取考试信息
	 * @param current 用户登录的当前时间
	 * @return 考试信息
	 */
	public List<Paper> getExamInfo(String current);
	 /**
	     *  成绩信息
	 * @param pid
	 * @return
	 */
    public Scores getExamScore(String pid, String userid);


}
