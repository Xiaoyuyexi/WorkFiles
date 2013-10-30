package com.unicom.mms.gateway;

/**
 * 
 * 实时短信<br/>
 * 优先级偏高
 * @author zhangjh 新增日期：2013-9-25
 * @since mms-share
 */
public class RealTimeSMS extends BaseMessage{
	private static final long serialVersionUID = -6563871871916579130L;
	/**
	 * 产品代码
	 */
	private String productCode;
	public String getProductCode() {
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	@Override
	public String toString() {
		return "RealTimeSMS [productCode=" + productCode + ", getSender()="
				+ getSender() + ", getMsgSequence()=" + getMsgSn()
				+ ", getReceiver()=" + getReceiver() + ", getChannel()="
				+ getChannel() + ", getMsgType()=" + getMsgType()
				+ ", getContent()=" + getContent() + "]";
	}
	
}