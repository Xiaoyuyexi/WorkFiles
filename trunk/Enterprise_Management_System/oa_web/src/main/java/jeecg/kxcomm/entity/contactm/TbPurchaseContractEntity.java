package jeecg.kxcomm.entity.contactm;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.SequenceGenerator;

/**   
 * @Title: Entity
 * @Description: 采购合同
 * @author zhangdaihao
 * @date 2013-09-29 09:48:29
 * @version V1.0   
 *
 */
@Entity
@Table(name = "tb_purchase_contract", schema = "")
@SuppressWarnings("serial")
public class TbPurchaseContractEntity implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**contractNo*/
	private java.lang.String contractNo;
	/**contractPrice*/
	private java.lang.String contractPrice;
	/**remark*/
	private java.lang.String remark;
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  id
	 */
	
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="ID",nullable=false,length=85)
	public java.lang.String getId(){
		return this.id;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  id
	 */
	public void setId(java.lang.String id){
		this.id = id;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  contractNo
	 */
	@Column(name ="CONTRACT_NO",nullable=true,length=85)
	public java.lang.String getContractNo(){
		return this.contractNo;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  contractNo
	 */
	public void setContractNo(java.lang.String contractNo){
		this.contractNo = contractNo;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  contractPrice
	 */
	@Column(name ="CONTRACT_PRICE",nullable=true,length=85)
	public java.lang.String getContractPrice(){
		return this.contractPrice;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  contractPrice
	 */
	public void setContractPrice(java.lang.String contractPrice){
		this.contractPrice = contractPrice;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  remark
	 */
	@Column(name ="REMARK",nullable=true,length=85)
	public java.lang.String getRemark(){
		return this.remark;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  remark
	 */
	public void setRemark(java.lang.String remark){
		this.remark = remark;
	}
}
