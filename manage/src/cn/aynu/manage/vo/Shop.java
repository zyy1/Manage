package cn.aynu.manage.vo;

/**
 * Shop entity. @author MyEclipse Persistence Tools
 */

public class Shop implements java.io.Serializable {

	// Fields

	private Integer id;
	private String number;
	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	private String unit;
	private String floor;
	private String room;
	private String shopName;
	private String shopType;
	private String bossName;
	private String bossIdCard;

	// Constructors

	/** default constructor */
	public Shop() {
	}

	/** full constructor */
	public Shop(String unit, String floor, String room, String shopName, String shopType, String bossName,
			String bossIdCard) {
		this.unit = unit;
		this.floor = floor;
		this.room = room;
		this.shopName = shopName;
		this.shopType = shopType;
		this.bossName = bossName;
		this.bossIdCard = bossIdCard;
	}

	// Property accessors

	@Override
	public String toString() {
		return "Shop [id=" + id + ", number=" + number + ", unit=" + unit + ", floor=" + floor + ", room=" + room
				+ ", shopName=" + shopName + ", shopType=" + shopType + ", bossName=" + bossName + ", bossIdCard="
				+ bossIdCard + "]";
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public String getShopName() {
		return this.shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getShopType() {
		return this.shopType;
	}

	public void setShopType(String shopType) {
		this.shopType = shopType;
	}

	public String getBossName() {
		return this.bossName;
	}

	public void setBossName(String bossName) {
		this.bossName = bossName;
	}

	public String getBossIdCard() {
		return this.bossIdCard;
	}

	public void setBossIdCard(String bossIdCard) {
		this.bossIdCard = bossIdCard;
	}

}