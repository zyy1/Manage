package cn.aynu.manage.service;

import java.util.List;

import cn.aynu.manage.dao.Pagebean;
import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.Car;

public interface CarService {
   public List<Car> Plist();
   public Pager<Car> pagelist(int offset);
   public void addCar(Car car);
   public Pagebean getPagebean(int pagesize, int page);
   public Car getCar(int id);
   public void update(Car car);
   public void del(int id);
   
   public Pager<Car> getCarListByArgs(Car car, Integer offset);
}
