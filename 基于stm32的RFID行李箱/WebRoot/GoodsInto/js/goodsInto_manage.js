var goodsInto_manage_tool = null; 
$(function () { 
	initGoodsIntoManageTool(); //建立GoodsInto管理对象
	goodsInto_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#goodsInto_manage").datagrid({
		url : 'GoodsInto/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "goodsintoId",
		sortOrder : "desc",
		toolbar : "#goodsInto_manage_tool",
		columns : [[
			{
				field : "goodsintoId",
				title : "物品入箱id",
				width : 70,
			},
			{
				field : "goodsIntoObj",
				title : "入箱物品",
				width : 140,
			},
			{
				field : "intoNumb",
				title : "入箱数量",
				width : 70,
			},
			{
				field : "intoTIme",
				title : "入箱时间",
				width : 140,
			},
			{
				field : "goodsRfid",
				title : "物品rfid",
				width : 140,
			},
		]],
	});

	$("#goodsIntoEditDiv").dialog({
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
				if ($("#goodsIntoEditForm").form("validate")) {
					//验证表单 
					if(!$("#goodsIntoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#goodsIntoEditForm").form({
						    url:"GoodsInto/" + $("#goodsInto_goodsintoId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#goodsIntoEditDiv").dialog("close");
			                        goodsInto_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#goodsIntoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#goodsIntoEditDiv").dialog("close");
				$("#goodsIntoEditForm").form("reset"); 
			},
		}],
	});
});

function initGoodsIntoManageTool() {
	goodsInto_manage_tool = {
		init: function() {
			$.ajax({
				url : "Goods/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#goodsIntoObj_goodsId_query").combobox({ 
					    valueField:"goodsId",
					    textField:"goodsName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{goodsId:0,goodsName:"不限制"});
					$("#goodsIntoObj_goodsId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#goodsInto_manage").datagrid("reload");
		},
		redo : function () {
			$("#goodsInto_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#goodsInto_manage").datagrid("options").queryParams;
			queryParams["goodsIntoObj.goodsId"] = $("#goodsIntoObj_goodsId_query").combobox("getValue");
			queryParams["intoTIme"] = $("#intoTIme").datebox("getValue"); 
			queryParams["goodsRfid"] = $("#goodsRfid").val();
			$("#goodsInto_manage").datagrid("options").queryParams=queryParams; 
			$("#goodsInto_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#goodsIntoQueryForm").form({
			    url:"GoodsInto/OutToExcel",
			});
			//提交表单
			$("#goodsIntoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#goodsInto_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var goodsintoIds = [];
						for (var i = 0; i < rows.length; i ++) {
							goodsintoIds.push(rows[i].goodsintoId);
						}
						$.ajax({
							type : "POST",
							url : "GoodsInto/deletes",
							data : {
								goodsintoIds : goodsintoIds.join(","),
							},
							beforeSend : function () {
								$("#goodsInto_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#goodsInto_manage").datagrid("loaded");
									$("#goodsInto_manage").datagrid("load");
									$("#goodsInto_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#goodsInto_manage").datagrid("loaded");
									$("#goodsInto_manage").datagrid("load");
									$("#goodsInto_manage").datagrid("unselectAll");
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
			var rows = $("#goodsInto_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "GoodsInto/" + rows[0].goodsintoId +  "/update",
					type : "get",
					data : {
						//goodsintoId : rows[0].goodsintoId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (goodsInto, response, status) {
						$.messager.progress("close");
						if (goodsInto) { 
							$("#goodsIntoEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
