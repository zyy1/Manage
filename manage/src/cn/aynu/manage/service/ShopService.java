package cn.aynu.manage.service;

import java.util.List;

import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.Person;
import cn.aynu.manage.vo.Shop;

public interface ShopService {
	/**
	 * 所有商铺列表
	 */
	List<Shop> findAllShops();
	/**
	 * 商铺列表页
	 * @param offset
	 * @return
	 */
	Pager<Shop> pageList(Integer offset);
	
	/**
	 * 页面跳转
	 */
	Pager<Shop> getShopListByArgs(Shop shop, Integer offset);
	
	/**
	 * 根据id获取shop对象
	 * @param id
	 * @return
	 */
	Shop getShopById(Integer id);
	
	/**
	 * 更新商铺信息
	 * @param shop
	 */
	void update(Shop shop);
	
	/**
	 * 删除商铺
	 * @param id
	 */
	void delShop(Integer id);
	
	/**
	 * 添加商铺
	 * @param shop
	 */
	void addShop(Shop shop);

}
