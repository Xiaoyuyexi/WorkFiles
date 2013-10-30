package cn.com.kxcomm.entity;

import java.util.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;

/**
 * 
 * 功能描述:订单表 版权所有：康讯通讯 未经本公司许可，不得以任何方式复制或使用本程序任何部分
 * 
 * @author chenliang 新增日期：2013-9-11
 * @author chenliang 修改日期：2013-9-11
 * @since system_center_share
 */
@Entity
@SequenceGenerator(name="SEQ_VIRTUALMACHINE_ID",sequenceName="SEQ_VIRTUALMACHINE_ID",allocationSize=1)
@Table(name = "tb_domain")
public class VirtualMachineEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE,generator="SEQ_VIRTUALMACHINE_ID")
	@Column(name = "id", updatable = false, nullable = false, insertable = false, length = 32)
	private Long id;
	
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name = "tb_vhd_disk_id", nullable = false)
	private VhdDiskEntity tbVhdDiskId;
	
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name = "tb_iso_id", nullable = false)
	private ISOEntity tbIsoId;
	
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name = "tb_virtual_type_id", nullable = false)
	private VirtualTypeEntity tbVirtualTypeId;
	
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name = "tb_virtual_netWork_switch_id", nullable = false)
	private VirtualNetworkSwitchEntity tbVirtualNetWorkSwitchId;
	
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name = "operating_system_id", nullable = false)
	private OperatingSystemEntity operatingSystem;
	
	@Column(name = "host_name", updatable = false, nullable = false, insertable = false, length = 150)
	private String hostName;//主机名
	
	@Column(name = "intranet_ip", updatable = false, nullable = false, insertable = false, length = 150)
	private String intranetIp; //内网ip
	
	@Column(name = "extranet_ip", updatable = false, nullable = false, insertable = false, length = 150)
	private String extranetIp; //外网ip
	
	@Column(name = "destruction_time", updatable = false, nullable = true, insertable = false)
	private Date destructionTime;//销毁时间
	
	@Column(name = "create_time", updatable = false, nullable = true, insertable = false)
	private Date createTime;//创建时间
	
	@Column(name = "boot_time", updatable = false, nullable = true, insertable = false)
	private Date bootTime;  //开机时间
	
	@Column(name = "shut_down_time", updatable = false, nullable = true, insertable = false)
	private Date shutDownTime; //关机时间
	
	@Column(name = "cpu_size", updatable = false, nullable = false, insertable = false,length = 32)
	private Long cpuSize; //cpu大小
	
	@Column(name = "memory_size", updatable = false, nullable = false, insertable = false,length = 32)
	private Long memorySizeLong;  //内存大小
	
	@Column(name = "disk_size", updatable = false, nullable = false, insertable = false,length = 32)
	private Long diskSize; //系统盘大小
	
	@Column(name = "extranet_port", updatable = false, nullable = false, insertable = false,length = 32)
	private String extranetPort; //公网端口
	
	@Column(name = "state", updatable = false, nullable = false, insertable = false,length = 32)
	private Integer state; //状态
	
	@Column(name = "cpu_unit", updatable = false, nullable = false, insertable = false,length = 150)
	private String cpuUnit; //cpu单位
	
	@Column(name = "memory_unit", updatable = false, nullable = false, insertable = false,length = 150)
	private String memoryUnit;
	
	@Column(name = "disk_unit", updatable = false, nullable = false, insertable = false,length = 150)
	private String diskUnit; //系统盘大小单位
	
	@Column(name = "data_disk_size", updatable = false, nullable = false, insertable = false,length = 32)
	private Long dataDiskSize; //数据盘大小
	
	@Column(name = "data_disk_unit", updatable = false, nullable = false, insertable = false,length = 32)
	private String dataDiskUnit; //数据盘大小单位
	
	@OneToMany(mappedBy = "virtualMachineId")
	@Cascade({ CascadeType.ALL })
	private Set<DomUserEntity> domUserEntity;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public VhdDiskEntity getTbVhdDiskId() {
		return tbVhdDiskId;
	}

	public void setTbVhdDiskId(VhdDiskEntity tbVhdDiskId) {
		this.tbVhdDiskId = tbVhdDiskId;
	}

	public ISOEntity getTbIsoId() {
		return tbIsoId;
	}

	public void setTbIsoId(ISOEntity tbIsoId) {
		this.tbIsoId = tbIsoId;
	}

	public VirtualTypeEntity getTbVirtualTypeId() {
		return tbVirtualTypeId;
	}

	public void setTbVirtualTypeId(VirtualTypeEntity tbVirtualTypeId) {
		this.tbVirtualTypeId = tbVirtualTypeId;
	}

	public VirtualNetworkSwitchEntity getTbVirtualNetWorkSwitchId() {
		return tbVirtualNetWorkSwitchId;
	}

	public void setTbVirtualNetWorkSwitchId(VirtualNetworkSwitchEntity tbVirtualNetWorkSwitchId) {
		this.tbVirtualNetWorkSwitchId = tbVirtualNetWorkSwitchId;
	}

	public String getHostName() {
		return hostName;
	}

	public void setHostName(String hostName) {
		this.hostName = hostName;
	}

	public String getIntranetIp() {
		return intranetIp;
	}

	public void setIntranetIp(String intranetIp) {
		this.intranetIp = intranetIp;
	}

	public String getExtranetIp() {
		return extranetIp;
	}

	public void setExtranetIp(String extranetIp) {
		this.extranetIp = extranetIp;
	}

	public Date getDestructionTime() {
		return destructionTime;
	}

	public void setDestructionTime(Date destructionTime) {
		this.destructionTime = destructionTime;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getBootTime() {
		return bootTime;
	}

	public void setBootTime(Date bootTime) {
		this.bootTime = bootTime;
	}

	public Date getShutDownTime() {
		return shutDownTime;
	}

	public void setShutDownTime(Date shutDownTime) {
		this.shutDownTime = shutDownTime;
	}

	public Long getCpuSize() {
		return cpuSize;
	}

	public void setCpuSize(Long cpuSize) {
		this.cpuSize = cpuSize;
	}

	public Long getMemorySizeLong() {
		return memorySizeLong;
	}

	public void setMemorySizeLong(Long memorySizeLong) {
		this.memorySizeLong = memorySizeLong;
	}

	public Long getDiskSize() {
		return diskSize;
	}

	public void setDiskSize(Long diskSize) {
		this.diskSize = diskSize;
	}

	public String getExtranetPort() {
		return extranetPort;
	}

	public void setExtranetPort(String extranetPort) {
		this.extranetPort = extranetPort;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
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

	public String getDiskUnit() {
		return diskUnit;
	}

	public void setDiskUnit(String diskUnit) {
		this.diskUnit = diskUnit;
	}

	public OperatingSystemEntity getOperatingSystem() {
		return operatingSystem;
	}

	public void setOperatingSystem(OperatingSystemEntity operatingSystem) {
		this.operatingSystem = operatingSystem;
	}

	public Long getDataDiskSize() {
		return dataDiskSize;
	}

	public void setDataDiskSize(Long dataDiskSize) {
		this.dataDiskSize = dataDiskSize;
	}

	public String getDataDiskUnit() {
		return dataDiskUnit;
	}

	public void setDataDiskUnit(String dataDiskUnit) {
		this.dataDiskUnit = dataDiskUnit;
	}

	@Override
	public String toString() {
		return "VirtualMachineEntity [id=" + id + ", tbVhdDiskId="
				+ tbVhdDiskId + ", tbIsoId=" + tbIsoId + ", tbVirtualTypeId="
				+ tbVirtualTypeId + ", tbVirtualNetWorkSwitchId="
				+ tbVirtualNetWorkSwitchId + ", hostName=" + hostName
				+ ", intranetIp=" + intranetIp + ", extranetIp=" + extranetIp
				+ ", destructionTime=" + destructionTime + ", createTime="
				+ createTime + ", bootTime=" + bootTime + ", shutDownTime="
				+ shutDownTime + ", cpuSize=" + cpuSize + ", memorySizeLong="
				+ memorySizeLong + ", diskSize=" + diskSize + ", extranetPort="
				+ extranetPort + ", state=" + state + ", cpuUnit=" + cpuUnit
				+ ", memoryUnit=" + memoryUnit + ", diskUnit=" + diskUnit
				+ ", operatingSystem=" + operatingSystem + ", dataDiskSize="
				+ dataDiskSize + ", dataDiskUnit=" + dataDiskUnit + "]";
	}

}