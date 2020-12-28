<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String path=request.getContextPath();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>用户管理</title>
		<link rel="stylesheet" href="<%=path%>/bootstrap/css/bootstrap.min.css">
		<script type="text/javascript" src="<%=path%>/js/jquery.min.js" ></script>
        <script type="text/javascript" src="<%=path%>/bootstrap/js/bootstrap.min.js"></script>
		<style type="text/css">
		</style>
		<script type="text/javascript">
		    $(function(){
		    	query();
		    	//查询
		    	$(":button:eq(0)").click(function(){
		    		query();
			    })
			    //清空
		    	$(":button:eq(1)").click(function(){
		    		$("#qname").val('');
		    	    $("#usertype").val('');
			    })
			    //增加
			    $(":button:eq(2)").click(function(){
			    	$("[name='uid']").val("");
			    	//弹出模态框
                    $('#myModal').modal('show');
			    })
			    $('#tj').click(function(){
			    		add();
			    })
			    //批量删除
			    $(":button:eq(3)").click(function(){
			    	 delMore();
			    })
		    })
		   	//
			function query(){
				$.ajax({
					type:"post",
					url:"<%=path%>/user/query.do",
					data:{"name":$("#qname").val(),"usertype":$("#usertype").val()},
					dataType:"json",
					success:function(res){
						getPage(res);
					}
				})
			}
			function getPage(res){
				  var head="<thead><tr class=\"success\">"+
				  "<th>序号</th>"+
			      "<th>全选/取消<input type=\"checkbox\" onclick=\"check(this)\"/></th>"+
			      "<th>用户名</th>"+
			      "<th>用户类别</th>"+
			      "<th>性别</th>"+
			      "<th>年龄</th>"+
			      "<th>电话</th>"+
			      "<th>操作</th>"+
			      "</tr></thead>";
				  var list=res.list;
				  var innertr="";
				  for(var i in list){
				  	 var obj=list[i];
				  	 innertr+="<tr>"+
				  	"<td>"+(parseInt(i)+1)+"</td>"+
				  	 "<td><input type=\"checkbox\" name=\"id\" value=\""+obj.id+"\"/></td>"+
				  	 "<td>"+obj.username+"</td>"+
				  	 "<td>"+obj.usertype+"</td>"+
				  	 "<td>"+obj.sex+"</td>"+
				  	 "<td>"+obj.age+"</td>"+
				  	 "<td>"+obj.tel+"</td>"+
				  	 "<td align=\"center\">"+
				  	      "<button type=\"button\" class=\".btn-sm\" onclick=\"del("+obj.id+")\">删除</button>"+"&nbsp;&nbsp;"+
				  	      "<button type=\"button\" class=\".btn-sm\" onclick=\"modify("+obj.id+")\">修改</button>"+
				  	 "</td>"+
				  	 "</tr>";
				  }
				  $("table").html(head+innertr);
				  
				  var page="总记录数<b>"+res.count+"</b>,每页<b>"+res.pageSize+"</b>条,总页数<b>"+res.allpage+"</b>,当前第<b>"+res.currentpage+"</b>页&nbsp;&nbsp;"+
				  "<a href=\"javaScript:turnpage(1)\">首页</a>&nbsp;&nbsp;"+ 
				  "<a href=\"javaScript:turnpage("+(res.currentpage-1)+")\">上一页</a>&nbsp;&nbsp;"+
				  "<a href=\"javaScript:turnpage("+(res.currentpage+1)+")\">下一页</a>&nbsp;&nbsp;"+
				  "<a href=\"javaScript:turnpage("+res.allpage+")\">末页</a>";
				  $("#page").html(page);
				}

				function turnpage(pagenum){
					$.ajax({
						type:"post",
						url:"<%=path%>/user/query.do",
						data:{"name":$("#qname").val(),"currentpage":pagenum},
						dataType:"json",
						success:function(res){
							getPage(res);
						}
					})
				}
				//全选
				function check(obj){
					var objs=document.getElementsByName("id");
					if(obj.checked){
					    //将其余的复选框选中
					    for(var i in objs){
					    	objs[i].checked="checked";
					    }
					}else{
						//将其余的复选框选取消
					    for(var i in objs){
					    	objs[i].checked=false;
					    }
					}
				}
				//增加
				function add(){
					$.ajax({ 
						type:"post",
						url:"<%=path%>/user/add.do",
						data:$("form").serialize(),
						dataType:"text",
						success:function(res){
							if(res>0){
								query();
								//关闭模态框
					    		$('#myModal').modal('hide');
							}
						}
					})
				}
				//删除
				function del(id){
					$.ajax({ 
						type:"post",
						url:"<%=path%>/user/del.do",
						data:{"id":id},
						dataType:"text",
						success:function(res){
							if(res>0){
								query();
							}
						}
					})
				}
				//批量删除
				function delMore(id){
					var objs=document.getElementsByName("id");
					var ids="";
					for(var i in objs){
						if(objs[i].type=="checkbox" && objs[i].checked){
							if(ids==""){
								ids+=objs[i].value;
							}else{
								ids+=","+objs[i].value;
							}
						}
				    }
					if(ids==""){
						alert("请选择要删除的数据...");
					}else{
						if(confirm("亲，您确定要删除吗?")){
							$.ajax({
								type:"post",
								url:"<%=path%>/user/delMore.do",
								data:{"ids":ids},
								dataType:"text",
								success:function(res){
									if(res>0){
										query();
									}
								}
							})
						}
					}
				}
				//修改
				function modify(id){
					//"username":$("[name=\"num\"]").val(),
					//"usertype":$('#select').val(),
					//"sex":$("input[type='radio']:checked").val(),
					//"age":$("[name=\"age\"]").val(),
					//"tel":$("[name=\"tel\"]").val(),
					//"id":id
					$.ajax({ 
						type:"post",
						url:"<%=path%>/user/getObjById.do",
						data:{"id":id},
						dataType:"json",
						success:function(res){
							//User [id=800, username=dddd, usertype=1, pwd=null, age=20, sex=1, tel=1235]
							if(res!=null){
								//
								$("[name=\"username\"]").val(res.username);
								$("[name='uid']").val(id);
								$('#select').val(res.usertype);
								$("input[type='radio']:checked").val(res.sex);
								$("[name=\"age\"]").val(res.age);
								$("[name=\"tel\"]").val(res.tel);
								//弹出拟态框
								$('#myModal').modal('show');
							}
						}
					})
				}
		</script>
	</head>
	<body>
	  <form class="form-inline" role="form">
		  <div class="form-group">
		    <label for="name">用户名称</label>
		    <input type="text" class="form-control" id="qname" placeholder="请输入用户名称">
		  </div>
		  <label for="name">用户类别</label>
		  <select class="form-control" id="usertype">
		    <option value="">--请选择--</option>
		    <option value="0">管理员</option>
		    <option value="1">学生</option>
		  </select>
		  <div class="form-group">
		    <input type="button" class="btn btn-info" value="查询"/>
		  </div>
		  <div class="form-group">
		    <input type="button" class="btn btn-warning" value="清空"/>
		  </div>
		  <div class="form-group">
		    <input type="button" class="btn btn-primary" value="增加"/>
		  </div>
		  <div class="form-group">
		    <input type="button" class="btn btn-danger" value="批量删除"/>
		  </div>
	</form>
	<table class="table table-striped table-bordered table-hover">
		
	</table>
	 <div style="margin-top: 10px;" id="page">
	           总记录数 ${count} ,每页  ${pageSize}条,总页数 ${allpage}, 当前第  ${currentpage}页    
	    <a href="javaScript:turnpage(1)">首页</a> 
	    <a href="javaScript:turnpage(${currentpage-1})">上一页</a>
	    <a href="javaScript:turnpage(${currentpage+1})">下一页</a>
	    <a href="javaScript:turnpage(${allpage})">末页</a>
	  </div>
	  
	  <!-- 模态框（Modal） -->
	  <div class="modal fade" id="myModal" tabindex="-1" role="dialog"  aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" id="myModalLabel">用户注册表</h4>
	            </div>
	            <div class="modal-body">
	                <form role="form"  style="margin-top: 10px;" action="<%=path%>/stuSer?m=save" method="post">
				      <input type="hidden" name="uid"/>
				     <div class="form-group">
				          <label for="num">用户名:</label><input type="text" name="username" class="form-control" style="width: 31%;display: inline;" placeholder="请输入要添加的用户名"/>&nbsp;&nbsp;&nbsp;&nbsp;
				      	  <label>用户类别:</label>
				         <select name="usertype" id="select" class="form-control" style="width: 31%;display: inline;">
				            <option value="">--请选择--</option>
				            <option value="0">管理员</option>
				            <option value="1" selected="selected">学生</option>
				         </select>
				      </div>
				      <div class="form-group">
				         <label>年&nbsp;&nbsp;&nbsp;&nbsp;龄:</label><input type="number" name="age" value="20" class="form-control" style="width: 31%;display: inline;"/>&nbsp;&nbsp;&nbsp;&nbsp;
				         <label for="name">电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话:</label><input type="text" name="tel" class="form-control" style="width: 31%;display: inline;" placeholder="添加电话"/>
				      </div>
				      <div class="form-group">
				     	
				      </div>
				       <div class="form-group">
					      <label>性&nbsp;&nbsp;&nbsp;&nbsp;别:</label>
					      <label class="radio-inline">
							  <input type="radio" name="sex" value="1" checked="checked"/> 男
						  </label>
						  <label class="radio-inline">
							  <input type="radio" name="sex" value="0" /> 女
						  </label>
					  </div>
				   </form>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	                <button type="button" class="btn btn-primary" id="tj">提交更改</button>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal -->
	    </div>
	</body>
</html>
    