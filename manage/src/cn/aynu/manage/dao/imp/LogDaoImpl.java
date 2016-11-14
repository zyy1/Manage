package cn.aynu.manage.dao.imp;

import org.springframework.stereotype.Repository;

import cn.aynu.manage.dao.LogDao;
import cn.aynu.manage.vo.Log;

@Repository("logDao")
public class LogDaoImpl extends BaseDaoImpl<Log> implements LogDao{

}
