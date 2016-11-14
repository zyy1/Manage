package cn.aynu.manage.struts2.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import cn.aynu.manage.service.CarService;
import cn.aynu.manage.vo.Car;
import cn.aynu.manage.vo.Pager;

@Controller
@Scope("prototype")
public class CarAction extends ActionSupport implements ModelDriven<Car>{
	private static final long serialVersionUID = 8418399327924777512L;
	private Car car = null;
	public CarAction(){
		car = new Car();
	}
	public Car getModel() {
		return car;
	}
	
	private Integer offset = 1;
	public Integer getOffset() {
		return offset;
	}
	public void setOffset(Integer offset) {
		this.offset = offset;
	}
	private Pager<Car> page;
	public Pager<Car> getPage() {
		return page;
	}
	public void setPage(Pager<Car> page) {
		this.page = page;
	}
	@Resource
	private CarService carService;
	/**
	 * 分页查询car
	 * @return
	 */
	public String pagelist()
	{
		page = carService.pagelist(offset);
		return "car-list";
	}
	/**
	 * 模糊查询car
	 * 
	 * @return
	 */
	public String blurSearch() {
		page = carService.getCarListByArgs(car,offset);
		if (page != null) {
			//selectPageFlag = "listByArgs";
			return "car-list";
		}
		else {
			return ERROR;
		}
	}
	
	public String del()
	{
		carService.del(car.getId());
		return "del-success";
	}
	/**
	 * 到编辑界面
	 * @return
	 */
	public String toUpdatePage()
	{
		car = carService.getCar(car.getId());
		System.out.println(car);
		return "toUpdatePage";
	}
	
	/**
	 * 修改车辆信息
	 * @return
	 */
	public String updateCar()
	{
		carService.update(car);
		return "update-success";
	}
	/**
	 * 添加车辆信息
	 * @return
	 */
	public String addCar()
	{
		carService.addCar(car);
		return "add-success";
	}
	
	public String toAddCarPage()
	{
		return "toAddCarPage";
	}
}
