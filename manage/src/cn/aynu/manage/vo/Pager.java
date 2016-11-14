package cn.aynu.manage.vo;

import java.util.List;

/**
 * 分页对象
 * 
 * @author Administrator
 *
 * @param <T>
 */
public class Pager<T> {
	/**
	 * 分页的大�?
	 */
	private int size;
	/**
	 * 分页的起始页
	 */
	private int offset;
	/**
	 * 总记录数
	 */
	private long total;
	/**
	 * 分页的数�?
	 */
	private List<T> datas;

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public long getTotal() {
		return total;
	}

	@Override
	public String toString() {
		return "Pager [size=" + size + ", offset=" + offset + ", total=" + total + ", datas=" + datas + "]";
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public List<T> getDatas() {
		return datas;
	}

	public void setDatas(List<T> datas) {
		this.datas = datas;
	}
	/**
	 * �õ���ҳ��
	 * @return
	 */
	public long getTotalPage()
	{
		return (total-1)/size+1;
	}
}
