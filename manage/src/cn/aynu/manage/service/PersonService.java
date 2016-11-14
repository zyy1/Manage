package cn.aynu.manage.service;

import java.util.List;

import cn.aynu.manage.dao.Pagebean;
import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.Person;

public interface PersonService {
	public List<Person> Plist();

	public Pager<Person> pagelist(int offset);

	public void addperson(Person person);

	public Pagebean getPagebean(int pagesize, int page);

	public Person getperson(int id);

	public void update(Person person);

	public void del(int id);

	/**
	 * 根据参数查询出 一个 分页的list Person
	 * 
	 * @param person
	 */
	public Pager<Person> getPersonListByArgs(Person person, int offset);
}
