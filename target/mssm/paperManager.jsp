<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String path=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="top.jsp"/>
<title>试卷管理</title>
<script type="text/javascript">
    var pageNumber=1;
    $(function() {
		//试卷展示
		getPaper();
	})
	//试卷展示
	function getPaper() {
		$.ajax({
			type:"post",
			url:"<%=path%>/paperManager/getPaperinfo.do",
			data:{"pageNumber":pageNumber},
			dataType:"json",
			success:function(res){
				//{"allCount":18,
				//"listpaper":[{"pid":863,"pname":"java2020","ptimes":1,"qids":"387,408,418,453,463,803,817,818","statime":"2020-11-21 21:00:00","status":"有效","url":"D:\\Java\\tomcat8\\tomcat-8.0\\webapps\\maven_ssm\\paperFile\\函数.txt"},
				             //{"pid":862,"pname":"java2008","ptimes":1,"qids":"382,403,413,418,433,453,463,801,803,841","statime":"2020-11-21 20:00:00","status":"有效","url":"D:\\Java\\tomcat8\\tomcat-8.0\\webapps\\maven_ssm\\paperFile\\单选.txt"},{"pid":861,"pname":"java","ptimes":1,"qids":"382,387,403,408,413,418,423,428,433,801,810,816","statime":"2020-11-21 19:00:00","status":"有效","url":"D:\\Java\\tomcat8\\tomcat-8.0\\webapps\\maven_ssm\\paperFile\\单选.txt"},{"pid":211,"pname":" 2020第一次考试","ptimes":2,"qids":"387,438,418,423,382,398,413,403,408,433,448,443,458,453,463,466","statime":"2020-11-12 10:40:00","status":"有效","url":"E:\\upload\\spring.doc"},{"pid":191,"pname":"java第一阶段在线考试","ptimes":1,"qids":"443,433,423,428,387,408,418,382,398,403,458,453,463,466","statime":"2020-05-13 11:00:00","status":"有效","url":"E:\\upload\\redis.doc"},{"pid":172,"pname":"fdz","ptimes":1,"qids":"443,413,403,453,458,466","statime":"2020-02-28 21:03:00","status":"无效"},{"pid":171,"pname":"2222","ptimes":1,"qids":"438,387,433,453,458,466","statime":"2020-02-28 16:37:00","status":"无效"},{"pid":151,"pname":"2222","ptimes":1,"qids":"433,413,443,453,458,463","statime":"2020-02-22 15:06:00","status":"无效"},{"pid":144,"pname":"jjj","ptimes":1,"qids":"392,403,433,453","statime":"2020-02-05 14:30:00","status":"无效"},{"pid":143,"pname":"aaa","ptimes":1,"qids":"428,403,443,453,458,463,466","statime":"2020-02-05 14:26:00","status":"无效"}],
				             //"allPage":2}
				//拼表格
			    getTable(res);
			}
		})
	}
   //拼表格
   function getTable(res) {
	   var html="";
		for(var i in res.listpaper){
			var obj=res.listpaper[i];
			//获取日期的结束时间
			var endtime=new Date(obj.statime);
			endtime.setHours(endtime.getHours()+parseInt(obj.ptimes));
			var end=formatDateTime(endtime);
			var filepath=obj.url;
			html+="<tr>"+
			        "<td>"+(parseInt(i)+1)+"</td>"+
					"<td>"+obj.pname+"</td>"+
					"<td>"+(obj.ptimes*parseInt(60))+"分钟</td>"+
					"<td>"+obj.statime+"-------"+end+"</td>"+
					"<td>"+obj.status+"</td>"+
					"<td><a href=\"<%=path%>/paperManager/toQuestionPage.do?qids="+obj.qids+"\">查看试卷</a>&nbsp&nbsp"+
					   "<a href=\"<%=path%>/paperManager/toDownFile.do?filepath="+encodeURIComponent(obj.url)+"\">附件下载</a></td>"+
					   /* "<a href=\"javaScript:toDownFile("+encodeURIComponent(filepath)+")\">附件下载</a></td>"+  */
				  "</tr>";
		}
		$("[class='table table-bordered'] tbody:eq(0)").html(html);
		var tailhtml="<li><a>当前第"+res.pageNumber+"页,总记录数:"+res.allCount+",总页数:"+res.allPage+",每页记录数:"+res.pageSize+"</a></li>"+
        "<li><a href=\"javaScript:turnPage("+(pageNumber-1)+")\">上一页</a></li>"+
        "<li><a href=\"javaScript:turnPage("+parseInt(1)+") \">首页</a></li>";
		for(var j= 0; j< res.allPage; j++){
			tailhtml+="<li><a href=\"javaScript:turnPage("+(parseInt(j)+1)+")\">"+(parseInt(j)+1)+"</a></li>";
		}
		tailhtml+="<li><a href=\"javaScript:turnPage("+(pageNumber+1)+")\">下一页</a></li>";
	    //分页
	    $("[class='pagination  active']").html(tailhtml);
   }
   //分页
   function turnPage(pageNumber) {
		$.ajax({
			type:"post",
			url:"<%=path%>/paperManager/getPaperinfo.do",
			data:{"pageNumber":pageNumber},
			dataType:"json",
			success:function(res){
				getTable(res);
			}
		})
	}
  //时间格式转换
  function formatDateTime (date) {  
	  var y = date.getFullYear();
      var m = date.getMonth() + 1;
      m = m < 10 ? ('0' + m) : m;
      var d = date.getDate();
      d = d < 10 ? ('0' + d) : d;
      var h = date.getHours();
      h=h < 10 ? ('0' + h) : h;
      var minute = date.getMinutes();
      minute = minute < 10 ? ('0' + minute) : minute;
      var second=date.getSeconds();
      second=second < 10 ? ('0' + second) : second;
      return y + '-' + m + '-' + d+' '+h+':'+minute+':'+second;
    };
   //查询卷子试题
  function toDownFile(filepath){
	$.ajax({
		type:"post",
		url:"<%=path%>/paperManager/toDownFile.do",
		data:{"filepath":filepath},
		dataType:"text",
		success:function(res){
			
		}
	})
	
   } 
</script>
</head>
<body>
    <div class="container" style="margin-top: 60px;">
        <table class="table table-bordered">
			<thead>
				<tr class="success">
				    <th>序号</th>
					<th>试卷名称</th>
					<th>考试时长</th>
					<th>开始结束时间</th>
					<th>试卷状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			
			</tbody>
         </table>
         <nav style="text-align: center;">
		    <ul class="pagination  active">

		    </ul>
	    </nav>
    </div>
</body>
</html>