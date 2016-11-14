package cn.aynu.manage.dao.imp;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.SessionFactory;

import cn.aynu.manage.dao.Pagebean;
import cn.aynu.manage.dao.PersonDao;
import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.Person;



public class PersonDaoImp extends BaseDaoImpl<Person> implements PersonDao {
	@Resource
	private SessionFactory sessionFactory;
	
	

	/**
	 * @return the sessionFactory
	 */
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}


	/**
	 * @param sessionFactory the sessionFactory to set
	 */
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}


	@SuppressWarnings("unchecked")
	public List<Person> list() {
		// TODO Auto-generated method stub
		int pageOffset =1;
		int pageSize =15;
		String hql ="from Person p order by p.id desc";
		
		return sessionFactory.getCurrentSession().createQuery(hql).setFirstResult((pageOffset-1)*pageSize).setMaxResults(pageSize).list();
	}
     @SuppressWarnings("unchecked")
	public Pager<Person> pagelist(String hql,String hqlCount,int pageOffset){
 		  int pageSize =15;
 		 
 		  //query.setFirstResult(0);--------从第一条记录开始
 	    //query.setMaxResults(4);--------取出四条记录
 		List<Person> datas =sessionFactory.getCurrentSession().createQuery(hql).setFirstResult((pageOffset-1)*pageSize).setMaxResults(pageSize).list();
 		//获得查询总条数
 		int count = ((Long) sessionFactory.getCurrentSession().createQuery(hqlCount).iterate().next()).intValue();
		
 		Pager<Person> pg=new Pager<Person>();
 		pg.setDatas(datas);
		pg.setSize(pageSize);
		pg.setTotal(count);
		pg.setOffset(pageOffset);
    	return pg;
     }


	public void addperson(Person person) {
		sessionFactory.getCurrentSession().save(person);
		
	}  


	@SuppressWarnings("unchecked")
	public Pagebean getPagebean(int pagesize, int page) {
		String hql="from Person";
		Pagebean pagebean=new Pagebean();
		//得到总记录数
	 int allrow=sessionFactory.getCurrentSession().createQuery(hql).list().size();
	 if(allrow==0)
	 {
		 pagebean=null;
	 }
	 else{
		 //得到总页数
		 int allpage=pagebean.allPage(pagesize, allrow);
		 
		 //得到当前页   currentpage要么是1要么是page
		 int currentpage=pagebean.currentpage(page);
		 //得到当前页第一条记录在数据库中的位置
		 int jinlushu=pagebean.jilushu(pagesize, currentpage);
		 //list中放的是本页内的记录
		 List<Person> person=(List<Person>)sessionFactory.getCurrentSession().createQuery(hql).setFirstResult(jinlushu).setMaxResults(pagesize).list();
		 pagebean.setList(person);
		 pagebean.setAllpage(allpage);
		 pagebean.setCurrentpage(currentpage);
		 pagebean.setAllrow(allrow);
	 }
		return pagebean;
	}


	public Person getperson(int id) {
		return (Person) sessionFactory.getCurrentSession().get(Person.class, id);
	}


	public void update(Person person) {
		// TODO Auto-generated method stub
		System.out.println("dao:里面的"+person.getName());
		System.out.println("dao:里面的"+person.getNumber());
		System.out.println(person);
		sessionFactory.getCurrentSession().update(person);
	}


	@Override
	public void del(int id) {
		Person p = this.getperson(id);
		sessionFactory.getCurrentSession().delete(p);
	}
	
  /**
   * 根据 查询参数 person 查询到一个list
   * @param person
   * @return
   */
	public List<Person> getListByArgs(Person person, String hql) {
		
		return null;
	}
	
	
}
