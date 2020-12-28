package com.hxzy.dao;

import com.hxzy.bean.Option;
import com.hxzy.bean.Question;
import com.hxzy.bean.Type;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface IQuestionMapper {
	
    /**
     * 下拉框查询
     * @param m 代表下拉框的类型
     * @return
     */
	public List<Type> profeQuery(String m);
	/**
	 * 条件查询获取总计录数
	 * @param map
	 * @return
	 */
	public int getQustionCount(Map<String, Object> map);
	/**
	 * 条件查询获取指定试题
	 * @param map
	 * @return
	 */
	public List<Question> getQustion(Map<String, Object> map);
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	public int toDel(String id);
	/**
	 * 删除多条数据
	 * @param ids
	 * @return
	 */
	public int toDelMore(@Param("ids") String ids);
	/**
	 * 查看选项
	 * @param qid
	 * @return
	 */
	public List<Option> toQueryChoose(int qid);
	/**
	 * 根据qid查询
	 * @param qid
	 * @return
	 */
	public Question getObjByid(String qid);
}
