<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% String path=request.getContextPath(); %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>考试首页</title>
		<link rel="stylesheet" href="<%=path %>/css/exam_index.css" />
		<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
		<script type="text/javascript">
		var json;
		 $(function(){
			 examination();
			 //退出
			  $("#back").click(function(){
				 
				 location.href="<%=path%>/page/toLogin.do";
			 })
			  setInterval("getInfo(json);",1000*60);
			 
			 //setInterval("getInfo(res);",1000*60);
			 
		 })
		//考试信息
		 function examination(){
			 //获取系统当前时间
			 var date=new Date();
			 var current=date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
			  
			 $.ajax({
				 type:"post",
				 url:"<%=path%>/examIndex/examInfo.do",
				 data:{"current":current},
				 dataType:"json",
				 success:function(res){
					 //[{"pid":211,"pname":" 2020第一次考试","ptimes":2,"qids":"387,438,418,423,382,398,413,403,408,433,448,443,458,453,463,466","scores":{"scores":0.0},"statime":1605235200000,"status":"1","url":"E:\\upload\\spring.doc"},
						 //{"pid":302,"pname":"2020第三次考试","ptimes":1,"qids":"428,403,443,453,458,463,466","scores":{"scores":0.0},"statime":1605208200000,"status":"0"},
						 //{"pid":303,"pname":"2020第四次考试","ptimes":1,"qids":"428,403,443,453,458,463,466","scores":{"scores":0.0},"statime":1605202920000}]
					 json=res;
					 
					 getInfo(res);
					
					
				 }
			 })
		 }
		 //拼内容
		function getInfo(res){
			 var html="";
			 for(var i in res){
				 
				 var obj=res[i];
				 //考试时长(小时为单位)
				 var duration=obj.ptimes;
				
				 
				 //考试开始时间
				 var s=new Date(obj.statime);
				 var stime=s.getFullYear()+"-"+(s.getMonth()+1)+"-"+s.getDate()+" "+s.getHours()+":"+s.getMinutes();
				 
				 //考试结束时间
				 var endtime=obj.statime+duration*3600*1000;
				 var e=new Date(endtime);
				 var etime=e.getFullYear()+"-"+(e.getMonth()+1)+"-"+e.getDate()+" "+e.getHours()+":"+e.getMinutes();
				  html+="<div id=\"test1\" class=\"under_div\">"+
			     	    "<ul>"+
		     		       "<li ><h3>考试标题:"+obj.pname+"</h3></li>"+
		     		       "<li style=\"font-size:13px\">考试时间:"+stime+"至"+etime+"</li>";
					         //取系统当前时间
					         var date=new Date().getTime();
					        
					         if(date<obj.statime){
					        	 html+= "<li style=\"font-size:13px\">考试状态: <a href=\"#\" style=\"color: darkseagreen;font-weight: 900; \">未开始考试</a></li>";
					         }else if(date>=obj.statime && date<=endtime){
					        	  if(obj.scores.scid!=""&&obj.scores.scid!=null){
					        		  html+= "<li style=\"font-size:13px\">考试状态: <a href=\"#\" style=\"color: darkseagreen;font-weight: 900; \">考试结束</a></li>"; 
					        	  }else{
					        		  html+= "<li style=\"font-size:13px\">考试状态: <a href=\"<%=path%>/examPaper/jump.do?pid="+obj.pid+"&pname="+obj.pname+"&ptimes="+obj.ptimes+"&qids="+obj.qids+"&statime="+obj.statime+"\">开始考试</a></li>";
					        	  }
					        	
					         }else if(date>endtime){
					        	 html+= "<li style=\"font-size:13px\">考试状态: <a href=\"#\" style=\"color: darkseagreen;font-weight: 900; \">考试结束</a></li>";
					         }
					         var str="";
					        if(date>endtime||(obj.scores.scid!=""&&obj.scores.scid!=null)){
					        	str="<p ><span>主观题总分:</span><span style=\"color:red ;font-size: 1.2em;\">"+obj.scores.scores+"分</span></p>";
					        }else{
					        	str="<p>主观题总分:</p>";
					        	
					        }
					        html+="</ul>"+
			     	        "<div id=\"under_buttom\">"+str+
			     	        "</div>"+
			               "</div>"; 
			     	      
			 }
			$("#under").html(html);
		}
	    </script>
	</head>
	
	<body>
		<div id="main">
		   <div id="top" >
		     <div id="e_title">
		   	    <h1>欢迎进入考试系统,祝你取得好的成绩</h1>
		      </div>
		      <div id="backbutton">
		        <button id="back"  >退出</button>
		      </div>
             <div id="userinfo">
             	<span id="userinfo_name">学生姓名:${userInfo.username}</span>
             	<span id="userinfo_sex">学生性别:${userInfo.sex}</span>
             	<span id="userinfo_tel">学生电话:${userInfo.tel}</span>
             </div>
			
		   </div>
		   <hr color="gainsboro" size="1"/>
		   <div id="under">
			     
		   </div>
		</div>
	</body>
</html>
    