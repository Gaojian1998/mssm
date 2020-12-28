package com.hxzy.util;

import com.hxzy.bean.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri=request.getRequestURI();
        if(uri.indexOf("checkLogin")>0 || uri.indexOf("toLogin")>0){
            return true;
        }else{
            User user=(User)request.getSession().getAttribute("userInfo");
            if(user==null){
                //重定向到登录的请求映射
                response.sendRedirect(request.getContextPath()+"/page/toLogin.do");
            }else{
                return true;
            }
        }
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
