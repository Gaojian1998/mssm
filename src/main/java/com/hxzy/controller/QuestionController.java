package com.hxzy.controller;

import com.alibaba.fastjson.JSON;
import com.hxzy.bean.Option;
import com.hxzy.bean.Question;
import com.hxzy.bean.Type;
import com.hxzy.service.IQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/question")
public class QuestionController {
	
    //自动装配实例化service接口
	@Autowired
	private IQuestionService questionService;
	
	//下拉栏
    @RequestMapping("/toDropdown")
	public void toDropdown(@RequestParam(value="m") String m,HttpServletResponse response){
    	//解决ajax返回请求中文乱码问题,必须放在第一行
    	response.setContentType("text/html;charset=UTF-8");
    	try {
    		List<Type> listprofe= questionService.profeQuery(m);
	    	//将查询数据转化为JSON格式发送到前端页面
	    	String json = JSON.toJSONString(listprofe);
		    response.getWriter().write(json.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}       	
	}
    //查询--分页
    @RequestMapping("/toQuery")
    public void toQuery(HttpServletRequest request,HttpServletResponse response){
    	try {
    		response.setContentType("text/html;charset=UTF-8");
        	String qcoutypid=request.getParameter("qcoutypid");
        	String stagetypid=request.getParameter("stagetypid");
        	String proftypid=request.getParameter("proftypid");
        	String qnam=request.getParameter("qnam");
        	String pageNumber= request.getParameter("pageNumber");
        	Map<String,Object> map=new HashMap<String, Object>();
        	map.put("qcoutypid", qcoutypid);
        	map.put("stagetypid", stagetypid);
        	map.put("proftypid", proftypid);
        	map.put("qnam", qnam);
        	if(Integer.parseInt(pageNumber)==0){
        		pageNumber="1";
        	}
        	int currentPage=Integer.parseInt(pageNumber);//当前页
	    	int pageSize=10;//每页记录数
	    	int startRow=(currentPage-1)*pageSize+1;//每页开始行
	    	int endRow=currentPage*pageSize;//每页结束行
	    	map.put("startRow", startRow);
	    	map.put("endRow", endRow);
	    	int allCount=0;//总计录数
	    	allCount = questionService.getQustionCount(map);
	    	int allPage=0;//总页数
	    	if(allCount<pageSize){
	    		allPage=1;
	    	}else{
	    		allPage=(allCount%pageSize==0?allCount/pageSize:(allCount/pageSize)+1);//总页数
	    	}
	    	//存放json格式的Map对象
	    	Map<String, Object> allmap=new HashMap<String, Object>();
        	List<Question> listquestion= questionService.getQustion(map);
        	allmap.put("listquestion", listquestion);
        	allmap.put("allCount", allCount);//总计录数
        	allmap.put("allPage", allPage);//总页数
        	allmap.put("pageSize", pageSize);//每页记录数
        	allmap.put("pageNumber", pageNumber);
        	String json = JSON.toJSONString(allmap);
			response.getWriter().write(json);
			/*String jsonPage = JSON.toJSONString(allCount);//一个方法内不能返回两个json,会覆盖
			response.getWriter().write(jsonPage);*/
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
    //删除单条数据
    @RequestMapping("/toDel")
    public void toDel(@RequestParam(value="id") String id,HttpServletRequest request,HttpServletResponse response){
    	int k = questionService.toDel(id);
    	if(k>0){
    		toQuery(request, response);
    	}
    }
    //删除多条数据
    @RequestMapping("/toDelMore")
    public void toDelMore(@RequestParam(value="ids") String ids,HttpServletRequest request,HttpServletResponse response){
    	int k = questionService.toDelMore(ids);
    	if(k>0){
    		toQuery(request, response);
    	}
    }
    //查看选项
    @RequestMapping("/toQueryChoose")
    @ResponseBody
    public String toQueryChoose(@RequestParam(value="qid") String qid){
    	List<Option>  listOption= questionService.toQueryChoose(Integer.valueOf(qid));
    	String json= JSON.toJSONString(listOption);
    	return json;
    }
    //修改数据--修改数据先根据id查询，将数据展示出来，然后提交表单时进行判断是修改还是增加
    @RequestMapping("/getObjByid")
    @ResponseBody
    public String getObjByid(@RequestParam(value="id") String qid){
    	Question question= questionService.getObjByid(qid);
    	String json = JSON.toJSONString(question);
    	return json;
    }
}
