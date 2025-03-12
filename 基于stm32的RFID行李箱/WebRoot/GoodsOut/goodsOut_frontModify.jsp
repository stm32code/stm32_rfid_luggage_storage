<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.GoodsOut" %>
<%@ page import="com.chengxusheji.po.Goods" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的outGoodsRfid信息
    List<Goods> goodsList = (List<Goods>)request.getAttribute("goodsList");
    GoodsOut goodsOut = (GoodsOut)request.getAttribute("goodsOut");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改物品出箱信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">物品出箱信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="goodsOutEditForm" id="goodsOutEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="goodsOut_outId_edit" class="col-md-3 text-right">出箱id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="goodsOut_outId_edit" name="goodsOut.outId" class="form-control" placeholder="请输入出箱id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="goodsOut_outGoodsRfid_goodsId_edit" class="col-md-3 text-right">物品出箱id:</label>
		  	 <div class="col-md-9">
			    <select id="goodsOut_outGoodsRfid_goodsId_edit" name="goodsOut.outGoodsRfid.goodsId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goodsOut_outNumb_edit" class="col-md-3 text-right">出箱数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="goodsOut_outNumb_edit" name="goodsOut.outNumb" class="form-control" placeholder="请输入出箱数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goodsOut_outTime_edit" class="col-md-3 text-right">出箱时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date goodsOut_outTime_edit col-md-12" data-link-field="goodsOut_outTime_edit">
                    <input class="form-control" id="goodsOut_outTime_edit" name="goodsOut.outTime" size="16" type="text" value="" placeholder="请选择出箱时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goodsOut_goodsRfid_edit" class="col-md-3 text-right">物品rfid:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="goodsOut_goodsRfid_edit" name="goodsOut.goodsRfid" class="form-control" placeholder="请输入物品rfid">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxGoodsOutModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#goodsOutEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改物品出箱界面并初始化数据*/
function goodsOutEdit(outId) {
	$.ajax({
		url :  basePath + "GoodsOut/" + outId + "/update",
		type : "get",
		dataType: "json",
		success : function (goodsOut, response, status) {
			if (goodsOut) {
				$("#goodsOut_outId_edit").val(goodsOut.outId);
				$.ajax({
					url: basePath + "Goods/listAll",
					type: "get",
					success: function(goodss,response,status) { 
						$("#goodsOut_outGoodsRfid_goodsId_edit").empty();
						var html="";
		        		$(goodss).each(function(i,goods){
		        			html += "<option value='" + goods.goodsId + "'>" + goods.goodsName + "</option>";
		        		});
		        		$("#goodsOut_outGoodsRfid_goodsId_edit").html(html);
		        		$("#goodsOut_outGoodsRfid_goodsId_edit").val(goodsOut.outGoodsRfidPri);
					}
				});
				$("#goodsOut_outNumb_edit").val(goodsOut.outNumb);
				$("#goodsOut_outTime_edit").val(goodsOut.outTime);
				$("#goodsOut_goodsRfid_edit").val(goodsOut.goodsRfid);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交物品出箱信息表单给服务器端修改*/
function ajaxGoodsOutModify() {
	$.ajax({
		url :  basePath + "GoodsOut/" + $("#goodsOut_outId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#goodsOutEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#goodsOutQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse > a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*出箱时间组件*/
    $('.goodsOut_outTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    goodsOutEdit("<%=request.getParameter("outId")%>");
 })
 </script> 
</body>
</html>

