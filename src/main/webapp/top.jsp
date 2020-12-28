<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% String path=request.getContextPath(); %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>登录页面</title>
		<link rel="stylesheet" href="<%=path %>/bootstrap/css/bootstrap.min.css" />
		<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=path %>/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="<%=path %>/js/echarts.common.js"></script>
		<script type="text/javascript">
		
		$(function(){
			 getMenu();
		})
		   
	    function getMenu(){
		   $.ajax({
			   type:"post",
			   url:"<%=path%>/main/getMenu.do",
			   data:{},
			   dataType:"json",
			   success:function(res){
				   var html="";
				   for(var i in res){
					   var obj=res[i];
					   var children=obj.children;
					   var childhtml="";
					   for(var j in children){
						   childhtml+="<li><a href="+children[j].url+" target=\"context\">"+children[j].name+"</a></li><li class=\"divider\"></li>";
					   }
					   html+="<li class=\"dropdown\">"+
		                "<a class=\"dropdown-toggle\" data-toggle=\"dropdown\">"+obj.name+" <b class=\"caret\"></b></a>"+
		                "<ul class=\"dropdown-menu\">"+childhtml+"</ul>"+
		            "</li>";
				   }
				   $("[class='nav navbar-nav']").html(html);
			   }
		   })
	   }
		//退出
		function logout(){
			location.href="<%=path%>/login/logout.do";
		}
	   </script>
	</head>
	<body >
		<nav class="navbar navbar-default navbar-fixed-top" role="navigation"> 
		    <div class="container-fluid"> 
		        <div class="navbar-header"> 
		            <a class="navbar-brand">智原在线考试系统</a> 
		        </div> 
		        <div>
			        <ul class="nav navbar-nav">
			            
			        </ul>
			    </div>
		        <ul class="nav navbar-nav navbar-right"> 
		            <li><a href="<%=path%>/page/toLogin.do" target="context"><span class="glyphicon glyphicon-user"></span> 登录</a></li> 
		            <li><a href="javaScript:logout()"><span class="glyphicon glyphicon-log-in"></span> 退出</a></li> 
		        </ul> 
		    </div> 
		</nav>
		
	</body>
</html>
    