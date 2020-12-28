package com.hxzy.dao;

import com.hxzy.bean.Paper;
import com.hxzy.bean.Scores;

import java.util.List;

/**
 * 考试主页（欢迎页）
 * @author tiantian
 *
 */
public interface IExamIndexMapper {
	/**
	 * 获取考试信息
	 * @param current
	 * @return 考试信息
	 */
    public List<Paper> getExamInfo(String current);
    /**
            *  成绩信息
     * @param
     * @return
     */
    public Scores getExamScore(String pid, String userid);
}
