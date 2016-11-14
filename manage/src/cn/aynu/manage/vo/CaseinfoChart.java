package cn.aynu.manage.vo;

public class CaseinfoChart {
	@Override
	public String toString() {
		return "CaseinfoChart [caseType=" + caseType + ", count=" + count + "]";
	}
	private String caseType;
	private Integer count;
	public String getCaseType() {
		return caseType;
	}
	public void setCaseType(String caseType) {
		this.caseType = caseType;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public CaseinfoChart(String caseType, Integer count) {
		super();
		this.caseType = caseType;
		this.count = count;
	}
	public CaseinfoChart() {
		super();
	}
	
}
