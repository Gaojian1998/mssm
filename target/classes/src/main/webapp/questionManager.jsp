<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
String path=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="top.jsp"/>
<title>试题</title>
<script type="text/javascript">
     var pageNumber=1;
     var qcoutypid=0;//选中的题类型id
	 var stagetypid=0;//选中的阶段id
	 var proftypid=0;//选中的专业id
	 var qnam=null;
	 var list01='${list0}';
	 list01=JSON.parse(list01);
	 var list02='${list1}';
	 list02=JSON.parse(list02);
	 var list03='${list2}';
	 list03=JSON.parse(list03);
     $(function(){
    	 getQuery();
        //题目类型下拉栏
      	getQcourse();
      	//阶段下拉栏
      	//getStage();
        //专业下拉栏
        //getProfessiontype();
      	 //查询按钮
      	$("#query").on("click",function(){
      		getQuery();
      	})
      	//清空查询条件
      	$("[class='btn btn-success']").click(function(){
         	 toClean();
      	})
      	
      	 //增加
      	 add();
      	 //全选
      	 allChecked();
      	 //隐藏模态框
      	 $("#myModal").modal('hide');
      	 //隐藏模态框
      	 $("#myupdateModal").modal('hide');
      	 
      })
   function  getQcourse() {
  			//从缓存中取
  			var html="";
            html="<option value=''>请选择题类型</option>";
            for(var i in list01){
           	  var obj=list01[i];
           	  html+="<option value="+obj.typeid+">"+obj.typename+"</option>";
            }
            $("[class='form-control']:eq(0)").html(html);
  			
            var html2="";
            html2="<option value=''>请选择阶段</option>";
            for(var i in list02){
	           	 var obj=list02[i];
	           	 html2+="<option value="+obj.typeid+">"+obj.typename+"</option>";
            }
            $("[class='form-control']:eq(1)").html(html2);
            
            
            
            var html3="";
            html3="<option value=''>请选择专业</option>";
            for(var i in list03){
	           	 var obj=list03[i];
	           	 html3+="<option value="+obj.typeid+">"+obj.typename+"</option>";
            }
            $("[class='form-control']:eq(2)").html(html3);
  			
     } 
     function  getStage() {
			$.ajax({
				type:"post",
				url:"<%=path%>/question/toDropdown.do",
				data:{"m":"1"},
				dataType:"json",
				success:function(res){
				//[Type [typeid=4, typename=第一阶段, type=1], Type [typeid=5, typename=第二阶段, type=1],
				//Type [typeid=6, typename=第三阶段, type=1], Type [typeid=7, typename=第四阶段, type=1]]
		              //alert(res);
		              var html="";
		              html="<option value=''>请选择阶段</option>";
		              for(var i in res){
		             	 var obj=res[i];
		             	 //alert(obj.typename);
		             	 html+="<option value="+obj.typeid+">"+obj.typename+"</option>";
		              }
		              $("[class='form-control']:eq(1)").html(html);
				}
			})
     } 
     function   getProfessiontype() {
			//alert("进来了");
			$.ajax({
				type:"post",
				url:"<%=path%>/question/toDropdown.do",
				data:{"m":"2"},
				dataType:"json",
				success:function(res){
				//[Type [typeid=4, typename=第一阶段, type=1], Type [typeid=5, typename=第二阶段, type=1],
				//Type [typeid=6, typename=第三阶段, type=1], Type [typeid=7, typename=第四阶段, type=1]]
           //alert(res);
           var html="";
           html="<option value=''>请选择专业</option>";
           for(var i in res){
          	 var obj=res[i];
          	 //alert(obj.typename);
          	 html+="<option value="+obj.typeid+">"+obj.typename+"</option>";
           }
           $("[class='form-control']:eq(2)").html(html);
				}
			})
     } 
     //查询
     function getQuery() {
    	 qnam=$("[name='qname']").val(); 
    	 qcoutypid=$("select:eq(0)").val();
    	 stagetypid=$("select:eq(1)").val();
    	 proftypid=$("select:eq(2)").val();
 	 	 $.ajax({
 	 		type:"post",
 	 		url:"<%=path%>/question/toQuery.do",
 	 		data:{"qcoutypid":qcoutypid,"stagetypid":stagetypid,"proftypid":proftypid,"qnam":qnam,"pageNumber":pageNumber},
 	 		dataType:"json",
 	 		success:function(res){
 	 		   //拼表单
 	 		   getTable(res);
 	 		}
 	 	 })
	 }
     //拼表单
     function getTable(res) {
	 		//{"listquestion":[{"id":448,"qanswer":"C","qcourse":"java","qname":"下列代码执行的结果是: \n  for (int i=1;i<=10;i++){\n\t  if(i%2==0){\n\t     return;\n\t  }\n\t  System.out.println(i);\n\t }","qscore":5.0,"qstage":"第一阶段","qtype":"单选题"},
	 		                 //{"id":443,"qanswer":"B","qcourse":"java","qname":"下列代码执行的结果是: \nfor (int i=1;i<=10;i++){\n\t  if(i%2==0){\n\t     continue;\n\t  }\n\t  System.out.println(i);\n\t }","qscore":5.0,"qstage":"第一阶段","qtype":"单选题"},
	 		                 //{"id":438,"qanswer":"C","qcourse":"java","qname":"以下代码执行的结果是 <br>\nfor (int i=2;i<=10;i++){<br>\n\t  if(i%2==0){\n\t     break;\n\t  }\n\t  System.out.println(i);\n\t }","qscore":5.0,"qstage":"第一阶段","qtype":"单选题"}],
	 		                 //"allCount":3}
 	 		var inerhtml="";
 	 		for(var i in res.listquestion){
 	 		var obj=res.listquestion[i];	//parseInt转换数据类型
 	 		//var qname=obj.qname;
 	 		 inerhtml+="<tr>"+
	    					"<td>"+(parseInt(i)+1)+"</td>"+
	    					"<td><input type=\"checkbox\" value="+obj.id+" name=\"ids\"></td>"+
	    					"<td>"+obj.qcourse+"</td>"+
	    					"<td>"+obj.qstage+"</td>"+
	    					"<td>"+obj.qtype+"</td>"+
	    					"<td>"+obj.qname+"</td>"+
	    					"<td>"+obj.qanswer+"</td>"+
	    					"<td>"+obj.qscore+"</td>"+
	    					"<td><a href=\"javaScript:toQueryChoose("+obj.id+",'"+obj.qname+" ')\">查看选项</a></td>"+
	    					"<td><a href=\"javaScript:toDel("+obj.id+")\">删除</a>&nbsp&nbsp"+
	    					     "<a href=\"javaScript:toUpdate("+obj.id+")\">修改</a></td>"+
 				    "</tr>";
 	 		 //$("[class='table table-bordered'] tbody").append(inerhtml); //append实现追加
 	 		}
 	 		$("[class='table table-bordered'] tbody").html(inerhtml); 
 	 		//拼分页
	 		var html="<li><a href=\"#\">当前第"+res.pageNumber+"页,总记录数:"+res.allCount+",总页数:"+res.allPage+",每页记录数:"+res.pageSize+"</a></li>"+
			          "<li><a href=\"javaScript:turnPage("+(pageNumber-1)+")\">上一页</a></li>"+
			          "<li><a href=\"javaScript:turnPage("+parseInt(1)+") \">首页</a></li>";
		   for (var j= 0; j< res.allPage; j++){
	 			html+="<li><a  href=\"javaScript:turnPage("+(parseInt(j)+1)+")\">"+(parseInt(j)+1)+"</a></li>";
	 		}
	 		html+="<li><a href=\"javaScript:turnPage("+(pageNumber+1)+")\">下一页</a></li>";
	 		$("[ class='pagination  active']").html(html);
	 		//删除多条数据
	      	toDelMore();
	}
     //分页
    function turnPage(pageNumber) {
		$.ajax({
			type:"post",
			url:"<%=path%>/question/toQuery.do",
			data:{"qcoutypid":qcoutypid,"stagetypid":stagetypid,"proftypid":proftypid,"qnam":qnam,"pageNumber":pageNumber},
			dataType:"json",
			success:function(res){
				getTable(res);
			}
		})
	}
    //清空查询条件
    function toClean() {
  	   $("[name='qname']").val("");
  	   $("select:eq(0)").val("");
  	   $("select:eq(1)").val("")
  	   $("select:eq(2)").val("");
  	   getQuery();
	}
    //增加
    function add() {
		$("[class='btn btn-info']").click(function() {
			location.href="<%=path%>/page/toAdd.do";
		})
	}
    //单条删除
    function toDel(id) {
		$.ajax({
			type:"post",
			url:"<%=path%>/question/toDel.do",
			data:{"qcoutypid":qcoutypid,"stagetypid":stagetypid,"proftypid":proftypid,"qnam":qnam,"pageNumber":pageNumber,"id":id},
			dataType:"json",
			success:function(res){
				alert("删除成功");
				getTable(res);
			}
		})
	}
    function allChecked() {
		$("[type='checkbox']").click(function() {
            if($("[type='checkbox']").prop("checked")){
           	 $("[name='ids']").each(function() {
    				$(this).prop("checked",true);
    			})
		     }else{
		    	 $("[name='ids']").each(function() {
	    			$(this).prop("checked",false);
	    			})
		     }
		})
	}
    //删除多条数据
    function toDelMore() {
		$("[ class='btn btn-warning']").click(function() {
			var ids="";
			$("[name='ids']").each(function() {
				//var obj=$(this).prop("checked");alert(obj);
				if($(this).prop("checked")){
					if(ids!=""){
						ids+=","+$(this).val();
					}else{
						ids=$(this).val();
					}
				}
			})
			if(ids==""){
				alert("请选择要删除的数据！");
			}else{
				if(confirm("亲,您确定要删除吗？")){
					$.ajax({
						type:"post",
						url:"<%=path%>/question/toDelMore.do",
						data:{"qcoutypid":qcoutypid,"stagetypid":stagetypid,"proftypid":proftypid,"qnam":qnam,"pageNumber":pageNumber,"ids":ids},
						dataType:"json",
						success:function(res){
							alert("删除成功");
							getTable(res);
						}
					})
				}
			}
		})
	}
    //查看选项
    function toQueryChoose(id,qnams) {
    	 $("#myModal").modal('show');
    	 $("#myModalLabel").text(qnams);
    	  $.ajax({
    		 type:"post",
    		 url:"<%=path%>/question/toQueryChoose.do",
    		 data:{"qid":id},
    		 dataType:"json",
    		 success:function(res){
    			 //[{"id":842,"opcontent":"A、 水果是","qid":0},
    			 //{"id":843,"opcontent":"B、苹果是","qid":0},
    			 //{"id":844,"opcontent":"C、水蜜桃是","qid":0},{"id":845,"opcontent":"D、香蕉是","qid":0}]
    			 var html="";
    			 for(var i in res){
    				 var obj=res[i];
    				html+="<li class=\"list-group-item\">"+obj.opcontent+"</li>";
    			 }
    			 $("[class='list-group']").html(html);
    		 }
    	 }) 
	}
    function toUpdate(id) {
    	$("#myupdateModal").modal('show');
		$.ajax({
			type:"post",
			url:"<%=path%>/question/getObjByid.do",
			data:{"id":id},
			dataType:"json",
			success:function(res){
				//{"id":905,"qanswer":"ABD","qcourse":"AI智能","qscore":5.0,"qstage":"第一阶段","qtype":"多选题"}
			}
			
		})
	}
