package cn.aynu.manage.service.imp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;

import cn.aynu.manage.dao.BaseDao;
import cn.aynu.manage.dao.CaseinfoDao;
import cn.aynu.manage.service.CaseinfoService;
import cn.aynu.manage.util.ValidateUtil;
import cn.aynu.manage.vo.Caseinfo;
import cn.aynu.manage.vo.Pager;
@Service("caseinfoService")
public class CaseinfoServiceImp extends BaseServiceImpl<Caseinfo> implements CaseinfoService {
    @Resource
	private CaseinfoDao caseinfoDao;
    
    @Resource
    public void setBaseDao(BaseDao<Caseinfo> baseDao) {
    	super.setBaseDao(baseDao);
    }
    
	public CaseinfoDao getCaseinfoDao() {
		return caseinfoDao;
	}
	public void setCaseinfoDao(CaseinfoDao caseinfoDao) {
		this.caseinfoDao = caseinfoDao;
	}
	@Override
	public Pager<Caseinfo> pagelist(int offset) {
		String hql = "from Caseinfo c order by c.id desc";
		String hqlCount = "select  count(*)  from Caseinfo ";
		return caseinfoDao.pagelist(hql, hqlCount, offset);
	}
    public void del(int id)
    {
    	
    	caseinfoDao.del(id);
    }
	@Override
	public Caseinfo getCaseinfo(int id) {
		return caseinfoDao.getCaseinfo(id);
	}
	@Override
	public void updatecaseinfo(Caseinfo caseinfo) {
		caseinfoDao.updatecaseinfo(caseinfo);		
	}
	@Override
	public void addCaseinfo(Caseinfo caseinfo) {
		caseinfoDao.addCaseinfo(caseinfo);
	}
	@Override
	public Pager<Caseinfo> getPersonListByArgs(int offset,String number,String callStartTime,String callEndTime,String outStartTime,String outEndTime) {
		String hql = "from Caseinfo c where 1 = '1'";
		String hqlCount = "select  count(id)  from Caseinfo where 1='1'";
		
		if(ValidateUtil.isValid(number))
		{
			hql = hql + " and number like '%" +number+ "%'";
			hqlCount = hqlCount + " and number like '%" + number + "%'";
		}
		
		if(ValidateUtil.isValid(callStartTime))
		{
			hql = hql + " and callTime > '" +callStartTime+ "'";
			hqlCount = hqlCount + " and callTime > '" + callStartTime + "'";
		}
		if(ValidateUtil.isValid(callEndTime))
		{
			hql = hql + " and callTime < '" +callEndTime+ "'";
			hqlCount = hqlCount + " and callTime < '" + callEndTime + "'";
		}
		if(ValidateUtil.isValid(outStartTime))
		{
			hql = hql + " and outTime > '" +outStartTime+ "'";
			hqlCount = hqlCount + " and callTime > '" + outStartTime + "'";
		}
		if(ValidateUtil.isValid(outEndTime))
		{
			hql = hql + " and outTime < '" +outEndTime+ "'";
			hqlCount = hqlCount + " and outTime < '" + outEndTime + "'";
		}
		

		hql = hql + " order by c.id desc";
		return caseinfoDao.pagelist(hql, hqlCount, offset);
	}
	
	/**
	 * 返回所有caseinfo的id,坐标和严重性
	 * @return
	 */
	public List<Caseinfo> retrunAllCaseInfoes() {
		String hql = "from Caseinfo";
		return caseinfoDao.retrunAllCaseInfoes(hql);
	}
	public List<Map<String,Object>> getAjaxSpreadData() {
		List<Map<String,Object>> all = new ArrayList<>();
		List<Caseinfo> list = this.retrunAllCaseInfoes();
		List<List<Object>> listDatas[] = new List[6];
		Map<String,Object> map[] = new Map[6];
		for(int i =0;i<6;i++)
		{
			listDatas[i] = new ArrayList<List<Object>>();
			map[i] = new HashMap<String,Object>();
		}
		for(Caseinfo c : list)
		{
			switch (c.getCaseType()) {
			case "1":
			{
				
				List<Object> l = new ArrayList<Object>();
				map[0].put("name", c.getSmallContent());
				map[0].put("color", "red");
				l.add(Double.parseDouble(c.getSiteX()));
				l.add(c.getSerious());
				l.add(Double.parseDouble(c.getSiteY()));
				listDatas[0].add(l);
				break;
			}
				
			case "2":
			{
				List<Object> l = new ArrayList<Object>();
				map[1].put("name", c.getSmallContent());
				map[1].put("color", "black");
				l.add(Double.parseDouble(c.getSiteX()));
				l.add(c.getSerious());
				l.add(Double.parseDouble(c.getSiteY()));
				listDatas[1].add(l);
				break;
			}
			case "3":
			{
				List<Object> l = new ArrayList<Object>();
				map[2].put("name", c.getSmallContent());
				map[2].put("color", "RGB(10,112,55)");
				l.add(Double.parseDouble(c.getSiteX()));
				l.add(c.getSerious());
				l.add(Double.parseDouble(c.getSiteY()));
				listDatas[2].add(l);
				break;
			}
			case "4":
			{
				List<Object> l = new ArrayList<Object>();
				map[3].put("name", c.getSmallContent());
				map[3].put("color", "RGB(6,156,210)");
				l.add(Double.parseDouble(c.getSiteX()));
				l.add(c.getSerious());
				l.add(Double.parseDouble(c.getSiteY()));
				listDatas[3].add(l);
				break;
			}
			case "5":
			{
				List<Object> l = new ArrayList<Object>();
				map[4].put("name", c.getSmallContent());
				map[4].put("color", "RGB(127,206,73)");
				l.add(Double.parseDouble(c.getSiteX()));
				l.add(c.getSerious());
				l.add(Double.parseDouble(c.getSiteY()));
				listDatas[4].add(l);
				break;
			}
			case "6":
			{
				List<Object> l = new ArrayList<Object>();
				map[5].put("name", c.getSmallContent());
				map[5].put("color", "RGB(123,54,118)");
				l.add(Double.parseDouble(c.getSiteX()));
				l.add(c.getSerious());
				l.add(Double.parseDouble(c.getSiteY()));
				listDatas[5].add(l);
				break;
			}
	
			default:
				break;
			}
		}
		//把值加入到all中
		for(int j = 0 ; j<6 ;j++)
		{
			map[j].put("data",listDatas[j]);
			all.add(map[j]);
		}
		return all;
	}
	
