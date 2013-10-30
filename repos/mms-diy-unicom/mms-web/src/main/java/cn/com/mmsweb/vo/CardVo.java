package cn.com.mmsweb.vo;

import java.io.Serializable;

public class CardVo implements Serializable {

	private String id; // 主键id
	private String cardTitle;
	private String wishWord; // 祝福语
	private String collectNum; // 收藏数
	private String picUrl; // 存放地址url
	private String status; // 状态:0显示，1不显示
	private String cardTypeName; // 模板类型名称
	private String cardTypeId; // 模板类型id
	
	private String addressId; //收件人
	private String datetime; //发送时间
	private String bgMusic; //背景音乐
	private String checkBoxChetime;//时间复选框
	private String checkBoxMusic; //背景音乐复选框
	private String xPosText; //输入文字的x坐标
	private String yPosText; //输入文字的y坐标
	private String widthText; //输入文字的宽度
	private String heightText; //输入文字的高度
	
	private int msgType; //彩信类型 1、模板明信片发送，2、diy明信片发送
	
	public int getMsgType() {
		return msgType;
	}

	public void setMsgType(int msgType) {
		this.msgType = msgType;
	}

	public String getxPosText() {
		return xPosText;
	}

	public void setxPosText(String xPosText) {
		this.xPosText = xPosText;
	}

	public String getyPosText() {
		return yPosText;
	}

	public void setyPosText(String yPosText) {
		this.yPosText = yPosText;
	}

	public String getWidthText() {
		return widthText;
	}

	public void setWidthText(String widthText) {
		this.widthText = widthText;
	}

	public String getHeightText() {
		return heightText;
	}

	public void setHeightText(String heightText) {
		this.heightText = heightText;
	}

	public String getCheckBoxChetime() {
		return checkBoxChetime;
	}

	public void setCheckBoxChetime(String checkBoxChetime) {
		this.checkBoxChetime = checkBoxChetime;
	}

	public String getCheckBoxMusic() {
		return checkBoxMusic;
	}

	public void setCheckBoxMusic(String checkBoxMusic) {
		this.checkBoxMusic = checkBoxMusic;
	}

	public String getAddressId() {
		return addressId;
	}

	public void setAddressId(String addressId) {
		this.addressId = addressId;
	}

	public String getDatetime() {
		return datetime;
	}

	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}

	public String getBgMusic() {
		return bgMusic;
	}

	public void setBgMusic(String bgMusic) {
		this.bgMusic = bgMusic;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCardTitle() {
		return cardTitle;
	}

	public void setCardTitle(String cardTitle) {
		this.cardTitle = cardTitle;
	}

	public String getWishWord() {
		return wishWord;
	}

	public void setWishWord(String wishWord) {
		this.wishWord = wishWord;
	}

	public String getCollectNum() {
		return collectNum;
	}

	public void setCollectNum(String collectNum) {
		this.collectNum = collectNum;
	}

	public String getPicUrl() {
		return picUrl;
	}

	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCardTypeName() {
		return cardTypeName;
	}

	public void setCardTypeName(String cardTypeName) {
		this.cardTypeName = cardTypeName;
	}

	public String getCardTypeId() {
		return cardTypeId;
	}

	public void setCardTypeId(String cardTypeId) {
		this.cardTypeId = cardTypeId;
	}

	@Override
	public String toString() {
		return "CardVo [id=" + id + ", cardTitle=" + cardTitle + ", wishWord="
				+ wishWord + ", collectNum=" + collectNum + ", picUrl="
				+ picUrl + ", status=" + status + ", cardTypeName="
				+ cardTypeName + ", cardTypeId=" + cardTypeId + ", addressId="
				+ addressId + ", datetime=" + datetime + ", bgMusic=" + bgMusic
				+ "]";
	}

}