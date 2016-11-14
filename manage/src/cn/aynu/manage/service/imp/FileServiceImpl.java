package cn.aynu.manage.service.imp;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.aynu.manage.dao.CarDao;
import cn.aynu.manage.dao.CaseinfoDao;
import cn.aynu.manage.dao.LogDao;
import cn.aynu.manage.dao.PersonDao;
import cn.aynu.manage.dao.ShopDao;
import cn.aynu.manage.dao.imp.FileDaoImpl;
import cn.aynu.manage.service.FileService;
import cn.aynu.manage.service.LogService;
import cn.aynu.manage.util.LogUtil;
import cn.aynu.manage.vo.Car;
import cn.aynu.manage.vo.Caseinfo;
import cn.aynu.manage.vo.Log;
import cn.aynu.manage.vo.Person;
import cn.aynu.manage.vo.Shop;
import cn.aynu.manage.vo.UploadFile;
@Service("fileService")
public class FileServiceImpl extends BaseServiceImpl<UploadFile> implements FileService {
	
	private static String[] personHeadCell = {"编号","姓名","性别","身份证号","居住类型","楼号","楼层","房间号码","暂住地址","所在公司","职业","电话","居住是由","户籍地址","户口类型","民族","文化程度","婚姻状况","出生日期"};
	private static String[] caseinfoHeadCell = {"编号","报警方式","报警人员","报警时间","摘要","报警内容","案发地点","案件类型","报警者电话","接警人员","出警时间","出警人员","出警车辆","处置情况","处置意见","严重指数","处理警员"};
	private static String[] carHeadCell = {"编号","车辆牌号","购入日期","车主姓名","车主身份","违章记录","车辆型号","发动机号","车辆架号","车主性别","停车场地"};
	private static String[] shopHeadCell = {"编号","房间","行业","楼层","地址","店名","店主","店主身份证"};
	private static String[] logHeadCell = {"UUID","操作参数","操作结果","操作方法","操作人","返回值","操作时间"};
	
	@Resource
	private FileDaoImpl fileDao;
	/**
	 * 获取现存已上传的文件
	 */
	public List<UploadFile> findExistingFilesByOwnerId(Integer ownerId, String attachmentType) {
		String hql = "from UploadFile where ownerId = ? and attachmentType = ?";
		return fileDao.findEntityByHQL(hql, ownerId, attachmentType);
	}
	
	/**
	 * 上传文件
	 */
	public void upload(UploadFile c) {
		fileDao.saveEntity(c);
	}

	/**
	 * 根据Id获取文件
	 */
	public UploadFile getDestFileByFileId(Integer id) {
		return fileDao.getEntity(id);
	}

