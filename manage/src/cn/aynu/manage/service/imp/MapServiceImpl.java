package cn.aynu.manage.service.imp;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.aynu.manage.dao.CaseinfoDao;
import cn.aynu.manage.dao.MapDao;
import cn.aynu.manage.service.MapService;
import cn.aynu.manage.vo.Caseinfo;
@Service("mapService")
public class MapServiceImpl implements MapService {
	@Resource
	private CaseinfoDao caseinfoDao;
	@Resource
	private MapDao mapDao;
	/**
	 * 返回案件发生的时间和次数List
	 */
	public List<List<Double>> returnAccidentTimeTimesList() {
		List<Caseinfo> caseinfoes = mapDao.returnAllCaseinfoes();
		List<List<Double>> timeTimesList = new ArrayList<List<Double>>();
		Double hours;
		Double minutes;
		Double serious;
		if(null != caseinfoes){
			for(Caseinfo caseinfo : caseinfoes){
				if(null != caseinfo.getCalltime()){
					hours = Double.parseDouble(caseinfo.getCalltime().toString().substring(11, 13));
					minutes = Double.parseDouble("0."+caseinfo.getCalltime().toString().substring(14, 16));
					serious = Double.parseDouble(caseinfo.getSerious().toString());
					if(null != caseinfo.getSerious()){
						List<Double> list = new ArrayList<Double>();
						list.add(hours+minutes);
						list.add(serious);
						timeTimesList.add(list);
					}
				}
			}
		}
		return timeTimesList;
	}
	
	/**
	 * 返回 对比时间 案件数据
	 * @return
	 */
	public List<List<Object>> getCaseTimeData() {
		List<List<Object>> datas = new ArrayList<>();
		List<Object> data0 = new ArrayList<>();
		List<Object> data1 = new ArrayList<>();
		List<Object> data2 = new ArrayList<>();
		for(int i=0;i<24;i++)
		{
			data0.add(getCaseinfoCountBetweenData(i,i+1));
			data1.add(getAvgOutTime(i,i+1));
			data2.add(getAvgDealSuccesstTime(i,i+1));
		}
		datas.add(data0);
		datas.add(data1);
		datas.add(data2);
		return datas;
	}
	
	/**
	 * 得到caseinfo事件在i小时和j小时之间所发生的次数
	 * @param i
	 * @param j
	 * @return
	 */
	public BigInteger getCaseinfoCountBetweenData(Integer i,Integer j)
	{
		String sql = "select count(id) from caseinfo where Hour(callTime) between "+i+" and "+j;
		return (BigInteger) caseinfoDao.uniqueResultBySql(sql);
	}
	
	/**
	 * 得到i小时到j小时 发生案件后 平均出警时间
	 * @return
	 */
	public BigDecimal getAvgOutTime(Integer i,Integer j)
	{
		String sql = "select AVG(TIMESTAMPDIFF(MINUTE,callTime,outTime)) from caseinfo where Hour(callTime) between "+i+" and "+j;
		Object o = caseinfoDao.uniqueResultBySql(sql);
		if(o!=null)
		{
			return  (BigDecimal)o;
		}
		return new BigDecimal(0);
	}
	
	/**
	 * 得到i小时到j小时 发生案件后 平均结案时间
	 * @return
	 */
	public BigDecimal getAvgDealSuccesstTime(Integer i,Integer j)
	{
		String sql = "select AVG(TIMESTAMPDIFF(DAY,callTime,dealSuccessTime)) from caseinfo where Hour(callTime) between "+i+" and "+j;
		Object o = caseinfoDao.uniqueResultBySql(sql);
		if(o!=null)
		{
			return (BigDecimal) o;
		}
		return  new BigDecimal(0);
	}

}
