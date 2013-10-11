package cn.com.kxcomm.entity;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * 
 * 功能描述:订单详情 版权所有：康讯通讯 未经本公司许可，不得以任何方式复制或使用本程序任何部分
 * 
 * @author chenliang 新增日期：2013-9-11
 * @author chenliang 修改日期：2013-9-11
 * @since system_center_share
 */
@Entity
@SequenceGenerator(name = "SEQ_ORDER_DETAIL_ID", sequenceName = "SEQ_ORDER_DETAIL_ID", allocationSize = 1)
@Table(name = "tb_order_detail")
public class OrderDetailEntity implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_ORDER_DETAIL_ID")
	@Column(name = "id", updatable = false, nullable = false, insertable = false, length = 32)
	private Long id;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "orders_id", nullable = false)
	private OrdersEntity ordersId; // 订单id

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "operating_system_id", nullable = false)
	private OperatingSystemEntity operatingSystemId; // 系统id

	@Column(name = "cpu_size", updatable = true, nullable = false, insertable = true, length = 32)
	private Long cpuSize; // cpu大小

	@Column(name = "memory_size", updatable = true, nullable = false, insertable = true, length = 32)
	private Long memorySize; // 内存大小

	@Column(name = "system_sisk_size", updatable = true, nullable = false, insertable = true, length = 32)
	private Long systemDiskSize; // 系统盘大小

	@Column(name = "cpu_unit", updatable = true, nullable = false, insertable = true, length = 150)
	private String cpuUnit; // cpu大小单位

	@Column(name = "memory_unit", updatable = true, nullable = false, insertable = true, length = 150)
	private String memoryUnit; // 内存大小单位

	@Column(name = "public_network", updatable = true, nullable = false, insertable = true, length = 32)
	private Long publicNetwork; // 公网大小

	@Column(name = "numbers", updatable = true, nullable = false, insertable = true, length = 32)
	private Long numbers; // 数量

	@Column(name = "fee", updatable = true, nullable = false, insertable = true, length = 32)
	private Double fee; // 费用

	@Column(name = "buy_time", updatable = true, nullable = false, insertable = true, length = 32)
	private Long buyTime; // 购买时长

	@Column(name = "begin_use_time", updatable = true, nullable = false, insertable = true)
	private Date beginUseTime; // 开始使用时间

	@Column(name = "end_use_time", updatable = true, nullable = false, insertable = true)
	private Date endUseTime; // 结束使用时间

	@Column(name = "data_disk_size", updatable = true, nullable = false, insertable = true, length = 32)
	private Long dataDiskSize; // 数据盘大小

	@Column(name = "data_unit", updatable = true, nullable = false, insertable = true, length = 150)
	private String dataUnit; // 数据盘大小单位

	@Column(name = "buy_time_type", updatable = true, nullable = false, insertable = true, length = 32)
	private Long buyTimeType; // 购买时间类型1、月，2、年

	@Column(name = "system_disk_unit", updatable = true, nullable = false, insertable = true, length = 150)
	private String systemDiskUnit; // 系统盘大小单位

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public OrdersEntity getOrdersId() {
		return ordersId;
	}

	public void setOrdersId(OrdersEntity ordersId) {
		this.ordersId = ordersId;
	}

	public OperatingSystemEntity getOperatingSystemId() {
		return operatingSystemId;
	}

	public void setOperatingSystemId(OperatingSystemEntity operatingSystemId) {
		this.operatingSystemId = operatingSystemId;
	}

	public Long getCpuSize() {
		return cpuSize;
	}

	public void setCpuSize(Long cpuSize) {
		this.cpuSize = cpuSize;
	}

	public Long getMemorySize() {
		return memorySize;
	}

	public void setMemorySize(Long memorySize) {
		this.memorySize = memorySize;
	}

	public Long getSystemDiskSize() {
		return systemDiskSize;
	}

	public void setSystemDiskSize(Long systemDiskSize) {
		this.systemDiskSize = systemDiskSize;
	}

	public String getCpuUnit() {
		return cpuUnit;
	}

	public void setCpuUnit(String cpuUnit) {
		this.cpuUnit = cpuUnit;
	}

	public String getMemoryUnit() {
		return memoryUnit;
	}

	public void setMemoryUnit(String memoryUnit) {
		this.memoryUnit = memoryUnit;
	}

	public Long getPublicNetwork() {
		return publicNetwork;
	}

	public void setPublicNetwork(Long publicNetwork) {
		this.publicNetwork = publicNetwork;
	}

	public Long getNumbers() {
		return numbers;
	}

	public void setNumbers(Long numbers) {
		this.numbers = numbers;
	}

	public Double getFee() {
		return fee;
	}

	public void setFee(Double fee) {
		this.fee = fee;
	}

	public Long getBuyTime() {
		return buyTime;
	}

	public void setBuyTime(Long buyTime) {
		this.buyTime = buyTime;
	}

	public Date getBeginUseTime() {
		return beginUseTime;
	}

	public void setBeginUseTime(Date beginUseTime) {
		this.beginUseTime = beginUseTime;
	}

	public Date getEndUseTime() {
		return endUseTime;
	}

	public void setEndUseTime(Date endUseTime) {
		this.endUseTime = endUseTime;
	}

	public Long getDataDiskSize() {
		return dataDiskSize;
	}

	public void setDataDiskSize(Long dataDiskSize) {
		this.dataDiskSize = dataDiskSize;
	}

	public String getDataUnit() {
		return dataUnit;
	}

	public void setDataUnit(String dataUnit) {
		this.dataUnit = dataUnit;
	}

	public Long getBuyTimeType() {
		return buyTimeType;
	}

	public void setBuyTimeType(Long buyTimeType) {
		this.buyTimeType = buyTimeType;
	}

	public String getSystemDiskUnit() {
		return systemDiskUnit;
	}

	public void setSystemDiskUnit(String systemDiskUnit) {
		this.systemDiskUnit = systemDiskUnit;
	}

}
