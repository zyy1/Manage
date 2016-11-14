package cn.aynu.manage.service;

import java.util.List;
import java.util.Map;

import cn.aynu.manage.vo.Caseinfo;
import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.Person;


public interface CaseinfoService extends BaseService<Caseinfo>{
	public Pager<Caseinfo> pagelist(int offset);
	public void del(int id);
	public Caseinfo getCaseinfo(int id);
	public void updatecaseinfo(Caseinfo caseinfo);
	public void addCaseinfo(Caseinfo caseinfo);
	/**
	 * 根据参数查询出 一个 分页的list Person
	 * 
	 * @param person
	 */
	public Pager<Caseinfo> getPersonListByArgs(int offset,String number,String callStartTime,String callEndTime,String outStartTime,String outEndTime);
	
	/**
	 * 返回所有caseinfo的id,坐标和严重性
	 * @return
	 */
	public List<Caseinfo> retrunAllCaseInfoes();
	/**
	 * 返回分布数据
	 * @return
	 */
	public List<Map<String,Object>> getAjaxSpreadData();
	
	/**
	 * 返回各种类型案件的发生次数
	 * @return
	 */
	public List<Integer> returnPerTypeCaseInfoCount();
	
	/**
	 * 返回各种类型案件的map(理解错了，这个方法返回的是Map,含有事故类型和次数)
	 * @return
	 */
	public Map<String, Object> returnPerTypeCaseInfoMap();
	
	/**
	 * 返回事故严重性集合
	 * @return
	 */
	public List<Integer> returnAverCaseinfoSeriousList();
	
	/**
	 * 风险分析
	 * @param d 
	 * @param string2 
	 * @param string 
	 * @return
	 */
	public List<Caseinfo>[] riskAnalysis(Caseinfo caseinfo, double d);
	/**
	 * 根据范围求各个板块的平均严重程度
	 * @return 
	 */
	public List<Double> getAvgSeriousByRand();
	/**
	 * 求总板块 的 案件 严重程度
	 * @param riskSerious 
	 * @return
	 */
	public double getTotalAvgSerious(List<Double> riskSerious);
	
}
