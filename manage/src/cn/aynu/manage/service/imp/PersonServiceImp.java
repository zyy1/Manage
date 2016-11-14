package cn.aynu.manage.service.imp;

import java.util.List;

import cn.aynu.manage.dao.Pagebean;
import cn.aynu.manage.dao.PersonDao;
import cn.aynu.manage.service.PersonService;
import cn.aynu.manage.util.ValidateUtil;
import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.Person;

public class PersonServiceImp implements PersonService {
	private PersonDao personDao;

	/**
	 * @return the personDao
	 */
	public PersonDao getPersonDao() {
		return personDao;
	}

	/**
	 * @param personDao
	 *            the personDao to set
	 */
	public void setPersonDao(PersonDao personDao) {
		this.personDao = personDao;
	}

	public List<Person> Plist() {
		return personDao.list();
	}

	public Pager<Person> pagelist(int offset) {
		String hql = "from Person p order by p.id desc";
		String hqlCount = "select  count(*)  from Person ";
		return personDao.pagelist(hql, hqlCount, offset);
	}

	/**
	 * 根据参数查询出 一个 分页的list Person
	 * 
	 * @param person
	 */
	public Pager<Person> getPersonListByArgs(Person person, int offset) {
		String hql = "from Person p where 1 = '1'";
		String hqlCount = "select  count(*)  from Person where 1='1'";
		if (ValidateUtil.isValid(person.getIdCard())) {
			hql = hql + " and idCard like '%" + person.getIdCard() + "%'";
			hqlCount = hqlCount + " and idCard like '%" + person.getIdCard() + "%'";
		}
		if (ValidateUtil.isValid(person.getName())) {
			hql = hql + " and name like '%" + person.getName() + "%'";
			hqlCount = hqlCount + " and name like '%" + person.getName() + "%'";
		}
		if (ValidateUtil.isValid(person.getTel())) {
			hql = hql + " and tel like '%" + person.getTel() + "%'";
			hqlCount = hqlCount + " and tel like '%" + person.getTel() + "%'";
		}
		if (ValidateUtil.isValid(person.getWorkCompany())) {
			hql = hql + " and workCompany like '%" + person.getWorkCompany() + "%'";
			hqlCount = hqlCount + " and workCompany like '%" + person.getWorkCompany() + "%'";
		}
		hql = hql + " order by p.id desc";
		return personDao.pagelist(hql, hqlCount, offset);
	}

	public void addperson(Person person) {
		personDao.addperson(person);
	}

	public Pagebean getPagebean(int pagesize, int page) {
		return personDao.getPagebean(pagesize, page);
	}

	public Person getperson(int id) {
		return personDao.getperson(id);
	}

	public void update(Person person) {
		personDao.update(person);
	}

	public void del(int id) {
		personDao.del(id);
	}

}
