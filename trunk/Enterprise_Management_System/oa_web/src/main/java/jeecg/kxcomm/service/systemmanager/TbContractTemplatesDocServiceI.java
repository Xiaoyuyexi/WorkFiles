package jeecg.kxcomm.service.systemmanager;

import java.util.List;

import jeecg.kxcomm.entity.systemmanager.TbContractTemplatesDocEntity;

import org.jeecgframework.core.common.hibernate.qbc.HqlQuery;
import org.jeecgframework.core.common.hibernate.qbc.PageList;
import org.jeecgframework.core.common.service.CommonService;

public interface TbContractTemplatesDocServiceI extends CommonService{
	
	public List<TbContractTemplatesDocEntity> getConTempList(HqlQuery hqlQuery, boolean b,TbContractTemplatesDocEntity tbContractTemplatesDocEntity, String temple_id);
	
	public PageList getPageList(HqlQuery hqlQuery, boolean b,TbContractTemplatesDocEntity tbContractTemplatesDocEntity, String temple_id, String statsvalues);

	/**
	 * 保存合同模板与模板文件之间的关系.
	 *
	 * @param contempIds
	 * @param filesId
	 */
	void saveMidTempFileEntity(String contempIds, String filesId);

	/**
	 * 删除合同模板与模板文件之间的关系.
	 *
	 * @param contempIds
	 */
	void delMidTempFileEntity(String contempIds);
}