package cn.aynu.manage.dao;

import java.util.List;

import cn.aynu.manage.vo.Caseinfo;

public interface MapDao {
	/**
	 * 返回所有案件对象
	 */
	List<Caseinfo> returnAllCaseinfoes();

}
