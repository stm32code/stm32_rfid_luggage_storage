$(function () {
	$.ajax({
		url : "GoodsOut/" + $("#goodsOut_outId_edit").val() + "/update",
		type : "get",
		data : {
			//outId : $("#goodsOut_outId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (goodsOut, response, status) {
			$.messager.progress("close");
			if (goodsOut) { 
				$("#goodsOut_outId_edit").val(goodsOut.outId);
				$("#goodsOut_outId_edit").validatebox({
					required : true,
					missingMessage : "请输入出箱id",
					editable: false
				});
				$("#goodsOut_outGoodsRfid_goodsId_edit").combobox({
					url:"Goods/listAll",
					valueField:"goodsId",
					textField:"goodsName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#goodsOut_outGoodsRfid_goodsId_edit").combobox("select", goodsOut.outGoodsRfidPri);
						//var data = $("#goodsOut_outGoodsRfid_goodsId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#goodsOut_outGoodsRfid_goodsId_edit").combobox("select", data[0].goodsId);
						//}
					}
				});
				$("#goodsOut_outNumb_edit").val(goodsOut.outNumb);
				$("#goodsOut_outNumb_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入出箱数量",
					invalidMessage : "出箱数量输入不对",
				});
				$("#goodsOut_outTime_edit").datetimebox({
					value: goodsOut.outTime,
					required: true,
					showSeconds: true,
				});
				$("#goodsOut_goodsRfid_edit").val(goodsOut.goodsRfid);
				$("#goodsOut_goodsRfid_edit").validatebox({
					required : true,
					missingMessage : "请输入物品rfid",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#goodsOutModifyButton").click(function(){ 
		if ($("#goodsOutEditForm").form("validate")) {
			$("#goodsOutEditForm").form({
			    url:"GoodsOut/" +  $("#goodsOut_outId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#goodsOutEditForm").form("validate"))  {
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
			$("#goodsOutEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
