<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% String path=request.getContextPath(); %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>登录页面</title>
        <jsp:include page="top.jsp"/>
		<script type="text/javascript">
		$(function(){
			getChart1();
			getChart2();
			getChart3();
			getChart4();
		})
		function getChart1(){
			$.ajax({
				type:"post",
				url:"<%=path%>/main/scoresTop10.do",
				dataType:"json",
				success:function(res){
					//[{"SCORES":25,"USERNAME":"fdz"},{"SCORES":20,"USERNAME":"fdz"},{"SCORES":10,"USERNAME":"cxq"},{"SCORES":10,"USERNAME":"wzz"}]
					var xdata=[];
					var ydata=[];
					for(var i in res){
						var obj=res[i];
						xdata.push(obj.USERNAME);
						ydata.push(obj.SCORES);
					}
					option = {
							title: {
				                text: '成绩前10学生统计'
				            },
				            tooltip: {
				            	show:true
				            },
				            toolbox: {
				                show: true,
				                showTitle: false, // 隐藏默认文字，否则两者位置会重叠
				                feature: {
				                    saveAsImage: {
				                        show: true,
				                        title: 'Save As Image'
				                    },
				                    dataView: {
				                        show: true,
				                        title: 'Data View'
				                    },
				                },
				                tooltip: { // 和 option.tooltip 的配置项相同
				                    show: true,
				                    formatter: function (param) {
				                         return '<div>' + param.title + '</div>'; // 自定义的 DOM 结构
				                    },
				                    backgroundColor: '#222',
				                    textStyle: {
				                        fontSize: 12,
				                    },
				                    extraCssText: 'box-shadow: 0 0 3px rgba(0, 0, 0, 0.3);' // 自定义的 CSS 样式
				                }
				            },
						    xAxis: {
						        type: 'category',
						        data: xdata
						    },
						    yAxis: {
						        type: 'value'
						    },
						    series: [{
						        data:ydata,
						        type: 'line'
						    }]
						};
					 var myChart = echarts.init(document.getElementById("chart1"));
					 myChart.setOption(option);
				}
			})
		}
		
		function getChart2(){
			$.ajax({
				type:"post",
				url:"<%=path%>/main/seltCoursesNum.do",
				data:{},
				dataType:"json",
				success:function(res){
					//[{"QCOURSE":8,"TYPENAME":"java","COUNT":17},
					 //{"QCOURSE":11,"TYPENAME":"AI智能","COUNT":3},{"QCOURSE":9,"TYPENAME":"大数据","COUNT":2},{"QCOURSE":10,"TYPENAME":"UI设计","COUNT":2},{"QCOURSE":12,"TYPENAME":"网络营销","COUNT":2}]
					var xdata=[];
					var ydata=[];
					for(var i in res){
						var obj=res[i];
						xdata.push(obj.TYPENAME);
						ydata.push(obj.COUNT);
					}
					var option = {
				            title: {
				                text: '各科目题型数量'
				            },
				            tooltip: {},
				            legend: {
				                data:['销量']
				            },
				            xAxis: {
				                data: xdata
				            },
				            yAxis: {},
				            series: [{
				                name: '题目数量',
				                type: 'bar',
				                data: ydata
				            }]
				        };
					 var myChart = echarts.init(document.getElementById("chart2"));
					 myChart.setOption(option);
				}
			})
		}
		
		function getChart3(){
			
			    $.ajax({
			    	type:"post",
			    	url:"<%=path%>/main/questionTypeAnaly.do",
			    	dataType:"json",
			    	success:function(res){
			    		
			    		//[{"COUNT":15,"TYPE":"单选题"},
			    		//	{"COUNT":2,"TYPE":"判断题"},
			    		//	{"COUNT":2,"TYPE":"多选题"}]
			    		var names=[];
			    		var values=[];
			    		for(var i in res){
			    			names[i]=res[i].TYPE;
			    			var map={};
			    			map.value=res[i].COUNT;
			    			map.name=res[i].TYPE
			    			values[i]=map;
			    		}
			    		//legend中的date中的name要与series中的name一一对应legend才能显示
			    		var option = {
							    title: {
							        text: '题型分布情况',
							        left: 'center'
							    },
							    tooltip: {
							        trigger: 'item',
							        formatter: '{a} <br/>{b} : {c} ({d}%)'
							    },
							    legend: {
							        orient: 'vertical',
							        left: 'left',
							        data:names
							    },
							    series: [
							        {
							            name: '访问来源',
							            type: 'pie',
							            radius: '65%',
							            center: ['50%', '50%'],
							            data: values,
							            emphasis: {
							                itemStyle: {
							                    shadowBlur: 10,
							                    shadowOffsetX: 0,
							                    shadowColor: 'rgba(0, 0, 0, 0.5)'
							                }
							            }
							        }
							    ]
							}; 
						
						 var myChart = echarts.init(document.getElementById("chart3"));
						 myChart.setOption(option);
			    	}
			    })
			
		}
		
		function getChart4(){
			option = {
				    title: {
				        text: '世界人口总量',
				        subtext: '数据来自网络'
				    },
				    tooltip: {
				        trigger: 'axis',
				        axisPointer: {
				            type: 'shadow'
				        }
				    },
				    legend: {
				        data: ['2011年', '2012年']
				    },
				    grid: {
				        left: '3%',
				        right: '4%',
				        bottom: '3%',
				        containLabel: true
				    },
				    xAxis: {
				        type: 'value',
				        boundaryGap: [0, 0.01]
				    },
				    yAxis: {
				        type: 'category',
				        data: ['巴西', '印尼', '美国', '印度', '中国', '世界人口(万)']
				    },
				    series: [
				        {
				            name: '2011年',
				            type: 'bar',
				            data: [18203, 23489, 29034, 104970, 131744, 630230]
				        },
				        {
				            name: '2012年',
				            type: 'bar',
				            data: [19325, 23438, 31000, 121594, 134141, 681807]
				        }
				    ]
				};

			
			 var myChart = echarts.init(document.getElementById("chart4"));
			 myChart.setOption(option);
			
		}
		</script>
	
	</head>
	<body >
	    
		<div class="container" style="margin-top: 60px;">
			<div id="chart1" style="width: 550px;height: 270px;float: left;border: 1px solid red;"></div>
			<div id="chart2" style="width: 550px;height: 270px;float: right;border: 1px solid yellow;"></div>
			<div id="chart3" style="width: 550px;height: 270px;float: left;border: 1px solid red;"></div>
			<div id="chart4" style="width: 550px;height: 270px;float: right;border: 1px solid yellow;"></div>
		</div>
	</body>
</html>
    