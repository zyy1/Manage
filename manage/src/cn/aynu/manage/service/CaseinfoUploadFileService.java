package cn.aynu.manage.service;

import cn.aynu.manage.vo.UploadFile;

import java.util.List;

import cn.aynu.manage.vo.UploadFile;

public interface CaseinfoUploadFileService {
	/**
	 * 返回所有已上传de文件
	 * @return
	 */
	public List<UploadFile> findExistingFilesNameByCaseinfoId(Integer caseinfoId);
	
	/**
	 * 根据文件id得到目标文件
	 * @param destFileName
	 * @return
	 */
	public UploadFile getDestFileByFileId(Integer id);

	void saveEntity(UploadFile c);

	/**
	 * 根据文件id删除数据库中的文件记录
	 * @param destFileName
	 */
	public void deleteFileInfoByFileId(Integer id);
	
}
