package cn.aynu.manage.dao;

import java.util.List;

public class Pagebean {
	private List list;
	private int allrow;// 总条数
	private int allpage;// 总页数
	private int currentpage;// 当前页
	private int pagesize;// 每页几条

	private boolean isfirstpage;// 是否为第一页
	private boolean islastpage;// 是否为最后一页
	private boolean hasqianpage;// 是否有前一页
	private boolean hasnextpage;// 是否有下一页

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public int getAllrow() {
		return allrow;
	}

	public void setAllrow(int allrow) {
		this.allrow = allrow;
	}

	public int getAllpage() {
		return allpage;
	}

	public void setAllpage(int allpage) {
		this.allpage = allpage;
	}

	public int getCurrentpage() {
		return currentpage;
	}

	public void setCurrentpage(int currentpage) {
		this.currentpage = currentpage;
	}

	public int getPagesize() {
		return pagesize;
	}

	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}

	public boolean isIsfirstpage() {
		return (currentpage == 1);
	}

	public boolean isIslastpage() {

		return (currentpage == allpage);
	}

	public boolean isHasqianpage() {
		return (currentpage != 1);
	}

	public boolean isHasnextpage() {
		return (currentpage != allpage);
	}

	public void init() {

		this.isfirstpage = isIsfirstpage();
		this.islastpage = isIslastpage();
		this.hasqianpage = isHasqianpage();
		this.hasnextpage = isHasnextpage();
	}

	// 得到总页数
	public int allPage(final int pagesize, final int allrow) {// 设问号之前的为条件，如果该条件为真，则返回分号之前的值，否则返回分号之后的值
		int allpage = allrow % pagesize == 0 ? allrow / pagesize : allrow / pagesize + 1;
		return allpage;
	}

	// 得到当前页第一条在数据库中的位置
	public int jilushu(final int pagesize, final int currentpage) {
		int jilushu = (currentpage - 1) * pagesize;
		return jilushu;
	}

	// 得到当前页
	public int currentpage(int page) {
		// 初始值为1
		final int currentpage = (page == 0 ? 1 : page);
		return currentpage;
	}

}
