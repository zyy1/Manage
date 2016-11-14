package cn.aynu.manage.service;

import java.util.List;
import java.util.Set;

import cn.aynu.manage.vo.safe.Right;

public interface RightService {

	public void saveOrUpdateRight(Right model);

	public void appendRightUrl(String url);

	public List<Right> findRightInRange(String[] noOwnRightIds);

	public List<Right> findRightNoInRange(Set<Right> rights);

	public Integer getMaxRightPos();

	public Right getEntityByUrl(String url);
	
	public List<Right> findAllEntites();

}
