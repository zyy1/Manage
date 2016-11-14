package cn.aynu.manage.service.imp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.aynu.manage.dao.ShopDao;
import cn.aynu.manage.service.ShopService;
import cn.aynu.manage.util.ValidateUtil;
import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.Person;
import cn.aynu.manage.vo.Shop;
@Service("shopService")
public class ShopServiceImp implements ShopService {
	
	@Resource
	private ShopDao shopDao;
	
	/**
	 * 所有商铺列表
	 */
	public List<Shop> findAllShops() {
		String hql = "from Shop";
		return shopDao.findAllShops(hql);
	}

	/**
	 * 商铺列表页
	 */
	public Pager<Shop> pageList(Integer offset) {
		String hql ="from Shop shop order by shop.id desc";
		String hqlCount = "select  count(*)  from Shop ";
		return shopDao.pagelist(hql,hqlCount,offset);
	}

	/**
	 * 页面跳转
	 */
	public Pager<Shop> getShopListByArgs(Shop shop, Integer offset) {
		String hql ="from Shop shop where 1 = '1'";
		String hqlCount = "select  count(*)  from Shop where 1='1'";
		if(ValidateUtil.isValid(shop.getShopName()))
		{
			hql = hql + " and shopName like '%"+shop.getShopName()+"%'";
			hqlCount = hqlCount + " and shopName like '%"+shop.getShopName()+"%'";
		}
		if(ValidateUtil.isValid(shop.getBossName()))
		{
			hql = hql + " and bossName like '%"+shop.getBossName()+"%'";
			hqlCount = hqlCount + " and bossName like '%"+shop.getBossName()+"%'";
		}
		if(ValidateUtil.isValid(shop.getShopType()))
		{
			hql = hql + " and shopType like '%"+shop.getShopType()+"%'";
			hqlCount = hqlCount + " and shopType like '%"+shop.getShopType()+"%'";
		}
		if(ValidateUtil.isValid(shop.getUnit()))
		{
			hql = hql + " and unit like '%"+shop.getUnit()+"%'";
			hqlCount = hqlCount + " and unit like '%"+shop.getUnit()+"%'";
		}
		hql = hql +" order by shop.id desc";
		return shopDao.pagelist(hql,hqlCount,offset);
	}

	/**
	 * 根据Id获取shop对象
	 */
	public Shop getShopById(Integer id) {
		return shopDao.getShop(id);
	}

	
	/**
	 * 更新商铺信息
	 */
	public void update(Shop shop) {
		shopDao.update(shop);
	}

	/**
	 * 删除商铺
	 */
	public void delShop(Integer id) {
		shopDao.delShop(getShopById(id));
	}

	/**
	 * 添加商铺
	 */
	public void addShop(Shop shop) {
		shopDao.addShop(shop);
	}

}
