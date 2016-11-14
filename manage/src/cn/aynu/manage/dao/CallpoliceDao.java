package cn.aynu.manage.dao;

import cn.aynu.manage.vo.Callpolice;
import cn.aynu.manage.vo.Pager;

public interface CallpoliceDao {

	Pager<Callpolice> pagelist(String hql, String hqlCount, Integer offset);

}
