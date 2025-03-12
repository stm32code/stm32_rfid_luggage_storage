$(function () {
	$("#goodsOut_outGoodsRfid_goodsId").combobox({
	    url:'Goods/listAll',
	    valueField: "goodsId",
	    textField: "goodsName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#goodsOut_outGoodsRfid_goodsId").combobox("getData"); 
            if (data.length > 0) {
                $("#goodsOut_outGoodsRfid_goodsId").combobox("select", data[0].goodsId);
            }
        }
	});
	$("#goodsOut_outNumb").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入出箱数量',
		invalidMessage : '出箱数量输入不对',
	});

	$("#goodsOut_outTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#goodsOut_goodsRfid").validatebox({
		required : true, 
		missingMessage : '请输入物品rfid',
	});

	//单击添加按钮
	$("#goodsOutAddButton").click(function () {
		//验证表单 
		if(!$("#goodsOutAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#goodsOutAddForm").form({
			    url:"GoodsOut/add",
			    onSubmit: function(){
					if($("#goodsOutAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#goodsOutAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#goodsOutAddForm").submit();
		}
	});

	//单击清空按钮
	$("#goodsOutClearButton").click(function () { 
		$("#goodsOutAddForm").form("clear"); 
	});
});
