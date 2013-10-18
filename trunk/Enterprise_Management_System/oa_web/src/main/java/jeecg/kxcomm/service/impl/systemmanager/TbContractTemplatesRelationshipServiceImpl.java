package jeecg.kxcomm.service.impl.systemmanager;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jeecg.kxcomm.entity.systemmanager.TbContractTemplatesRelationshipEntity;
import jeecg.kxcomm.service.systemmanager.TbContractTemplatesRelationshipServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;


@Service("tbContractTemplatesRelationshipService")
@Transactional
public class TbContractTemplatesRelationshipServiceImpl extends CommonServiceImpl implements TbContractTemplatesRelationshipServiceI {
	
	@Override
	public List<TbContractTemplatesRelationshipEntity> listByDocId(String docId) {
		String hql = "from TbContractTemplatesRelationshipEntity a where a.templatesdocId.id = ?";
		List<TbContractTemplatesRelationshipEntity> relationShiplist = this.findHql(hql, docId);
		return relationShiplist;
	}
}