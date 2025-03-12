$(function () {
	$.ajax({
		url : "GoodsInto/" + $("#goodsInto_goodsintoId_edit").val() + "/update",
		type : "get",
		data : {
			//goodsintoId : $("#goodsInto_goodsintoId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (goodsInto, response, status) {
			$.messager.progress("close");
			if (goodsInto) { 
				$("#goodsInto_goodsintoId_edit").val(goodsInto.goodsintoId);
				$("#goodsInto_goodsintoId_edit").validatebox({
					required : true,
					missingMessage : "请输入物品入箱id",
					editable: false
				});
				$("#goodsInto_goodsIntoObj_goodsId_edit").combobox({
					url:"Goods/listAll",
					valueField:"goodsId",
					textField:"goodsName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#goodsInto_goodsIntoObj_goodsId_edit").combobox("select", goodsInto.goodsIntoObjPri);
						//var data = $("#goodsInto_goodsIntoObj_goodsId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#goodsInto_goodsIntoObj_goodsId_edit").combobox("select", data[0].goodsId);
						//}
					}
				});
				$("#goodsInto_intoNumb_edit").val(goodsInto.intoNumb);
				$("#goodsInto_intoNumb_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入入箱数量",
					invalidMessage : "入箱数量输入不对",
				});
				$("#goodsInto_intoTIme_edit").datetimebox({
					value: goodsInto.intoTIme,
					required: true,
					showSeconds: true,
				});
				$("#goodsInto_goodsRfid_edit").val(goodsInto.goodsRfid);
				$("#goodsInto_goodsRfid_edit").validatebox({
					required : true,
					missingMessage : "请输入物品rfid",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#goodsIntoModifyButton").click(function(){ 
		if ($("#goodsIntoEditForm").form("validate")) {
			$("#goodsIntoEditForm").form({
			    url:"GoodsInto/" +  $("#goodsInto_goodsintoId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#goodsIntoEditForm").form("validate"))  {
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
			$("#goodsIntoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
