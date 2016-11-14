package cn.aynu.manage.service;

import cn.aynu.manage.vo.Callpolice;
import cn.aynu.manage.vo.Pager;

public interface CallpoliceService {

	Pager<Callpolice> pagelist(Integer offset);

}
