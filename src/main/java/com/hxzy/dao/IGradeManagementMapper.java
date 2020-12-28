package com.hxzy.dao;

import com.hxzy.bean.Paper;
import com.hxzy.bean.Question;
import com.hxzy.bean.Scores;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 成绩管理
 * @author home
 *
 */
public interface IGradeManagementMapper {
	/**
	 * 查询学生成绩信息
	 * @return 成绩信息
	 */
	public List<Map<String,Object>> queryScoreInfo(Map<String, Object> map);
	/**
	 * 总记录数
	 * @param map
	 * @return
	 */
	public int count(Map<String, Object> map);
	/**
	 *清空成绩信息
	 * @return
	 */
	public int clear();
	/**
	 * 批量删除
	 * @return
	 */
	public int delMore(@Param(value = "ids") String ids);
	/**
	 * 通过试卷名称查询试卷id
	 * @param pname 试卷名称
	 * @return
	 */
	public Paper getPidByPname(String pname);
	/**
	 * 通过用户名查询用户id
	 * @param username
	 * @return
	 */
	public String getUserIdByUsername(String username);
	/**
	 * 添加成绩信息
	 * @param scores
	 * @return
	 */
	public int addScore(Scores scores);
	/**
	 * 通过成绩id查询成绩信息
	 * @param id 成绩id
	 * @return
	 */
	public Scores getScoresByScid(String id);
	/**
	 * 修改考生成绩
	 * @param scid 成绩id
	 * @param grade 成绩
	 * @return
	 */
	public int updateScore(String scid, String grade);
	/**
	 * 获取试卷例题的内容
	 * @param qids
	 * @return
	 */
    public List<Question> getQuestionByQids(@Param(value = "qids") String qids);

}
