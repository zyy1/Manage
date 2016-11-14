package cn.aynu.manage.struts2.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.util.ServletContextAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import cn.aynu.manage.service.CaseinfoService;
import cn.aynu.manage.service.CaseinfoUploadFileService;
import cn.aynu.manage.util.ValidateUtil;
import cn.aynu.manage.vo.Caseinfo;
import cn.aynu.manage.vo.UploadFile;
import cn.aynu.manage.vo.Pager;
@Controller("caseinfoAction")
@Scope("prototype")
@SuppressWarnings("serial")
public class CaseinfoAction extends ActionSupport implements ModelDriven<Caseinfo>,ServletContextAware,SessionAware {
	private String callStartTime;
	private String callEndTime;
	private String outStartTime;
	private String outEndTime;
    public String getCallStartTime() {
		return callStartTime;
	}
	public void setCallStartTime(String callStartTime) {
		this.callStartTime = callStartTime;
	}
	public String getCallEndTime() {
		return callEndTime;
	}
	public void setCallEndTime(String callEndTime) {
		this.callEndTime = callEndTime;
	}
	public String getOutStartTime() {
		return outStartTime;
	}
	public void setOutStartTime(String outStartTime) {
		this.outStartTime = outStartTime;
	}
	public String getOutEndTime() {
		return outEndTime;
	}
	public void setOutEndTime(String outEndTime) {
		this.outEndTime = outEndTime;
	}

	@Resource
	private  CaseinfoService caseinfoService;
    private List<Integer> IDCheck;
    private Pager<Caseinfo> page = null;
    private Integer offset = 1;
	private int pageType = 3;
	//各类型事故发生的次数集合
	private List<Integer> caseinfoCount = new ArrayList<Integer>();
	//各事故发生的次数中的最大值
	private Integer maxCaseinfoCount;
	//各类型事故平均严重性
	private List<Integer> averCaseinfoSerious = new ArrayList<Integer>();
	//已上传的所有文件
	private List<UploadFile> existingFiles;
	private boolean delFlag;
	private Caseinfo caseinfo;
	private List<Map<String,Object>> spreadData = new ArrayList<>();
	private List<Map<String,Object>> cases = new ArrayList<Map<String,Object>>();
	
	public List<Integer> getIDCheck() {
		return IDCheck;
	}
	public CaseinfoAction(){
		caseinfo = new Caseinfo();
	}
	public void setIDCheck(List<Integer> iDCheck) {
		IDCheck = iDCheck;
	}

	private Integer fileId;
	public Integer getFileId() {
		return fileId;
	}
	public void setFileId(Integer fileId) {
		this.fileId = fileId;
	}
	/**
	 * 删除附件
	 */
	public String deleteExistingFileByFileId(){
		UploadFile caseinfoUploadFile = caseinfoUploadFileService.getDestFileByFileId(fileId);
		String realUrl = servletContext.getRealPath(caseinfoUploadFile.getUrl());
		File destFile = new File(realUrl);
		if(destFile.exists()){
			try {
				caseinfoUploadFileService.deleteFileInfoByFileId(fileId);
				destFile.delete();
			} catch (Exception e) {
				e.printStackTrace();
			}
			jsonMap.put("flag", 1);
		}
		return "deleteExistingFile";
	}
	
	private String fileRealName;
	public String getFileRealName() {
		return fileRealName;
	}
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	private UploadFile caseinfoUploadFile;
	public UploadFile getCaseinfoUploadFile() {
		return caseinfoUploadFile;
	}
	public void setCaseinfoUploadFile(UploadFile caseinfoUploadFile) {
		this.caseinfoUploadFile = caseinfoUploadFile;
	}
	private String downloadFileName;
	public String getDownloadFileName() {
		return downloadFileName;
	}
	public void setDownloadFileName(String downloadFileName) {
		this.downloadFileName = downloadFileName;
	}
	//下载附件
	public String downloadFile() throws UnsupportedEncodingException{
		caseinfoUploadFile = caseinfoUploadFileService.getDestFileByFileId(fileId);
		this.setDownloadFileName(new String(caseinfoUploadFile.getFileName().getBytes(),"iso-8859-1"));
		this.setFileRealName(servletContext.getRealPath(caseinfoUploadFile.getUrl()));
		return "download";
	}
			
	//附件下载需要的流
	public InputStream getInputStream() throws Exception{
		File f = new File(getFileRealName());
		InputStream stream = new FileInputStream(f);
		return stream;
	}
	
	public Pager<Caseinfo> getPage() {
		return page;
	}

