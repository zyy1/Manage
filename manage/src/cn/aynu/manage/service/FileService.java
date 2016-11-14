package cn.aynu.manage.service;

import java.util.List;
import java.util.Map;

import cn.aynu.manage.vo.UploadFile;

public interface FileService extends BaseService<UploadFile>{
	/**
	 * 获取现存已上传的文件
	 * @param ownerId,attachmentType
	 * @return List<UploadFile>
	 */
	List<UploadFile> findExistingFilesByOwnerId(Integer ownerId, String attachmentType);
	
	/**
	 * 上传文件
	 * @param c
	 */
	void upload(UploadFile c);
	
	/**
	 * 根据Id获取文件
	 * @param id
	 * @return
	 */
	UploadFile getDestFileByFileId(Integer id);
	
	/**
	 * 删除文件
	 * @param id
	 */
	void deleteFileInfoByFileId(Integer id);

	/**
	 * 得到要导出的 数据   :  反射的方法    ===》无序 舍弃了
	 * @return
	 */
	List<List<String>> getDataListForExcelQuit(String kind,Class clazz,List<String> headers);

	/**
	 * 得出要导出的数据
	 * @param kind
	 * @return
	 */
	Map<String,Object> getDataListForExcel(String kind, Object...objects);
		
}
