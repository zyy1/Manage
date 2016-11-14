package cn.aynu.manage.vo;

import java.util.Date;

public class UploadFile {
	private Integer id;
	private String url;
	private String fileName;
	
	private String extName;
	private String attachmentType;
	@Override
	public String toString() {
		return "UploadFile [id=" + id + ", url=" + url + ", fileName=" + fileName + ", extName=" + extName
				+ ", attachmentType=" + attachmentType + ", ownerId=" + ownerId + ", uploadTime=" + uploadTime + "]";
	}

	private Integer ownerId;
	public Integer getOwnerId() {
		return ownerId;
	}

	public void setOwnerId(Integer ownerId) {
		this.ownerId = ownerId;
	}

	private Date uploadTime;
	public String getExtName() {
		return extName;
	}

	public void setExtName(String extName) {
		this.extName = extName;
	}

	public Integer getId() {
		return id;
	}

	public Date getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getAttachmentType() {
		return attachmentType;
	}

	public void setAttachmentType(String attachmentType) {
		this.attachmentType = attachmentType;
	}
	
}
