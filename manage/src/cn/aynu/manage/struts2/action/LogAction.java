package cn.aynu.manage.struts2.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import cn.aynu.manage.service.LogService;
import cn.aynu.manage.vo.Log;
import cn.aynu.manage.vo.Pager;

@Controller("logAction")
@Scope("prototype")
public class LogAction extends ActionSupport implements ModelDriven<Log>{
	
	private static final long serialVersionUID = 3751631889837626801L;

	private Log log;
	private Pager<Log> page = null;
	private Integer offset = 1;
	private int pageType = 3;
	private String operStartTime;
	private String operEndTime;
	public String getOperStartTime() {
		return operStartTime;
	}

	public void setOperStartTime(String operStartTime) {
		this.operStartTime = operStartTime;
	}

	public String getOperEndTime() {
		return operEndTime;
	}

	public void setOperEndTime(String operEndTime) {
		this.operEndTime = operEndTime;
	}
	@Resource
	private LogService logService;
	
	public Pager<Log> getPage() {
		return page;
	}

	public void setPage(Pager<Log> page) {
		this.page = page;
	}

	public Integer getOffset() {
		return offset;
	}

	public void setOffset(Integer offset) {
		this.offset = offset;
	}

	public int getPageType() {
		return pageType;
	}

	public void setPageType(int pageType) {
		this.pageType = pageType;
	}

	public LogAction()
	{
		log = new Log();
	}
	
	public String pageList()
	{
		try {
			page = logService.pagelist(log,operStartTime,operEndTime,offset);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "log-list";
	}
	/**
	 * É¾³ý log by UUID
	 * @return
	 */
	public String delByUUID()
	{
		logService.deleteEntity(log);
		return "del-success";
	}
	
	/**
	 * ²éÑ¯
	 * @return
	 */
	public String blurSearch()
	{
		try {
			page = logService.pagelist(log,operStartTime,operEndTime,offset);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "log-list";
	}
	public Log getModel() {
		return log;
	}
	
}
