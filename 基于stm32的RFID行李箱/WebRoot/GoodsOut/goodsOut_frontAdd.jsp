<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Goods" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>物品出箱添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>GoodsOut/frontlist">物品出箱列表</a></li>
			    	<li role="presentation" class="active"><a href="#goodsOutAdd" aria-controls="goodsOutAdd" role="tab" data-toggle="tab">添加物品出箱</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="goodsOutList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="goodsOutAdd"> 
				      	<form class="form-horizontal" name="goodsOutAddForm" id="goodsOutAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="goodsOut_outGoodsRfid_goodsId" class="col-md-2 text-right">物品出箱id:</label>
						  	 <div class="col-md-8">
							    <select id="goodsOut_outGoodsRfid_goodsId" name="goodsOut.outGoodsRfid.goodsId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="goodsOut_outNumb" class="col-md-2 text-right">出箱数量:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="goodsOut_outNumb" name="goodsOut.outNumb" class="form-control" placeholder="请输入出箱数量">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="goodsOut_outTimeDiv" class="col-md-2 text-right">出箱时间:</label>
						  	 <div class="col-md-8">
				                <div id="goodsOut_outTimeDiv" class="input-group date goodsOut_outTime col-md-12" data-link-field="goodsOut_outTime">
				                    <input class="form-control" id="goodsOut_outTime" name="goodsOut.outTime" size="16" type="text" value="" placeholder="请选择出箱时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="goodsOut_goodsRfid" class="col-md-2 text-right">物品rfid:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="goodsOut_goodsRfid" name="goodsOut.goodsRfid" class="form-control" placeholder="请输入物品rfid">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxGoodsOutAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#goodsOutAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加物品出箱信息
	function ajaxGoodsOutAdd() { 
		//提交之前先验证表单
		$("#goodsOutAddForm").data('bootstrapValidator').validate();
		if(!$("#goodsOutAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "GoodsOut/add",
			dataType : "json" , 
			data: new FormData($("#goodsOutAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#goodsOutAddForm").find("input").val("");
					$("#goodsOutAddForm").find("textarea").val("");
				} else {
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
	//验证物品出箱添加表单字段
	$('#goodsOutAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"goodsOut.outNumb": {
				validators: {
					notEmpty: {
						message: "出箱数量不能为空",
					},
					integer: {
						message: "出箱数量不正确"
					}
				}
			},
			"goodsOut.outTime": {
				validators: {
					notEmpty: {
						message: "出箱时间不能为空",
					}
				}
			},
			"goodsOut.goodsRfid": {
				validators: {
					notEmpty: {
						message: "物品rfid不能为空",
					}
				}
			},
		}
	}); 
	//初始化物品出箱id下拉框值 
	$.ajax({
		url: basePath + "Goods/listAll",
		type: "get",
		success: function(goodss,response,status) { 
			$("#goodsOut_outGoodsRfid_goodsId").empty();
			var html="";
    		$(goodss).each(function(i,goods){
    			html += "<option value='" + goods.goodsId + "'>" + goods.goodsName + "</option>";
    		});
    		$("#goodsOut_outGoodsRfid_goodsId").html(html);
    	}
	});
	//出箱时间组件
	$('#goodsOut_outTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#goodsOutAddForm').data('bootstrapValidator').updateStatus('goodsOut.outTime', 'NOT_VALIDATED',null).validateField('goodsOut.outTime');
	});
})
</script>
</body>
</html>
