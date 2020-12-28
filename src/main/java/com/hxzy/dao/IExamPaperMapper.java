package com.hxzy.dao;

import com.hxzy.bean.Question;
import com.hxzy.bean.Scores;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IExamPaperMapper {
	/**
	 * 获取考试试题
	 * @param qids 试题id
	 * @return 试题集合
	 */
   public List<Question> getExamContent(@Param(value = "qids") String qids);
   /**
	    * 获取客观题路径
	* @param pid  试卷id
	* @return 
	*/
	public String getFilePath(String pid);
	/**
	 * 添加成绩信息
	 * @param s
	 * @return
	 */
	public int saveScore(Scores s) ;
	/**
	 * 查询技能题
	 * @param pid
	 * @return
	 */
	public String getSkillQuestion(String pid) ;
}
