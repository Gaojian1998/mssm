<%--
  Created by IntelliJ IDEA.
  User: 11213
  Date: 2020/12/27
  Time: 14:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<% String path=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录页面</title>
    <link rel="stylesheet" href="<%=path %>/css/login.css" />
    <script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
    <script type="text/javascript">
    </script>

</head>
<body >
<div id="login">
    <div class="h2">
        <h2>登录</h2>
    </div>
    <form action="<%=path%>/login/checkLogin.do" method="post">
        <div class="myname">
            <label>用户名:</label>
            <input type="text" name="username">
        </div>
        <div class="mypwd">
            <label>密&emsp;码:</label>
            <input type="text" name="pwd">
        </div>
        <div class="remenber f" >
            <label>
                <input type="checkbox">记住我
            </label>

        </div>
        <div class="forget f" >
            <a>忘记密码?</a>
        </div>
        <div class="mybutton">
            <button type="submit">登录</button>
        </div>

    </form>
</div>
</body>
</html>
