package cn.aynu.manage.vo;

import java.util.Date;
import java.util.Set;

/**
 * Caseinfo entity. @author MyEclipse Persistence Tools
 */

public class Caseinfo implements java.io.Serializable {

	private static final long serialVersionUID = -5962188906040862951L;
	// Fields
    private Integer id;
	public Integer getId() {
		return id;
	}
	private String smallContent;
	public String getSmallContent() {
		return smallContent;
	}
	private Date dealSuccessTime;

	public Date getDealSuccessTime() {
		return dealSuccessTime;
	}

	public void setDealSuccessTime(Date dealSuccessTime) {
		this.dealSuccessTime = dealSuccessTime;
	}

	public void setSmallContent(String smallContent) {
		this.smallContent = smallContent;
	}
	private Integer serious;

	public Integer getSerious() {
		return serious;
	}

	public void setSerious(Integer serious) {
		this.serious = serious;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	private String number;
	private String callper;
	private String calltype;
	private Date calltime;
	private String content;
	private String address;
	private String phone;
	private String receive;
	private Date outtime;
	private String outper;
	private String outcar;
	private String dealwith;
	private String sugge;
	private String dealper;
	private String siteX;
	private String siteY;
    private String caseType;




	@Override
	public String toString() {
		return "Caseinfo [id=" + id + ", smallContent=" + smallContent + ", dealSuccessTime=" + dealSuccessTime
				+ ", serious=" + serious + ", number=" + number + ", callper=" + callper + ", calltype=" + calltype
				+ ", calltime=" + calltime + ", content=" + content + ", address=" + address + ", phone=" + phone
				+ ", receive=" + receive + ", outtime=" + outtime + ", outper=" + outper + ", outcar=" + outcar
				+ ", dealwith=" + dealwith + ", sugge=" + sugge + ", dealper=" + dealper + ", siteX=" + siteX
				+ ", siteY=" + siteY + ", caseType=" + caseType + "]";
	}

	public String getSiteX() {
		return siteX;
	}

	public void setSiteX(String siteX) {
		this.siteX = siteX;
	}

	public String getSiteY() {
		return siteY;
	}

	public void setSiteY(String siteY) {
		this.siteY = siteY;
	}

	public String getCaseType() {
		return caseType;
	}

	public void setCaseType(String caseType) {
		this.caseType = caseType;
	}

	/** default constructor */
	public Caseinfo() {
	}

	/** full constructor */
	public Caseinfo(String callper, String calltype, String calltime, String content, String address, String phone,
			String receive, String outtime, String outper, String outcar, String dealwith, String sugge,
			String dealper) {
		this.callper = callper;
		this.calltype = calltype;
		this.content = content;
		this.address = address;
		this.phone = phone;
		this.receive = receive;
		this.outper = outper;
		this.outcar = outcar;
		this.dealwith = dealwith;
		this.sugge = sugge;
		this.dealper = dealper;
	}

	// Property accessors

	public String getNumber() {
		return this.number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getCallper() {
		return this.callper;
	}

	public void setCallper(String callper) {
		this.callper = callper;
	}

	public String getCalltype() {
		return this.calltype;
	}

	public void setCalltype(String calltype) {
		this.calltype = calltype;
	}



	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getReceive() {
		return this.receive;
	}

	public void setReceive(String receive) {
		this.receive = receive;
	}


	public Date getCalltime() {
		return calltime;
	}

	public void setCalltime(Date calltime) {
		this.calltime = calltime;
	}

	public Date getOuttime() {
		return outtime;
	}

	public void setOuttime(Date outtime) {
		this.outtime = outtime;
	}

	public String getOutper() {
		return this.outper;
	}

	public void setOutper(String outper) {
		this.outper = outper;
	}

	public String getOutcar() {
		return this.outcar;
	}

	public void setOutcar(String outcar) {
		this.outcar = outcar;
	}

	public String getDealwith() {
		return this.dealwith;
	}

	public void setDealwith(String dealwith) {
		this.dealwith = dealwith;
	}

	public String getSugge() {
		return this.sugge;
	}

	public void setSugge(String sugge) {
		this.sugge = sugge;
	}

	public String getDealper() {
		return this.dealper;
	}

	public void setDealper(String dealper) {
		this.dealper = dealper;
	}

}