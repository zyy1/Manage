package cn.aynu.manage.vo;

/**
 * Person entity.
 */

public class Person implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// Fields
	private Integer id;

	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	private String number;
	private String name;
	private String sex;
	private String idCard;
	private String type;
	private String unit;
	private String floor;
	private String room;
	private String address;
	private String workCompany;
	private String professional;
	private String tel;
	private String liveReason;
	private String household;
	private String householdType;
	private String national;
	private String culturalLevel;
	private String maritalStatus;
	private String birthday;
	private String upload;

	// Constructors

	/** default constructor */
	public Person() {
	}

	/** minimal constructor */

	// Property accessors

	public String getNumber() {
		return this.number;
	}

	public Person(Integer id, String number, String name, String sex, String idCard, String type, String unit,
			String floor, String room, String address, String workCompany, String professional, String tel,
			String liveReason, String household, String householdType, String national, String culturalLevel,
			String maritalStatus, String birthday, String upload) {
		super();
		this.id = id;
		this.number = number;
		this.name = name;
		this.sex = sex;
		this.idCard = idCard;
		this.type = type;
		this.unit = unit;
		this.floor = floor;
		this.room = room;
		this.address = address;
		this.workCompany = workCompany;
		this.professional = professional;
		this.tel = tel;
		this.liveReason = liveReason;
		this.household = household;
		this.householdType = householdType;
		this.national = national;
		this.culturalLevel = culturalLevel;
		this.maritalStatus = maritalStatus;
		this.birthday = birthday;
		this.upload = upload;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getName() {
		return this.name;
	}

	public void setName(
			String name) {/*
							 * try { this.name= new
							 * String(name.getBytes("iso-8859-1"),"utf-8"); }
							 * catch (UnsupportedEncodingException e) { // TODO
							 * Auto-generated catch block e.printStackTrace(); }
							 */
		this.name = name;

	}

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getIdCard() {
		return this.idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUnit() {
		return this.unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getFloor() {
		return this.floor;
	}

	public void setFloor(String floor) {
		this.floor = floor;
	}

	public String getRoom() {
		return this.room;
	}

	public void setRoom(String room) {
		this.room = room;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getWorkCompany() {
		return this.workCompany;
	}

	public void setWorkCompany(String workCompany) {
		this.workCompany = workCompany;
	}

	public String getProfessional() {
		return this.professional;
	}

	public void setProfessional(String professional) {
		this.professional = professional;
	}

	public String getTel() {
		return this.tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getLiveReason() {
		return this.liveReason;
	}

	public void setLiveReason(String liveReason) {
		this.liveReason = liveReason;
	}

	public String getHousehold() {
		return this.household;
	}

	public void setHousehold(String household) {
		this.household = household;
	}

	public String getHouseholdType() {
		return this.householdType;
	}

	public void setHouseholdType(String householdType) {
		this.householdType = householdType;
	}

	public String getNational() {
		return this.national;
	}

	public void setNational(String national) {
		this.national = national;
	}

	public String getCulturalLevel() {
		return this.culturalLevel;
	}

	public void setCulturalLevel(String culturalLevel) {
		this.culturalLevel = culturalLevel;
	}

	public String getMaritalStatus() {
		return this.maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public String getBirthday() {
		return this.birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getUpload() {
		return this.upload;
	}

	public void setUpload(String upload) {
		this.upload = upload;
	}

	@Override
	public String toString() {
		return "Person [id=" + id + ", number=" + number + ", name=" + name + ", sex=" + sex + ", idCard=" + idCard
				+ ", type=" + type + ", unit=" + unit + ", floor=" + floor + ", room=" + room + ", address=" + address
				+ ", workCompany=" + workCompany + ", professional=" + professional + ", tel=" + tel + ", liveReason="
				+ liveReason + ", household=" + household + ", householdType=" + householdType + ", national="
				+ national + ", culturalLevel=" + culturalLevel + ", maritalStatus=" + maritalStatus + ", birthday="
				+ birthday + ", upload=" + upload + "]";
	}

}