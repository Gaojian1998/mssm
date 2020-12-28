package com.hxzy.dao;
import com.hxzy.bean.Option;
import com.hxzy.bean.Paper;
import com.hxzy.bean.Question;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
public interface IPaperManagerMapper {
	/**
	 * 查询试卷的总记录数
	 * @return
	 */
	public int allCount();
	/**
	 * 获取试卷信息
	 * @return
	 */
    public List<Paper> getPaperInfo(Map<String, Object> map);
    /**
     * 获取试卷试题信息
     * @param qids
     * @return
     */
    public List<Question>getQuestionByPid(@Param("qids") String qids);
    /**
     * 试题选项查询
     * @param pid
     * @return
     */
    public List<Option>getOptionByPid(int pid);
}