	/**
	 * 删除文件
	 */
	public void deleteFileInfoByFileId(Integer id) {
		fileDao.deleteEntity(getDestFileByFileId(id));
	}

	
	/**
	 * 得到要导出的 数据   :  反射的方法    ===》无序 舍弃了
	 * @return
	 */
	public List<List<String>> getDataListForExcelQuit(String kind,Class clazz,List<String> headers) {
			List<List<String>> excelData = new ArrayList<>();
			List<Object> list = caseinfoDao.findSqlQuery(clazz, "select * from "+kind);
			List<String> rowData = null;
			for(Object c : list)
			{
				rowData = new ArrayList<String>();
				Method []methods = c.getClass().getDeclaredMethods();
				for(Method m : methods)
				{
					if(m.getName().startsWith("get") && !m.getName().equals("getId"))
						{
							try {
								rowData.add(m.invoke(c)+"");
							} catch (Exception e) {
								e.printStackTrace();
							}
							headers.add(m.getName());
						}
				}
				excelData.add(rowData);
			}
		return excelData;
	}

	
	@Resource
	private CaseinfoDao caseinfoDao;
	@Resource
	private PersonDao personDao;
	@Resource
	private CarDao carDao;
	@Resource
	private ShopDao shopDao;
	@Resource
	private LogService logService;
	/**
	 * 得到要导出的 数据 
	 * @return
	 */
	public Map<String,Object> getDataListForExcel(String kind , Object...objects) {
		Map<String,Object> map = new HashMap<>();
		List<List<String>> excelData = new ArrayList<>();
		switch (kind) {
		case "caseinfo":
		{
			map.put("headCell", caseinfoHeadCell);
			try {
				map.put("exportFileName", new String("案件信息.xls".getBytes(), "iso-8859-1"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			List<String> rowData = null;
			List<Caseinfo> list = caseinfoDao.findEntityByHQL("from Caseinfo");
			for(Caseinfo c : list)
			{
				rowData = new ArrayList<>();
				rowData.add(c.getNumber()+"");
				rowData.add(c.getCalltype()+"");
				rowData.add(c.getCallper()+"");
				rowData.add(c.getCalltime()+"");
				rowData.add(c.getSmallContent()+"");
				rowData.add(c.getContent()+"");
				rowData.add(c.getAddress()+"");
				rowData.add(c.getCaseType()+"");
				rowData.add(c.getPhone()+"");
				rowData.add(c.getReceive()+"");
				rowData.add(c.getOuttime()+"");
				rowData.add(c.getOutper()+"");
				rowData.add(c.getOutcar()+"");
				rowData.add(c.getDealwith()+"");
				rowData.add(c.getSugge()+"");
				rowData.add(c.getSerious()+"");
				rowData.add(c.getDealper()+"");
				
				excelData.add(rowData);
			}
			break;
		}
		case "person" :
		{
			try {
				map.put("exportFileName", new String("人口信息.xls".getBytes(), "iso-8859-1"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			map.put("headCell", personHeadCell);
			List<String> rowData = null;
			List<Person> list = personDao.findEntityByHQL("from Person");
			for(Person p : list)
			{
				rowData = new ArrayList<>();
				rowData.add(p.getNumber()+"");
				rowData.add(p.getName()+"");
				rowData.add(p.getSex()+"");
				rowData.add(p.getIdCard()+"");
				rowData.add(p.getType()+"");
				rowData.add(p.getUnit()+"");
				rowData.add(p.getFloor()+"");
				rowData.add(p.getRoom()+"");
				rowData.add(p.getAddress()+"");
				rowData.add(p.getWorkCompany()+"");
				rowData.add(p.getProfessional()+"");
				rowData.add(p.getTel()+"");
				rowData.add(p.getLiveReason()+"");
				rowData.add(p.getHousehold()+"");
				rowData.add(p.getHouseholdType()+"");
				rowData.add(p.getNational()+"");
				rowData.add(p.getCulturalLevel()+"");
				rowData.add(p.getMaritalStatus()+"");
				rowData.add(p.getBirthday()+"");
				excelData.add(rowData);
			}
			break;
		}
		
		case "car" :
		{
			try {
				map.put("exportFileName", new String("车辆信息.xls".getBytes(), "iso-8859-1"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			map.put("headCell", carHeadCell);
			List<String> rowData = null;
			List<Car> list = carDao.findEntityByHQL("from Car");
			for(Car c : list)
			{
				rowData = new ArrayList<>();
				
				rowData.add(c.getNumber()+"");
				rowData.add(c.getCarnum()+"");
				rowData.add(c.getDay()+"");
				rowData.add(c.getName()+"");
				rowData.add(c.getId()+"");
				rowData.add(c.getRemark()+"");
				rowData.add(c.getCarExplain()+"");
				rowData.add(c.getNuma()+"");
				rowData.add(c.getNumb()+"");
				rowData.add(c.getSex()+"");
				rowData.add(c.getAddress()+"");
				excelData.add(rowData);
			}
			break;
		}
		
	case "shop" :
	{
		try {
			map.put("exportFileName", new String("商铺信息.xls".getBytes(), "iso-8859-1"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		map.put("headCell", shopHeadCell);
		List<String> rowData = null;
		List<Shop> list = shopDao.findEntityByHQL("from Shop");
		for(Shop s : list)
		{
			rowData = new ArrayList<>();
			
			rowData.add(s.getNumber()+"");
			rowData.add(s.getRoom()+"");
			rowData.add(s.getShopType()+"");
			rowData.add(s.getFloor()+"");
			rowData.add(s.getUnit()+"");
			rowData.add(s.getShopName()+"");
			rowData.add(s.getBossName()+"");
			rowData.add(s.getBossIdCard()+"");
			
			excelData.add(rowData);
		}
		break;
	}
	case "log" :
	{
		try {
			map.put("exportFileName", new String("日志信息.xls".getBytes(), "iso-8859-1"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		map.put("headCell", logHeadCell);
		String operator = (String) objects[0];
		String operResult = (String) objects[1];
		String operStartTime = (String) objects[2];
		String operEndTime = (String) objects[3];
		//默认查询最近三个月
		int i = 3;
		try {
			i = LogUtil.calculateMonthsBetweenTwoDate(operStartTime, operEndTime);
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<String> rowData = null;
		Map<String,Object> newMap = logService.findNearLogs(operator,operResult,i, operStartTime, operEndTime,-1);
		@SuppressWarnings("unchecked")
		List<Log> list = (List<Log>) newMap.get("logs");
		for(Log l : list)
		{
			rowData = new ArrayList<>();
			
			rowData.add(l.getId()+"");
			rowData.add(l.getOperParams()+"");
			rowData.add(l.getOperResult()+"");
			rowData.add(l.getOperName()+"");
			rowData.add(l.getOperator()+"");
			rowData.add(l.getResultMsg()+"");
			rowData.add(l.getOperTime()+"");
			
			excelData.add(rowData);
		}
		break;
	}
	default:
		break;
	}
		map.put("excelData", excelData);
		return map;
	}

}
