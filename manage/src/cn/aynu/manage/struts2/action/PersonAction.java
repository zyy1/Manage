package cn.aynu.manage.struts2.action;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import cn.aynu.manage.dao.Pagebean;
import cn.aynu.manage.service.PersonService;
import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.Person;

@Controller("personAction")
@Scope("prototype")
public class PersonAction extends ActionSupport implements ModelDriven<Person> {
	private static final long serialVersionUID = 1L;
	@Resource
	private PersonService personService;
	private Person person;
	// 用来接受批量删除数据
	private List<Integer> IDCheck;

	public List<Integer> getIDCheck() {
		return IDCheck;
	}

	public void setIDCheck(List<Integer> iDCheck) {
		IDCheck = iDCheck;
	}

	/**
	 * @return the name
	 */
	private List<Person> list;

	public PersonAction() {
		person = new Person();
	}

	private Pager<Person> page = null;
	private int page1 = 1;

	/**
	 * @return the page1
	 */
	public int getPage1() {
		return page1;
	}

	/**
	 * @param page1
	 *            the page1 to set
	 */
	public void setPage1(int page1) {
		this.page1 = page1;
	}

	private Integer offset = 1;
	private int pageType = 3;

	public int getPageType() {
		return pageType;
	}

	public void setPageType(int pageType) {
		this.pageType = pageType;
	}

	/**
	 * @return the list
	 */
	public List<Person> getList() {
		return list;
	}

	public void setList(List<Person> list) {
		this.list = list;
	}

	public PersonService getPersonService() {
		return personService;
	}

	public void setPersonService(PersonService personService) {
		this.personService = personService;
	}

	public Pager<Person> getPage() {
		return page;
	}

	public void setPage(Pager<Person> page) {
		this.page = page;
	}

	public Integer getOffset() {
		return offset;
	}

	public void setOffset(Integer offset) {
		this.offset = offset;
	}

	public String list() {

		list = personService.Plist();
		if (list != null) {
			return "per_list1";
		}

		return SUCCESS;
	}

	/**
	 * 分页查询标志 （list 、listByArgs）
	 */
	private String selectPageFlag;

	public String getSelectPageFlag() {
		return selectPageFlag;
	}

	public void setSelectPageFlag(String selectPageFlag) {
		this.selectPageFlag = selectPageFlag;
	}

	/**
	 * 模糊查询person
	 * 
	 * @return
	 */
	public String blurSearch() {
		page = personService.getPersonListByArgs(person, offset);
		if (page != null) {
			selectPageFlag = "listByArgs";
			return "per_list";
		} else {
			return ERROR;
		}
	}

	public String pagelist() {
		page = personService.pagelist(offset);
		if (page != null) {
			return "per_list";
		} else {
			return ERROR;
		}
	}

	public String toString() {
		return "PersonAction [personService=" + personService + ", person=" + person + ", list=" + list + ", page="
				+ page + ", page1=" + page1 + ", offset=" + offset + ", pageType=" + pageType + "]";
	}

	public String aaa() {
		return "success";
	}

	public String addPerson() {
		personService.addperson(person);
		return "add-success";
	}

	public String list1() {
		Pagebean pagebean = personService.getPagebean(15, page1);
		ActionContext.getContext().getSession().put("pagebean", pagebean);
		return "list";
	}

	// 鏍规嵁id鏌ヨ
	public String toUpdatePage() {
		person = personService.getperson(person.getId());
		return "toUpdatePage";
	}

	public String updatePerson() {
		personService.update(person);
		return "update-success";
	}

	public String del() {
		personService.del(person.getId());
		return "del";
	}

	public Person getModel() {
		return person;
	}

	/**
	 * 批量删除Person
	 * 
	 * @return
	 */
	public String batchDelPerson() {
		for (Integer id : IDCheck) {
			personService.del(id);
		}
		return "batchDel-success";
	}
	
	public String toAddPersonPage()
	{
		return "toAddPersonPage";
	}
}
