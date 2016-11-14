package cn.aynu.manage.service.imp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.aynu.manage.dao.CarDao;
import cn.aynu.manage.dao.Pagebean;
import cn.aynu.manage.service.CarService;
import cn.aynu.manage.util.ValidateUtil;
import cn.aynu.manage.vo.Car;
import cn.aynu.manage.vo.Pager;

@Service("carService")
public class CarServiceImp implements CarService {
	@Resource
	private CarDao carDao;

	public CarDao getCarDao() {
		return carDao;
	}

	public void setCarDao(CarDao carDao) {
		this.carDao = carDao;
	}

	public List<Car> Plist() {
		return carDao.list();
	}

	public Pager<Car> pagelist(int offset) {
		String hql = "from Car p order by p.id desc";
		String hqlCount = "select  count(*)  from Car ";
		return carDao.pagelist(hql, hqlCount, offset);
	}

	/**
	 * 根据参数查询出 一个 分页的list Car
	 * 
	 * @param car
	 */

	public Pager<Car> getCarListByArgs(Car car, Integer offset) {
		String hql = "from Car p where 1 = '1'";
		String hqlCount = "select  count(*)  from Car where 1='1'";
		if (ValidateUtil.isValid(car.getName())) {
			hql = hql + " and name like '%" + car.getName() + "%'";
			hqlCount = hqlCount + " and name like '%" + car.getName() + "%'";
		}
		if (ValidateUtil.isValid(car.getNumber())) {
			hql = hql + " and number like '%" + car.getNumber() + "%'";
			hqlCount = hqlCount + " and number like '%" + car.getNumber() + "%'";
		}
		if (ValidateUtil.isValid(car.getCarnum())) {
			hql = hql + " and carnum like '%" + car.getCarnum() + "%'";
			hqlCount = hqlCount + " and carnum like '%" + car.getCarnum() + "%'";
		}
		if (ValidateUtil.isValid(car.getCarExplain())) {
			hql = hql + " and carExplain like '%" + car.getCarExplain() + "%'";
			hqlCount = hqlCount + " and carExplain like '%" + car.getCarExplain() + "%'";
		}
		hql = hql + " order by p.id desc";
		return carDao.pagelist(hql, hqlCount, offset);
	}

	public void addCar(Car car) {
		carDao.addCar(car);
	}

	public Pagebean getPagebean(int pagesize, int page) {
		return carDao.getPagebean(pagesize, page);
	}

	public Car getCar(int id) {
		return carDao.getCar(id);
	}

	public void update(Car car) {
		carDao.update(car);
	}

	public void del(int id) {
		carDao.del(id);
	}
}
