package com.hxzy.controller;


import com.alibaba.fastjson.JSON;
import com.hxzy.bean.Question;
import com.hxzy.bean.Type;
import com.hxzy.service.IGeneraPaperService;
import com.hxzy.util.RedisUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import redis.clients.jedis.Jedis;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/generaPaper")
public class GeneraPaperController {
    
	@Autowired
	IGeneraPaperService generaPaperService;
	
	@RequestMapping("/togetQueryBytid")
	@ResponseBody
	public String togetQueryBytid(){
		 String json=null;
		 Map<String,Object> map=new HashMap<String, Object>();
		//从缓存中取数据
		Jedis jedis= RedisUtil.getJedis();
		//首先判断是否连接到redis服务
		if(jedis!=null){
			//判断非关系型数据库指定的钥匙，数据是否为空
		    String menumap=jedis.get("menumap");
			if(!StringUtils.isEmpty(menumap)){
				//如果数据不为空，就将查找出来的字符串赋值给需要返回的json数据
				json=menumap;
			}else{
				  //如果为空，在关系型数据库中查，放到redis缓存中
				   List<Type> listType0=generaPaperService.togetQueryBytid("2");
				   List<Type> listType2=generaPaperService.togetQueryBytid("1");
				   map.put("listType0",listType0);
				   map.put("listType2",listType2);
				   json= JSON.toJSONString(map);
				   //将从关系型数据库中查找的数据放到非关系数据裤中
				   jedis.set("menumap", json);
				   //设置数据库有效时间，单位为秒
				   jedis.expire("menumap", 3*24*60*60);		   
			}
			//释放连接
			RedisUtil.returnResource(jedis);
		}else{
			//如果为空，在数据库中查，放到缓存中
			 List<Type> listType0=generaPaperService.togetQueryBytid("2");
			 List<Type> listType2=generaPaperService.togetQueryBytid("1");
			 map.put("listType0",listType0);
			 map.put("listType2",listType2);
			 json= JSON.toJSONString(map);
		}
		return json;
	}
	@RequestMapping("/torandomSelTop")
	@ResponseBody
	public String torandomSelTop(HttpServletRequest request){
		String singChNum=request.getParameter("singChNum");
		String moreChNum=request.getParameter("moreChNum");
		String judegeNum=request.getParameter("judegeNum");
		String couresTyp=request.getParameter("couresTyp");
		String statgesTyp=request.getParameter("statgesTyp");
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("singChNum", singChNum);
		map.put("moreChNum", moreChNum);
		map.put("judegeNum", judegeNum);
		map.put("couresTyp", couresTyp);
		map.put("statgesTyp", statgesTyp);
		List<Question> listQuestion= generaPaperService.randomSelTop(map);
		String json= JSON.toJSONString(listQuestion);
		return json;
	}
}