</script>
</head>
<body>
     <div class="container" style="margin-top: 60px;">
	      <form class="form-inline" role="form"">
				<div  class="form-group " id="group">
					<label class="control-label">题类型：</label>
				    <select class="form-control" style="width: 150px" >
				    </select>
				</div>
			    <div class="form-group">
					<label class="control-label">阶段：</label>
				    <select class="form-control" style="width: 150px">
				    </select>
				</div>
				<div class="form-group">
					<label class="control-label">专业：</label>
				    <select class="form-control" style="width: 150px">
				    </select>
				</div>
				<div class="form-group">
					<label class="control-label">题目</label>
				    <input class="form-control" style="width: 180px" name="qname" placeholder="请输入题目"/>
				</div>
				<!-- 提供额外的视觉效果，标识一组按钮中的原始动作 -->
				<button type="button" class="btn btn-primary" id="query">查询</button>
				<!-- 表示一个成功的或积极的动作 -->
				<button type="button" class="btn btn-success">清空</button>
				<!-- 信息警告消息的上下文按钮 -->
				<button type="button" class="btn btn-info">增加</button>
				<!-- 表示应谨慎采取的动作 -->
				<button type="button" class="btn btn-warning">批量删除</button>
		   </form>
		<table class="table table-bordered">
			<thead >
				<tr class="success">
					<th>序号</th>
					<th><input type="checkbox"></th>
					<th>学科专业</th>
					<th>学业阶段</th>
					<th>题类型</th>
					<th>题内容</th>
					<th>题答案</th>
					<th>题分值</th>
					<th>查看选项</th>
					<th>操作&nbsp<a>添加</a></th>
				</tr>
			</thead>
			<tbody>
				<!--展示表单-->
			</tbody>
		</table>
		<nav style="text-align: center;">
	    <ul class="pagination  active">
	    </ul>
	    </nav>
    </div>
    <!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="myModalLabel"></h4>
				</div>
				<div class="modal-body" id="">
					<ul class="list-group">
						
					</ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-primary">
						提交更改
					</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myupdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="myModalLabel">
						模态框（Modal）标题
					</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
					  <div class="form-group">
					    <label for="firstname" class="col-sm-2 control-label">题专业</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="firstname" placeholder="请输入名字">
					    </div>
					  </div> 
					  <div class="form-group">
					    <label for="lastname" class="col-sm-2 control-label">题阶段</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="lastname" placeholder="请输入姓">
					    </div>
					  </div>
					   <div class="form-group">
					    <label for="lastname" class="col-sm-2 control-label">题类型</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="lastname" placeholder="请输入姓">
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="lastname" class="col-sm-2 control-label">题内容</label>
					    <div class="col-sm-10">
					      <input type="text" class="form-control" id="lastname" placeholder="请输入姓">
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="lastname" class="col-sm-2 control-label">题答案</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="lastname" placeholder="请输入姓">
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="lastname" class="col-sm-2 control-label">题分值</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="lastname" placeholder="请输入姓">
					    </div>
					  </div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-primary">
						提交更改
					</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
</body>
</html>