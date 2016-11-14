package cn.aynu.manage.service.imp;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.aynu.manage.dao.CallpoliceDao;
import cn.aynu.manage.service.CallpoliceService;
import cn.aynu.manage.vo.Callpolice;
import cn.aynu.manage.vo.Pager;
@Service("callpoliceService")
public class CallpoliceServiceImp implements CallpoliceService {
	@Resource
	private CallpoliceDao callpoliceDao;
	@Override
	public Pager<Callpolice> pagelist(Integer offset) {
		String hql ="from Callpolice c order by c.id desc";
		String hqlCount = "select  count(*)  from Callpolice ";
		return callpoliceDao.pagelist(hql,hqlCount,offset);
	}

}
