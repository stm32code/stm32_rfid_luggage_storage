var goodsOut_manage_tool = null; 
$(function () { 
	initGoodsOutManageTool(); //建立GoodsOut管理对象
	goodsOut_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#goodsOut_manage").datagrid({
		url : 'GoodsOut/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "outId",
		sortOrder : "desc",
		toolbar : "#goodsOut_manage_tool",
		columns : [[
			{
				field : "outId",
				title : "出箱id",
				width : 70,
			},
			{
				field : "outGoodsRfid",
				title : "物品出箱id",
				width : 140,
			},
			{
				field : "outNumb",
				title : "出箱数量",
				width : 70,
			},
			{
				field : "outTime",
				title : "出箱时间",
				width : 140,
			},
			{
				field : "goodsRfid",
				title : "物品rfid",
				width : 140,
			},
		]],
	});

	$("#goodsOutEditDiv").dialog({
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
				if ($("#goodsOutEditForm").form("validate")) {
					//验证表单 
					if(!$("#goodsOutEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#goodsOutEditForm").form({
						    url:"GoodsOut/" + $("#goodsOut_outId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#goodsOutEditDiv").dialog("close");
			                        goodsOut_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#goodsOutEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#goodsOutEditDiv").dialog("close");
				$("#goodsOutEditForm").form("reset"); 
			},
		}],
	});
});

function initGoodsOutManageTool() {
	goodsOut_manage_tool = {
		init: function() {
			$.ajax({
				url : "Goods/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#outGoodsRfid_goodsId_query").combobox({ 
					    valueField:"goodsId",
					    textField:"goodsName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{goodsId:0,goodsName:"不限制"});
					$("#outGoodsRfid_goodsId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#goodsOut_manage").datagrid("reload");
		},
		redo : function () {
			$("#goodsOut_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#goodsOut_manage").datagrid("options").queryParams;
			queryParams["outGoodsRfid.goodsId"] = $("#outGoodsRfid_goodsId_query").combobox("getValue");
			queryParams["outTime"] = $("#outTime").datebox("getValue"); 
			queryParams["goodsRfid"] = $("#goodsRfid").val();
			$("#goodsOut_manage").datagrid("options").queryParams=queryParams; 
			$("#goodsOut_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#goodsOutQueryForm").form({
			    url:"GoodsOut/OutToExcel",
			});
			//提交表单
			$("#goodsOutQueryForm").submit();
		},
		remove : function () {
			var rows = $("#goodsOut_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var outIds = [];
						for (var i = 0; i < rows.length; i ++) {
							outIds.push(rows[i].outId);
						}
						$.ajax({
							type : "POST",
							url : "GoodsOut/deletes",
							data : {
								outIds : outIds.join(","),
							},
							beforeSend : function () {
								$("#goodsOut_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#goodsOut_manage").datagrid("loaded");
									$("#goodsOut_manage").datagrid("load");
									$("#goodsOut_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#goodsOut_manage").datagrid("loaded");
									$("#goodsOut_manage").datagrid("load");
									$("#goodsOut_manage").datagrid("unselectAll");
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
			var rows = $("#goodsOut_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "GoodsOut/" + rows[0].outId +  "/update",
					type : "get",
					data : {
						//outId : rows[0].outId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (goodsOut, response, status) {
						$.messager.progress("close");
						if (goodsOut) { 
							$("#goodsOutEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
