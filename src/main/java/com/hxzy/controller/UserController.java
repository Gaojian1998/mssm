package com.hxzy.controller;

import com.alibaba.fastjson.JSON;
import com.hxzy.bean.User;
import com.hxzy.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private IUserService userService;
	
	@ResponseBody
	@RequestMapping("/query")
	public String query(HttpServletRequest request){
		String name=request.getParameter("name");
		String usertype=request.getParameter("usertype");
		//接收当前页数
		String currentpage=request.getParameter("currentpage");
		if(currentpage==null || "".equals(currentpage)){
			 currentpage="1";
		}
		int currpage=Integer.parseInt(currentpage);
		if(currpage<=1){
			 currpage=1;
		}
		//
		Map<String, Object> map=new HashMap<String, Object>();
		//
		map.put("name", name);
		map.put("usertype", usertype);
		
		//每页记录数
	    int pageSize=10;
	    //查询总记录数
	    int count=userService.count(map);
		//总页数
		int allpage=count%pageSize==0?count/pageSize:count/pageSize+1;
		if(currpage>=allpage){
			 currpage=allpage;
		}
		//起始行
		int startRow=(currpage-1)*pageSize+1;
		 //结束行
		int endrow=currpage*pageSize;
		//
		map.put("startrow", startRow);
		map.put("endrow", endrow);
		List<User> list=userService.query(map);
		
		

		
		//
		Map<String,Object> jsonmap=new HashMap<String,Object>();
		jsonmap.put("list", list);
		jsonmap.put("allpage", allpage);
		jsonmap.put("currentpage", currpage);
		jsonmap.put("pageSize", pageSize);
		jsonmap.put("count", count);
		//
		String json = JSON.toJSONString(jsonmap);
		return json;
	}
	@ResponseBody
	@RequestMapping("/add")
	public String add(HttpServletRequest request){
		int k=0;
		//接收表单参数
		String id=request.getParameter("uid");
		String name=request.getParameter("username");
		String usertype=request.getParameter("usertype");
		String age=request.getParameter("age");
		String tel=request.getParameter("tel");
		String sex=request.getParameter("sex");
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("username", name);
		map.put("usertype", usertype);
		map.put("age", age);
		map.put("tel", tel);
		map.put("sex", sex);
		map.put("id", id);
	    k=userService.add(map);
		return String.valueOf(k);
	}
	@ResponseBody
	@RequestMapping("/del")
	public String del(HttpServletRequest request){
		int k=0;
		//接收表单参数
		String id=request.getParameter("id");
		k=userService.del(id);
		return String.valueOf(k);
	}
	@ResponseBody
	@RequestMapping("/delMore")
	public String delMore(HttpServletRequest request){
		//接收表单参数
		String ids=request.getParameter("ids");
 		int k=userService.delMore(ids);
		return String.valueOf(k);
	}
	@ResponseBody
	@RequestMapping("/getObjById")
	public String getObjById(HttpServletRequest request){
		String id=request.getParameter("id");
		User user=userService.getObjById(id);
		String json=JSON.toJSONString(user);
		return json;
	}
}