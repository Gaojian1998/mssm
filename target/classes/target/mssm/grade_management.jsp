<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% String path=request.getContextPath(); %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<jsp:include page="top.jsp"/>
		<title>成绩管理</title>
		<%-- <script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
		<link rel="stylesheet" href="<%=path %>/bootstrap/css/bootstrap.min.css" />
		<script type="text/javascript" src="<%=path%>/bootstrap/js/bootstrap.min.js""></script> --%>
		<script type="text/javascript">
		  $(function(){
			  queryScoreInfo(); 
			  //查询
			  $("[class='btn btn-info']").click(function(){
				  queryScoreInfo();
			  })
			  //清空
			  clear();
			  //添加成绩信息
			  addScore();
			  //修改成绩信息
			  updateScore();
			  update()
			
		  }) 
		  //查询成绩信息
		  function queryScoreInfo(){
				  var name=$("#name").val();
				  var pname=$("#pname").val();
				  //当前页
				  $.ajax({
					  type:"post",
					  url:"<%=path %>/grademanagement/queryScores.do",
					  data:{"name":name,"pname":pname},
					  dataType:"json",
					  success :function(res){
						  getPage(res);
					  }
				  }) 
			
			  
		  }
		  //分页
		  function turnpage(currentpage){
			  var name=$("#name").val();
			  var pname=$("#pname").val();
			  //当前页
			  $.ajax({
				  type:"post",
				  url:"<%=path %>/grademanagement/queryScores.do",
				  data:{"name":name,"pname":pname,"currentpage":currentpage},
				  dataType:"json",
				  success :function(res){
					  getPage(res);
				  }
			  }) 
		  }
		  //清空
		  function clear(){
			  $("#clear").click(function(){
				   if(confirm("您确定要清空数据吗！！！")){
					   $.ajax({
						      type:"post",
							  url:"<%=path %>/grademanagement/clear.do",
							  dataType:"text",
							  success:function(res){
								  if(res=="true"){
									  queryScoreInfo()  
								  }
							  }
					   })
				   }
			  })
		  }
		  //修改成绩弹出模态框
		  function updateScore(){
			  $("[class='btn btn-success']").click(function(){
				  var ids="";
				  var count=0; 
				  var name="";
				  var pname="";
				  $("[type='checkbox']:checked").each(function(){
					    //用户名
					    name=$(this).parent().next().next().text();
					    // alert(name);
					    //试题名
					    pname=$(this).parent().next().next().next().text();
					    count++;
					    ids+=$(this).val()+",";
				  })
				  ids=ids.substring(0,ids.lastIndexOf(","));
				  if(ids==""){
					  alert("您还没有选择要修改的数据哦！！");
					  return ;
				  }else if(count!=1){
					  alert("一次只能修改一条语句哦！！");
					  return;
				       }else{
				    	 $("#updatename").val(name);
				    	 $("#updatepname").val(pname);
				    	 $("#form_scid").val(ids);
				    	 $("#updatemyModal").modal('show');
				    	 
				       }
			  })
		  }
		  function update(){
			  $("[class='btn btn-primary']").eq(1).click(function(){
				  //修改后成绩分数
				  var grade=$("#grade").val();
				  //修改的成绩id
				  var id=$("#form_scid").val();
				  
				  $.ajax({
				      type:"post",
					  url:"<%=path %>/grademanagement/updateScores.do",
					  data:{"id":id,"grade":grade},
					  dataType:"text",
					  success:function(res){
						  var n=parseInt(res);
						  if(n>0){
							  $("#updatemyModal").modal('hide');
							  queryScoreInfo() ; 
						  }
					  }
			   })
				  
			  })
		  }
		  //批量删除
		  function delMore(){
			  $("[class='btn btn-danger']").click(function(){
				  var ids="";
				 
				  $("[type='checkbox']:checked").each(function(){
					    ids+=$(this).val()+",";
				  })
				  if(ids==""){
					  alert("您还没有选择要删除的数据哦！！");
					  return ;
				  }else{
					  
					  $.ajax({
					      type:"post",
						  url:"<%=path %>/grademanagement/delMore.do",
						  data:{"ids":ids},
						  dataType:"text",
						  success:function(res){
							  var n=parseInt(res);
							  if(n>0){
								 
								  queryScoreInfo() ; 
							  }
						  }
				   })
				  }
			  })
			 
		  }
		  
		  //答案对比
		  function answerCompare(scid){
			  $.ajax({
				  type:"post",
				  url:"<%=path %>/grademanagement/getScoresByScid.do",
				  data:{"scid":scid},
				  dataType:"json",
				  success:function(res){
				 		 var html="";
					  for(var i in res){
						  var obj=res[i];
						  var a=parseInt(i);
						  var options="";
						  for(var j in obj.options){
							 
							  options+="<li style=\"margin-bottom: 13px;list-style-type: none;\">"+obj.options[j].opcontent+"</li>"
						  }
						  html+=" <div class=\"panel panel-default\">"+
								    "<div class=\"panel-heading\">"+(a+1)+". "+obj.content+"</div>"+
								    
								    "<div class=\"panel-body\">"+
								          "<ul>"+options+"</ul>"+
								    "</div>"+
								   "<hr >"+
								    "<div class=\"panel-body\">正确答案:"+obj.corrAnswer+"</div>"+
								     "<hr>";
								     if(obj.corrAnswer==obj.myAnswer){
								    	 html+="<div class=\"panel-body\">我的答案:"+obj.myAnswer+"</div>";
								     }else{
								    	 html+="<div class=\"panel-body\"><span>我的答案:</span><span style=\"color:red\">"+obj.myAnswer+"</span></div>";
								     }
								   
								html+= "</div>";
					  }
					  $("#score").html(html);
					  $("#scoreModal").modal('show');
				  }
			  })
			  
		  }
		  //添加学生信息
		  function addScore(){
			  $("[class='btn btn-primary']").eq(2).click(function(){
				  alert("ccccc");
				  $.ajax({
				      type:"post",
					  url:"<%=path %>/grademanagement/addScore.do",
					  data:$("form").eq(2).serialize(),
					  dataType:"text",
					  success:function(res){
						 if(res=="false1"){
							 alert("该考生不存在！！！,请重新输入");
						 }else if(res=="false2"){
							 alert("该试卷不存在！！,请重新输入");
						 }else if(res=="false3"){
							 alert("该考生在此次考试的成绩已存在，请重新输入");
						 }else if(res=="false4"){
							 alert("成绩插入失败！！")
						 }else if(res=="true"){
							 $("#addmyModal").modal('hide');
							 queryScoreInfo();
						 }
					  }
			   })
			  })
		  }
		  //拼页面内容
		  function getPage(res){
			  //{"current":1,"count":9,"pagesize":10,
				  //"list":[{"PNAME":"fdz","BEGINTIME":1582819200000,"SCORES":10,"USETIMES":"0时0分38秒","USERID":"377","USERNAME":"cxq","SCID":"621"},
					  //{"PNAME":"2222","BEGINTIME":1582300800000,"SCORES":10,"USETIMES":"0时0分33秒","USERID":"374","USERNAME":"wzz","SCID":"601"},{"PNAME":"java第一阶段在线考试","BEGINTIME":1605024000000,"SCORES":10,"USETIMES":"0时0分51秒","USERID":"null","SCID":"741"},{"PNAME":"java第一阶段在线考试","BEGINTIME":1605542400000,"SCORES":5,"USETIMES":"0时0分9秒","USERID":"251","USERNAME":"ceshi1","SCID":"767"},{"PNAME":"2020第二次考试","BEGINTIME":1605456000000,"SCORES":15,"USETIMES":"0时0分12秒","USERID":"562","USERNAME":"fdz","SCID":"761"},{"PNAME":"2020第三次考试","BEGINTIME":1605456000000,"SCORES":10,"USETIMES":"0时0分36秒","USERID":"562","USERNAME":"fdz","SCID":"762"},{"PNAME":"2020第四次考试","BEGINTIME":1605456000000,"SCORES":20,"USETIMES":"0时0分13秒","USERID":"374","USERNAME":"wzz","SCID":"765"},{"PNAME":"2020第四次考试","BEGINTIME":1605456000000,"SCORES":10,"USETIMES":"0时5分43秒","USERID":"377","USERNAME":"cxq","SCID":"766"},{"PNAME":"2020第四次考试","BEGINTIME":1605456000000,"SCORES":5,"USETIMES":"0时0分20秒","USERID":"562","USERNAME":"fdz","SCID":"764"}],
					  //"pagenum":1}
			  var list=res.list;
			  var content="";
			 for(var i in list){
				 var obj=list[i];
				 var a=parseInt(i);
				 var e=new Date(obj.BEGINTIME);
				 var etime=e.getFullYear()+"-"+(e.getMonth()+1)+"-"+e.getDate();
			  content+="<tr>"+
					      "<td>"+(a+1)+"</td>"+
					      "<td><input type=\"checkbox\" value=\""+obj.SCID+"\" ></td>"+
					      "<td>"+etime+"</td>"+
					      "<td>"+obj.USERNAME+"</td>"+
					      "<td>"+obj.PNAME+"</td>"+
					       "<td>"+obj.SCORES+"分</td>"+
					      "<td>"+obj.USETIMES+"</td>"+
					     " <td><a href=\"javaScript:answerCompare("+obj.SCID+")\">答案对比</a></td>"+
					    "</tr>" ;
			 }
			 $("#t1").html(content);
			 //拼分页
			 var pagenum=res.pagenum;
			 //alert(pagenum);
			 var page="<li><a href=\"#\">当前第"+res.current+"页,每页"+res.pagesize+"条,总记录数"+res.count+"条,总页数"+res.pagenum+"页</a></li>"+
			          "<li><a href=\"javaScript:turnpage("+(res.current-1)+")\">上一页</a></li>"+
			          "<li class=\"active\" ><a href=\"javaScript:turnpage(1)\">1</a></li>";
			 for(var j=2;j<=pagenum;j++){
				 page+=" <li ><a href=\"javaScript:turnpage("+j+")\">"+j+"</a></li>";
			 }
			 page+="<li><a href=\"javaScript:turnpage("+(res.current+1)+")\">下一页</a></li>"; 
			
			 $("[class='pagination']").html(page);
			 delMore();
		  }
		</script>
	</head>
	<body>
		<div  id="main" style="width: 1200px; margin:60px auto ">
			 <div id="top">
			 	<form class="form-inline" role="form">
					  <div class="form-group">
					    <label>学生姓名:</label>
					    <input type="text" class="form-control" id="name" placeholder="请输入学生姓名">
					  </div>
					  <div class="form-group">
					     <label>所属试卷:</label>
					    <input type="text" class="form-control" id="pname" placeholder="请输入试卷名称">
					  </div>
					
					  <button type="button" class="btn btn-info">查询</button>
					  <button type="button" class="btn btn-primary" id="clear">清空</button>
					  <button type="button" class="btn btn-warning" data-target="#addmyModal"  data-toggle="modal">增加</button>
					  <button type="button" class="btn btn-success" >修改成绩</button>
					  <button type="button" class="btn btn-danger">批量删除</button>
					 
					</form>
				
			 </div>
			 <div id="center" style="margin-top:15px">
			  <table class="table table-bordered table-hover">
				 
				  <thead style="background-color: darkseagreen;">
				    <tr>
				      <th>序号</th>
				      <th><input type="checkbox" value=""></th>
				      <th>开始时间</th>
				      <th>考生姓名</th>
				      <th>所属试卷</th>
				      <th>考试成绩</th>
				      <th>考试用时</th>
				      <th>操作</th>
				    </tr>
				  </thead>
				  <tbody id="t1">
				    <!-- 成绩信息 -->
				  </tbody>
				</table>
			 </div>
			 <div id="footer" style="margin-left:400px;">
			 	<ul class="pagination">
			 		<!-- 分页 -->
				</ul>
			 </div>
		 </div>
		 
		 <!-- 修改成绩的模态框 -->
		 <div class="modal fade" id="updatemyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">考生成绩修改</h4>
		            </div>
		            <div class="modal-body">
		              <form class="form-horizontal" role="form">
		                  <input id="form_scid" hidden="hidden">
		                  <div class="form-group">
						    <label for="firstname" class="col-sm-2 control-label">考生姓名</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="updatename" disabled="disabled" ></input>
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="firstname" class="col-sm-2 control-label">所属试卷</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="updatepname" disabled="disabled"></input>
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="firstname" class="col-sm-2 control-label">考生成绩</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="grade" placeholder="请输入考试成绩">
						    </div>
						  </div>
						</form>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		                <button type="button" class="btn btn-primary" >提交更改</button>
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		</div>
		
		<!--添加成绩信息的模态框  -->
	    <div class="modal fade" id="addmyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">成绩信息</h4>
		            </div>
		            <div class="modal-body">
		               <form class="form-horizontal" role="form"  >
						  <input type="hidden" name="num" >
						  <div class="form-group">
						    <label for="lastname" class="col-sm-2 control-label">开始时间:</label>
						    <div class="col-sm-4">
						      <input type="date" class="form-control" id="lastname" name="begintime" placeholder="请输入开始时间">
						    </div>
						  </div>
						   <div class="form-group">
						    <label for="lastname" class="col-sm-2 control-label">考生姓名:</label>
						    <div class="col-sm-4">
						      <input type="text" class="form-control" id="lastname" name="user.username" placeholder="请输入考生姓名">
						    </div>
						  </div>
						   <div class="form-group">
						    <label for="lastname" class="col-sm-2 control-label">考试分数:</label>
						    <div class="col-sm-4">
						      <input type="text" class="form-control" id="lastname" name="scores" placeholder="请输入考试分数">
						    </div>
						  </div>
						   <div class="form-group">
						    <label for="lastname" class="col-sm-2 control-label">试卷名称:</label>
						    <div class="col-sm-4">
						      <input type="text" class="form-control" id="lastname" name="paper.pname" placeholder="请输入试卷名称">
						    </div>
						  </div>
						   <div class="form-group">
						    <label for="lastname" class="col-sm-2 control-label">试卷答案:</label>
						    <div class="col-sm-4">
						      <input type="text" class="form-control" id="lastname" name="myanswer" placeholder="请输入试卷答案">
						    </div>
						  </div>
				      </form>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		                <button type="button" class="btn btn-primary">提交更改</button>
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		</div>
		
		
		
		<!--成绩对比的模态框  -->
		<div class="modal fade" id="scoreModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">答案对比</h4>
		            </div>
		            <div class="modal-body" style=" height: 420px;overflow:scroll " id="score">
		              
					
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		                
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		</div>
	</body>
</html>
    