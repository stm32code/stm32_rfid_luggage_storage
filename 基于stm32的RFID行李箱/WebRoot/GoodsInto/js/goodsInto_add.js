$(function () {
	$("#goodsInto_goodsIntoObj_goodsId").combobox({
	    url:'Goods/listAll',
	    valueField: "goodsId",
	    textField: "goodsName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#goodsInto_goodsIntoObj_goodsId").combobox("getData"); 
            if (data.length > 0) {
                $("#goodsInto_goodsIntoObj_goodsId").combobox("select", data[0].goodsId);
            }
        }
	});
	$("#goodsInto_intoNumb").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入入箱数量',
		invalidMessage : '入箱数量输入不对',
	});

	$("#goodsInto_intoTIme").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#goodsInto_goodsRfid").validatebox({
		required : true, 
		missingMessage : '请输入物品rfid',
	});

	//单击添加按钮
	$("#goodsIntoAddButton").click(function () {
		//验证表单 
		if(!$("#goodsIntoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#goodsIntoAddForm").form({
			    url:"GoodsInto/add",
			    onSubmit: function(){
					if($("#goodsIntoAddForm").form("validate"))  { 
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
                        $("#goodsIntoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#goodsIntoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#goodsIntoClearButton").click(function () { 
		$("#goodsIntoAddForm").form("clear"); 
	});
});