	public void setPage(Pager<Caseinfo> page) {
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

	public List<Integer> getCaseinfoCount() {
		return caseinfoCount;
	}

	public void setCaseinfoCount(List<Integer> caseinfoCount) {
		this.caseinfoCount = caseinfoCount;
	}

	public Integer getMaxCaseinfoCount() {
		return maxCaseinfoCount;
	}

	public void setMaxCaseinfoCount(Integer maxCaseinfoCount) {
		this.maxCaseinfoCount = maxCaseinfoCount;
	}

	public List<Integer> getAverCaseinfoSerious() {
		return averCaseinfoSerious;
	}

	public void setAverCaseinfoSerious(List<Integer> averCaseinfoSerious) {
		this.averCaseinfoSerious = averCaseinfoSerious;
	}


	public List<UploadFile> getExistingFiles() {
		return existingFiles;
	}
	public void setExistingFiles(List<UploadFile> existingFiles) {
		this.existingFiles = existingFiles;
	}
	public List<Map<String, Object>> getCases() {
		return cases;
	}

	public void setCases(List<Map<String, Object>> cases) {
		this.cases = cases;
	}

	public List<Map<String, Object>> getSpreadData() {
		return spreadData;
	}

	private File file;
	private String fileFileName;
	private String fileContentType;
	private ServletContext servletContext;
	private Map<String, Object> jsonMap = new HashMap<String, Object>();
	
	/**
	 * 到添加事件界面
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public String toAddCaseinfoPage() throws UnsupportedEncodingException
	{
		if(ValidateUtil.isValid(caseinfo.getAddress()))
		{
			try {
				caseinfo.setAddress(URLDecoder.decode(caseinfo.getAddress(),"utf-8"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		return "toAddCaseinfoPage";
	}
	
	public String pagelist(){
		page = caseinfoService.pagelist(offset);
            if (page != null) {
			return "case_list";
		} else {
			return ERROR;
		}
	}
    public String del(){
    	caseinfoService.del(caseinfo.getId());
    	return "del";
    }
    public boolean isDelFlag() {
		return delFlag;
	}

	public void setDelFlag(boolean delFlag) {
		this.delFlag = delFlag;
	}

	public String ajaxDel(){
		delFlag = true;
    	try {
			caseinfoService.del(caseinfo.getId());
		} catch (Exception e) {
			delFlag = false;
			e.printStackTrace();
		}
    	return "ajax-success";
    }
	public Caseinfo getModel() {
		return caseinfo;
	}
   //编辑
	public String  toUpdatePage()
	{ 
		 caseinfo = caseinfoService.getCaseinfo(caseinfo.getId());
		 return "toUpdatePage";
	}
	//更新
	public String updateCaseinfo()
	{
	  caseinfoService.updatecaseinfo(caseinfo);	
	  return "updatecaseinfo";	
	}
	
	//添加
	public String  addCaseinfo()
	{
		caseinfoService.addCaseinfo(caseinfo);
		return "addcaseinfo";
	}
	
	//查询
	public  String blurSearch(){
		   page=caseinfoService.getPersonListByArgs(offset,caseinfo.getNumber(),callStartTime,callEndTime,outStartTime,outEndTime);  
		   
		return "blur";
	}
	
	/**
	 * 批量删除
	 */
	public String batchDelCaseinfo(){
		for (Integer id : IDCheck) {
			caseinfoService.del(id);
		}
		 return "bdel";
	}

	/**
	 * 返回所有caseinfo的id,坐标,严重性和标题内容
	 * @return
	 */
	public String returnAllHeatMapSites(){
		List<Caseinfo> caseinfoes = caseinfoService.retrunAllCaseInfoes();
		if(null != caseinfoes){
			for(Caseinfo caseinfo : caseinfoes){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", caseinfo.getId());
				map.put("lng", Double.parseDouble(caseinfo.getSiteX()));
				map.put("lat",  Double.parseDouble(caseinfo.getSiteY()));
				map.put("count", caseinfo.getSerious());
				map.put("smallContent", caseinfo.getSmallContent());
				cases.add(map);
			}
		}
		return "returnAllHeatMapSites";
	}
	
	/**
	 * 返回分布数据
	 * @return
	 */
	public String returnSpreadData()
	{
		this.setSpreadData(caseinfoService.getAjaxSpreadData());
		System.out.println(spreadData);
		return "returnSpreadData";
	}
	
	private void setSpreadData(List<Map<String, Object>> ajaxSpreadData) {
		this.spreadData = ajaxSpreadData;
	}

	/**
	 * 返回各种类型案件的发生次数
	 * @return
	 */
	public String returnPerTypeCaseInfoCount(){
		caseinfoCount = caseinfoService.returnPerTypeCaseInfoCount();
		maxCaseinfoCount = Collections.max(caseinfoCount);
		averCaseinfoSerious = caseinfoService.returnAverCaseinfoSeriousList();
		//将平均事故严重性和事故发生最大次数转换为同一数量级
		for(int i = 0; i < averCaseinfoSerious.size(); i ++){
			Integer averSerious = averCaseinfoSerious.get(i);
			while(averSerious > maxCaseinfoCount && averSerious / maxCaseinfoCount > 0){
				averSerious /= maxCaseinfoCount;
			}
			averCaseinfoSerious.set(i, averSerious);
		}
		return "caseInfoCountPage";
	}

	public String getFileFileName() {
		return fileFileName;
	}
	public String getFileContentType() {
		return fileContentType;
	}
	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}
	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}

	@Resource
	private CaseinfoUploadFileService caseinfoUploadFileService;
	/**
	 * 事件附件上传
	 * @return
	 */
	public String fileUpload()
	{
		try {
			String ext = fileFileName.substring(fileFileName.lastIndexOf(".")+1);
			String dir = servletContext.getRealPath("upload");
			String url = System.currentTimeMillis()+"."+ext;
			//1.上传
			file.renameTo(new File(dir+"//"+System.currentTimeMillis()+"."+ext));
			//2.把数据存放到数据库
			UploadFile c = new UploadFile();
			//c.setCaseinfo(caseinfo);
			c.setFileName(fileFileName);
			c.setUploadTime(new Date());
			c.setUrl("upload/"+url);
			c.setExtName(ext);
			caseinfoUploadFileService.saveEntity(c);
			return "upload-success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "upload-error";
	}
	public String toUploadPage()
	{
		existingFiles = caseinfoUploadFileService.findExistingFilesNameByCaseinfoId(caseinfo.getId());
		return "toUploadPage";
	}
	public Map<String, Object> getJsonMap() {
		return jsonMap;
	}
	public void setJsonMap(Map<String, Object> jsonMap) {
		this.jsonMap = jsonMap;
	}

	public void setServletContext(ServletContext arg0) {
		this.servletContext = arg0;
	}
	
	/**
	 * 到修改事件坐标页面
	 * @return
	 */
	public String toChangeSitePage(){
		return "toChangeSitePage";
	}
	
	/**
	 * 修改事件位置
	 * @return
	 */
	public String changeSite(){
		System.out.println(caseinfo.getId());
		System.out.println(caseinfo.getSiteX());
		System.out.println(caseinfo.getSiteY());
		Caseinfo ca = caseinfoService.getCaseinfo(caseinfo.getId());
		ca.setSiteX(caseinfo.getSiteX());
		ca.setSiteY(caseinfo.getSiteY());
		caseinfoService.updatecaseinfo(ca);
		return "toMessMapPage";
	}
	//风险分析 案件列表
	private List<Caseinfo> caseinfoRisk[] = null;
	private Map<String, Object> session;
	
	/**
	 * 到达风险分析分析界面
	 * @return
	 */
	public String toRiskAnalysisPage()
	{
		//System.out.println(caseinfo.getSiteX());
		return "toRiskAnalysisPage";
	}
	/**
	 * 风险分析
	 * @return
	 */
	public String riskAnalysis()
	{
		caseinfoRisk = caseinfoService.riskAnalysis(caseinfo,0.005);
		session.put("caseinfoRisk", caseinfoRisk);
		return "analysis-success";
	}
	
	
	/**
	 * 风险分析监听
	 * @return
	 */
	public String riskAnalysisListener()
	{
		String percent = (String) session.get("percent");
		if(percent != null)
		{
			jsonMap.put("percent", percent);
		}
		else{
			jsonMap.put("percent", "1%");
		}
		//session.put("percent", -1);
		return "listen-success";
	}
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}
	
	private List<Double> riskSerious;

	public List<Double> getRiskSerious() {
		return riskSerious;
	}
	public void setRiskSerious(List<Double> riskSerious) {
		this.riskSerious = riskSerious;
	}
	private double totalRiskSerious;
	public double getTotalRiskSerious() {
		return totalRiskSerious;
	}
	public void setTotalRiskSerious(double totalRiskSerious) {
		this.totalRiskSerious = totalRiskSerious;
	}
	@SuppressWarnings("unchecked")
	public String toRiskMessPage()
	{
		//求各个板块的平均严重度
		riskSerious = caseinfoService.getAvgSeriousByRand();
		
		//求总板块的 平均严重度
		totalRiskSerious = caseinfoService.getTotalAvgSerious(riskSerious);
		return "toRiskMessPage";
	}
}
