package cn.aynu.manage.vo;

/**
 * Callpolice entity. @author MyEclipse Persistence Tools
 */

public class Callpolice implements java.io.Serializable {

	// Fields

	private Integer id;
	
	@Override
	public String toString() {
		return "Callpolice [id=" + id + ", number=" + number + ", callper=" + callper + ", calltype=" + calltype
				+ ", calltime=" + calltime + ", content=" + content + ", address=" + address + ", phone=" + phone
				+ ", receive=" + receive + ", outtime=" + outtime + ", outper=" + outper + ", outcar=" + outcar
				+ ", dealwith=" + dealwith + ", sugge=" + sugge + ", dealper=" + dealper + "]";
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	private String number;
	private String callper;
	private String calltype;
	private String calltime;
	private String content;
	private String address;
	private String phone;
	private String receive;
	private String outtime;
	private String outper;
	private String outcar;
	private String dealwith;
	private String sugge;
	private String dealper;

	// Constructors

	/** default constructor */
	public Callpolice() {
	}

	/** full constructor */
	public Callpolice(String callper, String calltype, String calltime, String content, String address, String phone,
			String receive, String outtime, String outper, String outcar, String dealwith, String sugge,
			String dealper) {
		this.callper = callper;
		this.calltype = calltype;
		this.calltime = calltime;
		this.content = content;
		this.address = address;
		this.phone = phone;
		this.receive = receive;
		this.outtime = outtime;
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

	public String getCalltime() {
		return this.calltime;
	}

	public void setCalltime(String calltime) {
		this.calltime = calltime;
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

	public String getOuttime() {
		return this.outtime;
	}

	public void setOuttime(String outtime) {
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