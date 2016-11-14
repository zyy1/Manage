package cn.aynu.manage.struts2.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.ServletContextAware;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import cn.aynu.manage.service.CaseinfoService;
import cn.aynu.manage.service.FileService;
import cn.aynu.manage.util.LogUtil;
import cn.aynu.manage.util.PoiUtil;
import cn.aynu.manage.vo.Car;
import cn.aynu.manage.vo.Caseinfo;
import cn.aynu.manage.vo.Person;
import cn.aynu.manage.vo.Shop;
import cn.aynu.manage.vo.UploadFile;

@Controller("fileAction")
@Scope("prototype")
public class FileAction extends ActionSupport implements ModelDriven<UploadFile>, ServletContextAware{
	
	
	private static final long serialVersionUID = -7919738743294713345L;
	@Resource
	private FileService fileService;
	private UploadFile uploadFile;
	//文件集合
	private List<UploadFile> existingFiles;
	//上传文件对应的属性
	private File file;
	//上传文件名
	private String fileFileName;
	//上传文件的类型
	private String fileContentType;
	private ServletContext servletContext;
	//下载文件名
	private String downloadFileName;
	//要下载的文件的真实路径
	private String downloadFileRealPath;
	private Map<String, Object> jsonMap = new HashMap<String, Object>();
	/**
	 * 到上传文件页面
	 * @return
	 */
	public String toUploadPage(){
		//获取已上传的文件集合
		existingFiles = fileService.findExistingFilesByOwnerId(uploadFile.getOwnerId(), uploadFile.getAttachmentType());
		return "toUploadPage";
	}
	
	public Map<String, Object> getJsonMap() {
		return jsonMap;
	}

	public void setJsonMap(Map<String, Object> jsonMap) {
		this.jsonMap = jsonMap;
	}

	/**
	 * 上传文件
	 * @return
	 */
	public String uploadFile(){
		try {
			String ext = fileFileName.substring(fileFileName.lastIndexOf(".")+1);
			String dir = servletContext.getRealPath("upload/"+uploadFile.getAttachmentType()+"/");
			String url = System.currentTimeMillis()+"."+ext;
			//1.上传
			file.renameTo(new File(dir+"//"+System.currentTimeMillis()+"."+ext));
			//2.把数据存放到数据库
			UploadFile c = new UploadFile();
			c.setFileName(fileFileName);
			c.setUploadTime(new Date());
			c.setUrl("upload/"+uploadFile.getAttachmentType()+"/"+url);
			c.setExtName(ext);
			c.setOwnerId(uploadFile.getOwnerId());
			c.setAttachmentType(uploadFile.getAttachmentType());
			fileService.upload(c);
			return "upload-success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "upload-error";
	}
	
	
	//下载附件
	public String download() throws UnsupportedEncodingException{
		uploadFile = fileService.getDestFileByFileId(uploadFile.getId());
		downloadFileRealPath = servletContext.getRealPath(uploadFile.getUrl());
		this.setDownloadFileName(new String(uploadFile.getFileName().getBytes(),"iso-8859-1"));
		return "download";
	}
	
	//附件下载需要的流
	public InputStream getInputStream() throws Exception{
		File f = new File(downloadFileRealPath);
		InputStream stream = new FileInputStream(f);
		return stream;
	}
	
	/**
	 * 删除附件
	 */
	public String deleteExistingFileByFileId(){
		uploadFile = fileService.getDestFileByFileId(uploadFile.getId());
		String realUrl = servletContext.getRealPath(uploadFile.getUrl());
		File destFile = new File(realUrl);
		System.out.println(realUrl);
		System.out.println("文件是否存在？： "+destFile.exists());
		if(destFile.exists()){
			try {
				fileService.deleteFileInfoByFileId(uploadFile.getId());
				destFile.delete();
			} catch (Exception e) {
				e.printStackTrace();
			}
			jsonMap.put("flag", 1);
		}
		return "deleteExistingFile";
	}
	
	/**
	 * setter/getter
	 */
	public List<UploadFile> getExistingFiles() {
		return existingFiles;
	}
	public void setExistingFiles(List<UploadFile> existingFiles) {
		this.existingFiles = existingFiles;
	}
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}
	public String getFileFileName() {
		return fileFileName;
	}
	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}
	public String getFileContentType() {
		return fileContentType;
	}
	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}
	public UploadFile getModel() {
		if(null == uploadFile){
			uploadFile = new UploadFile();
		}
		return uploadFile;
	}
	public void setServletContext(ServletContext arg0) {
		this.servletContext = arg0;
	}
	public String getDownloadFileName() {
		return downloadFileName;
	}
	public void setDownloadFileName(String downloadFileName) {
		this.downloadFileName = downloadFileName;
	}
	
	/**
	 * 到达 上传excel 导入数据的界面
	 * @return
	 */
	public String toDataUploadPage()
	{
		return "toDataUploadPage";
	}
	
	@Resource
	private CaseinfoService caseinfoService;
	private String operStartTime;
	private String operEndTime;

	private String operator;
	private String operResult;
	
	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getOperResult() {
		return operResult;
	}

	public void setOperResult(String operResult) {
		this.operResult = operResult;
	}

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

	/**
	 * 导入数据
	 * @return
	 */
	public String importData()
	{
		System.out.println("inport。。。");
		File file2 = null;
		try {
			PoiUtil pu = new PoiUtil();
			//把目标文件上传到服务器
			String url = servletContext.getRealPath("upload") +"//"+ fileFileName;
			 file2 = new File(url);
			file.renameTo(file2);
		
			//开始导入数据
			List<String> list = pu.readExceltoSql(file2.getPath(), uploadFile.getAttachmentType());
			for(String sql : list)
			{
				System.out.println(sql);
				caseinfoService.executeSQL(sql);
			}
			if(file2.exists())
			{
				file2.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
			if(file2.exists())
			{
				file2.delete();
			}
			return "import-error";
		}
		return "import-success";
	}
	
	public String exportData() throws Exception
	{
		String fileNameAndPath = servletContext.getRealPath("/export/")+"\\"+System.nanoTime()+".xls";
		PoiUtil pu = new PoiUtil();
		Map<String,Object> map = null;
		if(uploadFile.getAttachmentType().equals("log")){
			map = fileService.getDataListForExcel(uploadFile.getAttachmentType(),operator,operResult,operStartTime, operEndTime);
		}
		else{
			map = fileService.getDataListForExcel(uploadFile.getAttachmentType());
		}
		//导出
		pu.writeExcel((String[])map.get("headCell"), fileNameAndPath, (List<List<String>>)map.get("excelData"));
		downloadFileRealPath = fileNameAndPath;
		
		this.setDownloadFileName(map.get("exportFileName")+"");
		File file = new File(fileNameAndPath);
		return "export-success";
	}

}
