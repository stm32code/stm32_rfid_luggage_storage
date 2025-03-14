$(function () {
	$.ajax({
		url : "GoodsType/" + $("#goodsType_goodTypeId_edit").val() + "/update",
		type : "get",
		data : {
			//goodTypeId : $("#goodsType_goodTypeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (goodsType, response, status) {
			$.messager.progress("close");
			if (goodsType) { 
				$("#goodsType_goodTypeId_edit").val(goodsType.goodTypeId);
				$("#goodsType_goodTypeId_edit").validatebox({
					required : true,
					missingMessage : "请输入物品类型id",
					editable: false
				});
				$("#goodsType_goodTypeName_edit").val(goodsType.goodTypeName);
				$("#goodsType_goodTypeName_edit").validatebox({
					required : true,
					missingMessage : "请输入类型名称",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#goodsTypeModifyButton").click(function(){ 
		if ($("#goodsTypeEditForm").form("validate")) {
			$("#goodsTypeEditForm").form({
			    url:"GoodsType/" +  $("#goodsType_goodTypeId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#goodsTypeEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#goodsTypeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