	/**
	 * 返回各种类型案件的map(理解错了，这个方法返回的是Map,含有事故类型和次数)
	 * @return
	 */
	public Map<String, Object> returnPerTypeCaseInfoMap() {
		Map<String, Object> map  = new HashMap<String, Object>();
		List<String> caseTypeList = new ArrayList<String>();
		List<String> countList = new ArrayList<String>();
		String hql1 = "select caseType from Caseinfo group by caseType";
		String hql2 = "select count(caseType) from Caseinfo group by caseType";
		caseTypeList = caseinfoDao.returnStringArrByHql(hql1);
		countList = caseinfoDao.returnStringArrByHql(hql2);
		if(null != caseTypeList && null != countList){
			for(int i = 0; i < caseTypeList.size(); i ++){
				map.put(caseTypeList.get(i), countList.get(i));
			}
		}
		System.out.println(map);
		return map;
	}
	
	/**
	 * 返回各种类型案件的发生次数
	 * @return
	 */
	public List<Integer> returnPerTypeCaseInfoCount() {
		List<String> countListString = new ArrayList<String>();
		List<Integer> countListInteger = new ArrayList<Integer>();
		String hql = "select count(caseType) from Caseinfo group by caseType";
		countListString = caseinfoDao.returnStringArrByHql(hql);
		for(int i = 0; i < countListString.size(); i ++){
			countListInteger.add(i, Integer.parseInt(countListString.toArray()[i].toString()));
		}
		return countListInteger;
	}
	
	/**
	 * 返回事故严重性集合
	 */
	public List<Integer> returnAverCaseinfoSeriousList() {
		String hql1 = "select sum(serious) from Caseinfo group by casetype";
		List<String> seriousListString =  caseinfoDao.returnStringArrByHql(hql1);
		List<Integer> averCaseinfoSeriousList = new ArrayList<Integer>();
		List<Integer> caseinfoCount = returnPerTypeCaseInfoCount();
		for(int i = 0; i < seriousListString.size(); i ++){
			averCaseinfoSeriousList.add(Integer.parseInt(seriousListString.toArray()[i].toString())/caseinfoCount.get(i));
		}
		return averCaseinfoSeriousList;
	}

	/**
	 * 风险分析
	 */
	@SuppressWarnings("unchecked")
	public List<Caseinfo>[] riskAnalysis(Caseinfo caseinfo, double d) {
		List<Caseinfo>[] caseinfoRisk = new ArrayList[5];
		try {
		HttpSession session = ServletActionContext.getRequest().getSession();
		 for(int i = 0;i<5 ; i++)
		 {
			 //1.查询方圆5里 案件数量
			 caseinfoRisk[i] = this.findSqlQuery(Caseinfo.class,"select * from caseinfo where (POW((siteX-?),2)+POW((siteY-?),2)) > ? and (POW((siteX-?),2)+POW((siteY-?),2))<?", caseinfo.getSiteX(),caseinfo.getSiteY(),d*i,caseinfo.getSiteX(),caseinfo.getSiteY(),d*(i+1));
			 session.setAttribute("percent", i*21+"%");
			 Thread.sleep(2000);
		 }	
		 session.setAttribute("percent", "100%");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return caseinfoRisk;
	}

	public List<Double> getAvgSeriousByRand() {
		List<Double> riskSerious = new ArrayList<>();
		List<Caseinfo>[] caseinfoRisk = (List<Caseinfo>[]) ServletActionContext.getRequest().getSession().getAttribute("caseinfoRisk");
		if(ValidateUtil.isValid(caseinfoRisk))
		{
			for(int i =0;i<caseinfoRisk.length;i++)
			{
				double sumSerious = 0;
				double avgSerious = 0;
				int count = caseinfoRisk[i].size();
				for(Caseinfo c : caseinfoRisk[i])
				{
					sumSerious = sumSerious + c.getSerious();
				}
				if(count != 0)
				{
					avgSerious = sumSerious/count;
				}
				riskSerious.add(avgSerious);
			}
		}
		return riskSerious;
	}

	/**
	 * 求总板块的严重程度
	 */
	public double getTotalAvgSerious(List<Double> riskSerious) {
		double sum = 0;
		double count = riskSerious.size();
		for(double r : riskSerious)
		{
			sum = sum + r;
		}
		if(count == 0)
		{
			return 0;
		}
		else{
			return sum/count;
		}
	}

	
}
