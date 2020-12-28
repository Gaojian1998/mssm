package com.hxzy.controller;

import com.alibaba.fastjson.JSON;
import com.hxzy.bean.Menu;
import com.hxzy.service.IMainServcie;
import com.hxzy.util.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import redis.clients.jedis.Jedis;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/main")
public class MainController {
	@Autowired
	private IMainServcie mainServcie;
	
	@RequestMapping("/getMenu")
	@ResponseBody
	public String getMenu(){
		//1、从redis缓存中取
		Jedis jedis=RedisUtil.getJedis();
		String json="";
		if(jedis!=null){
			String menu=jedis.get("menu");
			if(StringUtils.isEmpty(menu)){
				//2、redis 中取不到，则从关系型数据库中取
				List<Menu> list=mainServcie.getMenuByPid("0");
				json=JSON.toJSONString(list);
				//3、将关系型数据库中的信息放到redis中
				jedis.set("menu", json);
				//设置有效期 7*24*60*60
				jedis.expire("menu", 7*24*60*60);
			}else{
				json=menu;
			}
			//释放连接
			RedisUtil.returnResource(jedis);
		}else{
			//redis 中取不到，则从关系型数据库中取
			List<Menu> list=mainServcie.getMenuByPid("0");
			json=JSON.toJSONString(list);
		}
		return json;
	}
	/**
	 * 各阶段提型分析
	 * @return
	 */
	@RequestMapping("/questionTypeAnaly")
	@ResponseBody
    public String questionTypeAnaly() {
		List<Map<String,Object>> list=mainServcie.questionTypeAnaly();
		String json=JSON.toJSONString(list);
    	return json;
    }
	/**
	 * 成绩前十分析
	 */
	@RequestMapping("/scoresTop10")
	@ResponseBody
	public String scoresTop10(){
		List<Map<String,Object>> list=mainServcie.scoresTop10();
		String json=JSON.toJSONString(list);
		return json;
	}
	/**
	 * 各科目题型数量
	 * @return
	 */
	@RequestMapping("/seltCoursesNum")
	@ResponseBody
	public String seltCoursesNum(){
		List<Map<String,Object>> list=mainServcie.seltCoursesNum();
		String json=JSON.toJSONString(list);
		return json;
	}
}
