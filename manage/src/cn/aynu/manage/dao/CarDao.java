package cn.aynu.manage.dao;

import java.util.List;

import cn.aynu.manage.vo.Car;
import cn.aynu.manage.vo.Pager;

public interface CarDao extends BaseDao<Car>{
	  public List<Car> list(); 
	  public Pager<Car> pagelist(String hql,String hqlCount,int offset);
	  public void addCar(Car car);	
	  public Pagebean getPagebean(int pagesize, int page);
	  public Car getCar(int id);
	  public void update(Car car);
	  public void del(int id);
	  /**
	   * 根据 查询参数 Car 查询到一个list
	   * @param Car
	   * @return
	   */
	  public List<Car> getListByArgs(Car car,String hql);
}
