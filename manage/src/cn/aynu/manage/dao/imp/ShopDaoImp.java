package cn.aynu.manage.dao.imp;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import cn.aynu.manage.dao.ShopDao;
import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.Person;
import cn.aynu.manage.vo.Shop;
@Repository("shopDao")
public class ShopDaoImp extends BaseDaoImpl<Shop> implements ShopDao {
	
	@Resource
	private SessionFactory sessionFactory;
	
	/**
	 * 所有商铺列表
	 */
	@SuppressWarnings("unchecked")
	public List<Shop> findAllShops(String hql, Object...objects) {
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		for(int i=0; i < objects.length; i++){
			query.setParameter(i, objects[i]);
		}
		return query.list();
	}

	/**
	 * 商铺列表页
	 * @param hql
	 * @param hqlCount
	 * @param offset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Pager<Shop> pagelist(String hql, String hqlCount, Integer offset) {
		  int pageSize =15;
			List<Shop> datas =sessionFactory.getCurrentSession().createQuery(hql).setFirstResult((offset-1)*pageSize).setMaxResults(pageSize).list();
	 		int count = ((Long) sessionFactory.getCurrentSession().createQuery(hqlCount).iterate().next()).intValue();
			
	 		Pager<Shop> pg=new Pager<Shop>();
	 		pg.setDatas(datas);
			pg.setSize(pageSize);
			pg.setTotal(count);
			pg.setOffset(offset);
	    	return pg; 
	}

	/**
	 * 根据id获取shop对象
	 */
	public Shop getShop(Integer id) {
		return (Shop) sessionFactory.getCurrentSession().get(Shop.class, id);
	}

	/**
	 * 更新商铺信息
	 */
	public void update(Shop shop) {
		sessionFactory.getCurrentSession().update(shop);
	}

	/**
	 * 删除商铺
	 */
	public void delShop(Shop shop) {
		sessionFactory.getCurrentSession().delete(shop);;
	}

	/**
	 * 添加商铺
	 */
	public void addShop(Shop shop) {
		sessionFactory.getCurrentSession().save(shop);
	}

}
