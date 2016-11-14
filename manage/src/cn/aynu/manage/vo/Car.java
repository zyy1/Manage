package cn.aynu.manage.vo;

/**
 * Car entity. @author MyEclipse Persistence Tools
 */

public class Car implements java.io.Serializable {

	@Override
	public String toString() {
		return "Car [id=" + id + ", number=" + number + ", carExplain=" + carExplain + ", carnum=" + carnum + ", day="
				+ day + ", name=" + name + ", numa=" + numa + ", sex=" + sex + ", numb=" + numb + ", card=" + card
				+ ", address=" + address + ", remark=" + remark + "]";
	}

	// Fields
	private Integer id;
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	private String number;
	private String carExplain;
	private String carnum;
	private String day;
	private String name;
	private String numa;
	private String sex;
	private String numb;
	private String card;
	private String address;
	private String remark;

	// Constructors

	/** default constructor */
	public Car() {
	}

	/** full constructor */
	public Car(String carExplain, String carnum, String day, String name, String numa, String sex, String numb,
			String card, String address, String remark) {
		this.carExplain = carExplain;
		this.carnum = carnum;
		this.day = day;
		this.name = name;
		this.numa = numa;
		this.sex = sex;
		this.numb = numb;
		this.card = card;
		this.address = address;
		this.remark = remark;
	}

	// Property accessors

	public String getNumber() {
		return this.number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getCarExplain() {
		return this.carExplain;
	}

	public void setCarExplain(String carExplain) {
		this.carExplain = carExplain;
	}

	public String getCarnum() {
		return this.carnum;
	}

	public void setCarnum(String carnum) {
		this.carnum = carnum;
	}

	public String getDay() {
		return this.day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNuma() {
		return this.numa;
	}

	public void setNuma(String numa) {
		this.numa = numa;
	}

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getNumb() {
		return this.numb;
	}

	public void setNumb(String numb) {
		this.numb = numb;
	}

	public String getCard() {
		return this.card;
	}

	public void setCard(String card) {
		this.card = card;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}