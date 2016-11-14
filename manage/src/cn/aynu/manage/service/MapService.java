package cn.aynu.manage.service;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface MapService {


	
	/**
	 * 返回 对比时间 案件数据
	 * @return
	 */
	public List<List<Object>> getCaseTimeData();
	/**
	 * 得到caseinfo事件在i小时和j小时之间所发生的次数
	 * @param i
	 * @param j
	 * @return
	 */
	public BigInteger getCaseinfoCountBetweenData(Integer i, Integer j);
	
	/**
	 * 得到i小时到j小时 发生案件后 平均出警时间
	 * @return
	 */
	public BigDecimal getAvgOutTime(Integer i,Integer j);
	
	/**
	 * 得到i小时到j小时 发生案件后 平均结案时间
	 * @return
	 */
	public BigDecimal getAvgDealSuccesstTime(Integer i,Integer j);
	/**
	 * 返回案件发生的时间和次数的map
	 * @return
	 */
	List<List<Double>> returnAccidentTimeTimesList();

}
