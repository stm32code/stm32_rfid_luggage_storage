var goods_manage_tool = null; 
$(function () { 
	initGoodsManageTool(); //建立Goods管理对象
	goods_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#goods_manage").datagrid({
		url : 'Goods/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "goodsId",
		sortOrder : "desc",
		toolbar : "#goods_manage_tool",
		columns : [[
			{
				field : "goodsId",
				title : "物品id",
				width : 70,
			},
			{
				field : "goodTypeObj",
				title : "物品类型",
				width : 140,
			},
			{
				field : "goodsName",
				title : "物品名称",
				width : 140,
			},
			{
				field : "goodsRfid",
				title : "物品rfid",
				width : 140,
			},
			{
				field : "goodPrice",
				title : "物品价格",
				width : 70,
			},
			{
				field : "goodsDescribe",
				title : "物品描述",
				width : 140,
			},
			{
				field : "goodIntoTIme",
				title : "物品存入时间",
				width : 140,
			},
			{
				field : "goodsNumb",
				title : "仓库数量",
				width : 70,
			},
			{
				field : "goodsUserObj",
				title : "所属用户",
				width : 140,
			},
		]],
	});

	$("#goodsEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#goodsEditForm").form("validate")) {
					//验证表单 
					if(!$("#goodsEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#goodsEditForm").form({
						    url:"Goods/" + $("#goods_goodsId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#goodsEditForm").form("validate"))  {
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#goodsEditDiv").dialog("close");
			                        goods_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#goodsEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#goodsEditDiv").dialog("close");
				$("#goodsEditForm").form("reset"); 
			},
		}],
	});
});

function initGoodsManageTool() {
	goods_manage_tool = {
		init: function() {
			$.ajax({
				url : "GoodsType/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#goodTypeObj_goodTypeId_query").combobox({ 
					    valueField:"goodTypeId",
					    textField:"goodTypeName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{goodTypeId:0,goodTypeName:"不限制"});
					$("#goodTypeObj_goodTypeId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#goodsUserObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#goodsUserObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#goods_manage").datagrid("reload");
		},
		redo : function () {
			$("#goods_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#goods_manage").datagrid("options").queryParams;
			queryParams["goodTypeObj.goodTypeId"] = $("#goodTypeObj_goodTypeId_query").combobox("getValue");
			queryParams["goodsName"] = $("#goodsName").val();
			queryParams["goodsRfid"] = $("#goodsRfid").val();
			queryParams["goodsDescribe"] = $("#goodsDescribe").val();
			queryParams["goodIntoTIme"] = $("#goodIntoTIme").datebox("getValue"); 
			queryParams["goodsUserObj.user_name"] = $("#goodsUserObj_user_name_query").combobox("getValue");
			$("#goods_manage").datagrid("options").queryParams=queryParams; 
			$("#goods_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#goodsQueryForm").form({
			    url:"Goods/OutToExcel",
			});
			//提交表单
			$("#goodsQueryForm").submit();
		},
		remove : function () {
			var rows = $("#goods_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var goodsIds = [];
						for (var i = 0; i < rows.length; i ++) {
							goodsIds.push(rows[i].goodsId);
						}
						$.ajax({
							type : "POST",
							url : "Goods/deletes",
							data : {
								goodsIds : goodsIds.join(","),
							},
							beforeSend : function () {
								$("#goods_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#goods_manage").datagrid("loaded");
									$("#goods_manage").datagrid("load");
									$("#goods_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#goods_manage").datagrid("loaded");
									$("#goods_manage").datagrid("load");
									$("#goods_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#goods_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Goods/" + rows[0].goodsId +  "/update",
					type : "get",
					data : {
						//goodsId : rows[0].goodsId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (goods, response, status) {
						$.messager.progress("close");
						if (goods) { 
							$("#goodsEditDiv").dialog("open");
							$("#goods_goodsId_edit").val(goods.goodsId);
							$("#goods_goodsId_edit").validatebox({
								required : true,
								missingMessage : "请输入物品id",
								editable: false
							});
							$("#goods_goodTypeObj_goodTypeId_edit").combobox({
								url:"GoodsType/listAll",
							    valueField:"goodTypeId",
							    textField:"goodTypeName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#goods_goodTypeObj_goodTypeId_edit").combobox("select", goods.goodTypeObjPri);
									//var data = $("#goods_goodTypeObj_goodTypeId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#goods_goodTypeObj_goodTypeId_edit").combobox("select", data[0].goodTypeId);
						            //}
								}
							});
							$("#goods_goodsName_edit").val(goods.goodsName);
							$("#goods_goodsName_edit").validatebox({
								required : true,
								missingMessage : "请输入物品名称",
							});
							$("#goods_goodsRfid_edit").val(goods.goodsRfid);
							$("#goods_goodsRfid_edit").validatebox({
								required : true,
								missingMessage : "请输入物品rfid",
							});
							$("#goods_goodPrice_edit").val(goods.goodPrice);
							$("#goods_goodPrice_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入物品价格",
								invalidMessage : "物品价格输入不对",
							});
							$("#goods_goodsDescribe_edit").val(goods.goodsDescribe);
							$("#goods_goodsDescribe_edit").validatebox({
								required : true,
								missingMessage : "请输入物品描述",
							});
							$("#goods_goodIntoTIme_edit").datetimebox({
								value: goods.goodIntoTIme,
							    required: true,
							    showSeconds: true,
							});
							$("#goods_goodsNumb_edit").val(goods.goodsNumb);
							$("#goods_goodsNumb_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入仓库数量",
								invalidMessage : "仓库数量输入不对",
							});
							$("#goods_goodsUserObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#goods_goodsUserObj_user_name_edit").combobox("select", goods.goodsUserObjPri);
									//var data = $("#goods_goodsUserObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#goods_goodsUserObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
