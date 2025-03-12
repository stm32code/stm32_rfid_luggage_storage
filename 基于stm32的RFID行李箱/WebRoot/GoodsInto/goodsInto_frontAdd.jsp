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
<title>物品入箱添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>GoodsInto/frontlist">物品入箱列表</a></li>
			    	<li role="presentation" class="active"><a href="#goodsIntoAdd" aria-controls="goodsIntoAdd" role="tab" data-toggle="tab">添加物品入箱</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="goodsIntoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="goodsIntoAdd"> 
				      	<form class="form-horizontal" name="goodsIntoAddForm" id="goodsIntoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="goodsInto_goodsIntoObj_goodsId" class="col-md-2 text-right">入箱物品:</label>
						  	 <div class="col-md-8">
							    <select id="goodsInto_goodsIntoObj_goodsId" name="goodsInto.goodsIntoObj.goodsId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="goodsInto_intoNumb" class="col-md-2 text-right">入箱数量:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="goodsInto_intoNumb" name="goodsInto.intoNumb" class="form-control" placeholder="请输入入箱数量">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="goodsInto_intoTImeDiv" class="col-md-2 text-right">入箱时间:</label>
						  	 <div class="col-md-8">
				                <div id="goodsInto_intoTImeDiv" class="input-group date goodsInto_intoTIme col-md-12" data-link-field="goodsInto_intoTIme">
				                    <input class="form-control" id="goodsInto_intoTIme" name="goodsInto.intoTIme" size="16" type="text" value="" placeholder="请选择入箱时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="goodsInto_goodsRfid" class="col-md-2 text-right">物品rfid:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="goodsInto_goodsRfid" name="goodsInto.goodsRfid" class="form-control" placeholder="请输入物品rfid">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxGoodsIntoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#goodsIntoAddForm .form-group {margin:10px;}  </style>
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
	//提交添加物品入箱信息
	function ajaxGoodsIntoAdd() { 
		//提交之前先验证表单
		$("#goodsIntoAddForm").data('bootstrapValidator').validate();
		if(!$("#goodsIntoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "GoodsInto/add",
			dataType : "json" , 
			data: new FormData($("#goodsIntoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#goodsIntoAddForm").find("input").val("");
					$("#goodsIntoAddForm").find("textarea").val("");
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
	//验证物品入箱添加表单字段
	$('#goodsIntoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"goodsInto.intoNumb": {
				validators: {
					notEmpty: {
						message: "入箱数量不能为空",
					},
					integer: {
						message: "入箱数量不正确"
					}
				}
			},
			"goodsInto.intoTIme": {
				validators: {
					notEmpty: {
						message: "入箱时间不能为空",
					}
				}
			},
			"goodsInto.goodsRfid": {
				validators: {
					notEmpty: {
						message: "物品rfid不能为空",
					}
				}
			},
		}
	}); 
	//初始化入箱物品下拉框值 
	$.ajax({
		url: basePath + "Goods/listAll",
		type: "get",
		success: function(goodss,response,status) { 
			$("#goodsInto_goodsIntoObj_goodsId").empty();
			var html="";
    		$(goodss).each(function(i,goods){
    			html += "<option value='" + goods.goodsId + "'>" + goods.goodsName + "</option>";
    		});
    		$("#goodsInto_goodsIntoObj_goodsId").html(html);
    	}
	});
	//入箱时间组件
	$('#goodsInto_intoTImeDiv').datetimepicker({
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
		$('#goodsIntoAddForm').data('bootstrapValidator').updateStatus('goodsInto.intoTIme', 'NOT_VALIDATED',null).validateField('goodsInto.intoTIme');
	});
})
</script>
</body>
</html>
