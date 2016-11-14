package cn.aynu.manage.service.imp;

import javax.annotation.Resource;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.aynu.manage.dao.imp.CaseinfoUploadFileDaoImpl;
import cn.aynu.manage.service.CaseinfoUploadFileService;
import cn.aynu.manage.vo.UploadFile;
@Service("caseinfoUploadFileService")
public class CaseinfoUploadFileServiceImpl implements CaseinfoUploadFileService {
	@Resource
	private CaseinfoUploadFileDaoImpl caseinfoUploadFileDao;

	public void saveEntity(UploadFile c) {
		caseinfoUploadFileDao.saveEntity(c);
	}
	
	@Resource
	private CaseinfoUploadFileDaoImpl uploadDao; 
	
	/**
	 * 返回所有已上传文件的名字
	 */
	public List<UploadFile> findExistingFilesNameByCaseinfoId(Integer caseinfoId) {
		String hql = "from CaseinfoUploadFile where caseinfo.id = ?";
		return uploadDao.findEntityByHQL(hql, caseinfoId);
	}
	
	/**
	 * 根据文件名得到目标文件
	 */
	public UploadFile  getDestFileByFileId(Integer id) {
		String hql = "from CaseinfoUploadFile where id = ?";
		return (UploadFile) uploadDao.uniqueResult(hql, id);
	}

	/**
	 * 根据文件名字删除数据库中的文件记录
	 * @param destFileName
	 */
	public void deleteFileInfoByFileId(Integer id) {
		uploadDao.deleteEntity(getDestFileByFileId(id));
	}
}
