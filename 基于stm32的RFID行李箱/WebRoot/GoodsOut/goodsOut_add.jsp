<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/goodsOut.css" />
<div id="goodsOutAddDiv">
	<form id="goodsOutAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">物品出箱id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsOut_outGoodsRfid_goodsId" name="goodsOut.outGoodsRfid.goodsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">出箱数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsOut_outNumb" name="goodsOut.outNumb" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">出箱时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsOut_outTime" name="goodsOut.outTime" />

			</span>

		</div>
		<div>
			<span class="label">物品rfid:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsOut_goodsRfid" name="goodsOut.goodsRfid" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="goodsOutAddButton" class="easyui-linkbutton">添加</a>
			<a id="goodsOutClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/GoodsOut/js/goodsOut_add.js"></script> 
