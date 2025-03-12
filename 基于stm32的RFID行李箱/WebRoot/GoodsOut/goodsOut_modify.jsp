<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/goodsOut.css" />
<div id="goodsOut_editDiv">
	<form id="goodsOutEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">出箱id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsOut_outId_edit" name="goodsOut.outId" value="<%=request.getParameter("outId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">物品出箱id:</span>
			<span class="inputControl">
				<input class="textbox"  id="goodsOut_outGoodsRfid_goodsId_edit" name="goodsOut.outGoodsRfid.goodsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">出箱数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsOut_outNumb_edit" name="goodsOut.outNumb" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">出箱时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsOut_outTime_edit" name="goodsOut.outTime" />

			</span>

		</div>
		<div>
			<span class="label">物品rfid:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsOut_goodsRfid_edit" name="goodsOut.goodsRfid" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="goodsOutModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/GoodsOut/js/goodsOut_modify.js"></script> 
