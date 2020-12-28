package com.hxzy.controller;

import com.alibaba.fastjson.JSON;
import com.hxzy.bean.Type;
import com.hxzy.bean.User;
import com.hxzy.service.ILoginService;
import com.hxzy.service.IQuestionService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 登录
 * @author home
 *
 */
@Controller
@RequestMapping("/login")
public class LoginController {
	
	private Logger logger = Logger.getLogger(LoginController.class);
	
	@Autowired
	private ILoginService loginService;
	@Autowired
	private IQuestionService questionService;
	/**
	 * 检验登录的用户名与密码是否存在
	 * @return
	 */
	@RequestMapping("/checkLogin")
	public String checkLogin(User user,HttpSession session,HttpServletRequest request) {
		User u=loginService.checkLogin(user);
		logger.debug("debug.........");
		logger.info("info...............");
		logger.error("error .....日志出错...");
		if(u!=null){
			//将登录的用户信息保存到会话中
			session.setAttribute("userInfo", u);
		}else{
			return "redirect:/page/toLogin.do";
		}
		
		if(u.getUsertype()==1) {
			
			return "redirect:/page/toExam_index.do";
		}else if(u.getUsertype()==0) {
			//跳转到管理员操作页面
			ServletContext servletcontext=request.getServletContext();
			if(servletcontext.getAttribute("list0")==null){
				//将下列数据字典中的数据，放到application 缓存中
				List<Type> list0= questionService.profeQuery("0");
				servletcontext.setAttribute("list0", JSON.toJSONString(list0));
			}
			if(servletcontext.getAttribute("list1")==null){
				List<Type> list1= questionService.profeQuery("1");
				servletcontext.setAttribute("list1", JSON.toJSONString(list1));
			}
			
			if(servletcontext.getAttribute("list2")==null){
				List<Type> list2= questionService.profeQuery("2");
				servletcontext.setAttribute("list2", JSON.toJSONString(list2));
			}
			return "redirect:/page/toMain.do";
		}
		
		return "redirect:/page/toLogin.do";
	}

	//退出
	@RequestMapping("/logout")
	public String logout(HttpSession session){
		//设置session失效
		session.invalidate();
		return "redirect:/page/toLogin.do";
	}
	//浏览器关闭退出
	@RequestMapping("/ajaxlogout")
	@ResponseBody
	public String ajaxlogout(HttpSession session){
		//设置session失效
		//session.invalidate();
		return "redirect:/page/toLogin.do";
	}
}
