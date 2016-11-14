package cn.aynu.manage.dao;

import java.util.List;

import org.apache.poi.ss.formula.functions.T;

import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.Person;

public interface PersonDao extends BaseDao<Person>{
	public List<Person> list();

	public Pager<Person> pagelist(String hql, String hqlCount, int offset);

	public void addperson(Person person);

	public Pagebean getPagebean(int pagesize, int page);

	public Person getperson(int id);

	public void update(Person person);

	public void del(int id);

	/**
	 * 根据 查询参数 person 查询到一个list
	 * 
	 * @param person
	 * @return
	 */
	public List<Person> getListByArgs(Person person, String hql);
}
