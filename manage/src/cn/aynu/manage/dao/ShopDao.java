package cn.aynu.manage.dao;

import java.util.List;

import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.Shop;

public interface ShopDao extends BaseDao<Shop>{
	/**
	 * 所有商铺列表
	 */
	List<Shop> findAllShops(String hql, Object...objects);
	
	/**
	 * 商铺列表页
	 * @param hql
	 * @param hqlCount
	 * @param offset
	 * @return
	 */
	Pager<Shop> pagelist(String hql, String hqlCount, Integer offset);
	
	/**
	 * 根据id获取Shop对象
	 * @param id
	 * @return
	 */
	Shop getShop(Integer id);

	/**
	 * 更新商铺信息
	 * @param shop
	 */
	void update(Shop shop);

	/**
	 * 删除商铺
	 * @param id
	 */
	void delShop(Shop shop);

	/**
	 * 添加商铺
	 * @param shop
	 */
	void addShop(Shop shop);

}
