package cn.aynu.manage.struts2.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.aynu.manage.service.MapService;

@Controller
@Scope("prototype")
public class MapAction {
	@Resource
	private MapService mapService;

	
	private List<List<Double>> timeTimesList = new ArrayList<List<Double>>();
	
	public String to3DMapPage()
	{
		return "to3DMapPage";
	}
	
	public String toMessMapPage()
	{
		return "toMessMapPage";
	}
	
	public String toAnalyCaseSpread3DPage()
	{
		return "toAnalyCaseSpread3DPage";
	}
	private List<List<Object>> caseTimeData;
	/**
	 * 返回案件 图表时间对比 数据
	 * @return
	 */
	public String returnCaseTimeData()
	{
		this.setCaseTimeData(mapService.getCaseTimeData());
		return "toCaseOutCarTimePage";
	}

	public List<List<Object>> getCaseTimeData() {
		return caseTimeData;
	}

	public void setCaseTimeData(List<List<Object>> caseTimeData) {
		this.caseTimeData = caseTimeData;
	}

	
	/**
	 * 跳转到案件发生时间分析页面
	 * @return
	 */
	public String toAccidentTimeAnalysPage(){
		return "toAccidentTimeAnalysPage";
	}
	
	/**
	 * 案件发生时间分析
	 * @return
	 */
	public String accidentTimeAnalys(){
		timeTimesList = mapService.returnAccidentTimeTimesList();
		return "retrunTimeTimesMap";
	}

	/**
	 * 到达案件数据 出警时间 结案时间统计界面
	 * @return
	 */
	public String toPicTimeDataPage()
	{
		return "toPicTimeDataPage";
	}
	
	
	/**
	 * setter/getter
	 */
	public List<List<Double>> getTimeTimesList() {
		return timeTimesList;
	}
	public void setTimeTimesList(List<List<Double>> timeTimesList) {
		this.timeTimesList = timeTimesList;
	}
}
