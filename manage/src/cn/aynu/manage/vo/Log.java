package cn.aynu.manage.vo;

import java.util.Date;

public class Log {

	@Override
	public String toString() {
		return "Log [id=" + id + ", operator=" + operator + ", operName=" + operName + ", operParams=" + operParams
				+ ", operResult=" + operResult + ", resultMsg=" + resultMsg + ", operTime=" + operTime + "]";
	}
	private String id;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	private String operator;//操作人
	private String operName;//操作方法，方法名
	private String operParams;//操作参数
	private String operResult;//操作结果，成功，失败
	private String resultMsg;//结果消息
	private Date operTime = new Date();//操作时间

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getOperName() {
		return operName;
	}

	public void setOperName(String operName) {
		this.operName = operName;
	}

	public String getOperParams() {
		return operParams;
	}

	public void setOperParams(String operParams) {
		this.operParams = operParams;
	}

	public String getOperResult() {
		return operResult;
	}

	public void setOperResult(String operResult) {
		this.operResult = operResult;
	}

	public String getResultMsg() {
		return resultMsg;
	}

	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}

	public Date getOperTime() {
		return operTime;
	}

	public void setOperTime(Date operTime) {
		this.operTime = operTime;
	}
	

}
