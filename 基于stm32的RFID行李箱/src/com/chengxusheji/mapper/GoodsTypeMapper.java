package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.GoodsType;

public interface GoodsTypeMapper {
	/*添加物品类型信息*/
	public void addGoodsType(GoodsType goodsType) throws Exception;

	/*按照查询条件分页查询物品类型记录*/
	public ArrayList<GoodsType> queryGoodsType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有物品类型记录*/
	public ArrayList<GoodsType> queryGoodsTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的物品类型记录数*/
	public int queryGoodsTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条物品类型记录*/
	public GoodsType getGoodsType(int goodTypeId) throws Exception;

	/*更新物品类型记录*/
	public void updateGoodsType(GoodsType goodsType) throws Exception;

	/*删除物品类型记录*/
	public void deleteGoodsType(int goodTypeId) throws Exception;

}
