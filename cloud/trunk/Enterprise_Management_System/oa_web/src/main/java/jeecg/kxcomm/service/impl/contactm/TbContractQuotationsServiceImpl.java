package jeecg.kxcomm.service.impl.contactm;

import java.io.File;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import jeecg.kxcomm.entity.contactm.TbContractEntity;
import jeecg.kxcomm.entity.systemmanager.TbContractDocEntity;
import jeecg.kxcomm.entity.systemmanager.TbContractDocVariableEntity;
import jeecg.kxcomm.service.contactm.TbContractQuotationsServiceI;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



import jeecg.kxcomm.util.FilUtil2;
import jeecg.kxcomm.util.WordTools;
import jeecg.kxcomm.vo.contactm.ContractQuotationsVo;

@Service("tbContractQuotationsService")
@Transactional
public class TbContractQuotationsServiceImpl extends CommonServiceImpl implements TbContractQuotationsServiceI{

	/**
	 * 
	 * 导出合同报价表总价excel
	 * 
	 * @param contract
	 *            合同对象
	 * @author zhangjh 新增日期：2012-12-28
	 * @since ContractManage
	 */
	@Override
	public TbContractEntity exportContractTotalPrice(TbContractEntity contract,HttpServletRequest request) {
		if(contract==null){
			return contract;
		}
		 String filePath = request.getSession().getServletContext().getRealPath("exportExcelPath");
		 String sheetName = "价格总表";
		 String firstLineString="合同附件2 价格总表";
		List<String> list =new ArrayList<String>();
	//	String filePath=para.exportExcelPath;
		String fileName=contract.getQuotationsExcel();
		List<ContractQuotationsVo> contractList = queryAllQuotations(contract.getId());
		
		//把总价格四舍五入
		NumberFormat nf = NumberFormat.getNumberInstance();
		nf.setMaximumFractionDigits(0);
		for (ContractQuotationsVo t : contractList) {
			StringBuffer text = new StringBuffer(); 
			double totalprice = t.getUnitPrice()!=null?Double.parseDouble(t.getUnitPrice()):0d;
			System.out.println("@@@@@@@@@@@@@"+totalprice);
			text.append(t.getProjectName()+","+t.getQuotationName()+",台,"+t.getQuantity()+","+nf.format(totalprice).replace(",", "")+",  ");
			list.add(text.toString());
		}
		 if(null == fileName || "".equals(fileName)) {
			 fileName =""+System.currentTimeMillis();
		 }
		 if(fileName.indexOf(".xlsx") < 0) {
			 fileName = fileName+".xlsx";
		 }	
		 FilUtil2.createPriceListExcel(sheetName,firstLineString, list, filePath, fileName);
		 contract.setQuotationsExcel(fileName);
		 this.getEntity(TbContractEntity.class, contract.getId());
		 return contract;
	}
	
	public List<ContractQuotationsVo> queryAllQuotations(String contractId)
	{
		StringBuffer sb=new StringBuffer();
		sb.append(" SELECT b.contract_total_price,c.total_price,q.quantity,q.name,q.project_name ");
		sb.append(" FROM tb_contract_quotations a,tb_contract b,tb_config_models c,tb_quotations_data q ");
		sb.append(" WHERE a.contract_id=b.id AND a.quotations_id=q.quotations_id AND q.config_models_id=c.id ");
		sb.append(" and b.id=?");
		sb.append(" group by c.id ");
		List<Map<String, Object>> list=this.findForJdbc(sb.toString(),contractId);
		Object[] obj = new Object[list.size()];
		List<ContractQuotationsVo> detailvoList = new ArrayList<ContractQuotationsVo>();
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = list.get(i);
			ContractQuotationsVo vo=new ContractQuotationsVo();
			vo.setTotalPrice((String)map.get("contract_total_price"));
			vo.setUnitPrice((String)map.get("total_price"));
			vo.setQuantity(""+map.get("quantity"));
			vo.setQuotationName((String)map.get("name"));
			vo.setProjectName((String)map.get("project_name"));
			//obj = (Object[]) list.get(i);
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@"+(String)map.get("contract_total_price")+"@@"+(String)map.get("project_name"));
			detailvoList.add(vo);
		}
		return detailvoList;		
	}
	/**
	 * 
	 * 生成合同文件并替换变量
	 * 
	 * @param contract
	 *            合同对象
	 * @author zhangjh 新增日期：2012-12-28
	 * @since 
	 */
	@Override
	public boolean shengchengContractFile(String contractId,HttpServletRequest request) {
		if(contractId==null)
			return false;
		try{
	//		Parameters para = Parameters.getInstance();
			WordTools tools = WordTools.getInstance();
			List<TbContractDocVariableEntity> docVariable = null;
			TbContractDocVariableEntity var = null;
			TbContractDocEntity contractDoc = null;
        	String end = request.getSession().getServletContext().getRealPath("exportExcelPath");
			String docTemp = request.getSession().getServletContext().getRealPath("upload");
			TbContractEntity contractEntity=this.getEntity(TbContractEntity.class, contractId);
			//查询该合同下的所有合同文件
			List<TbContractDocEntity> idsd = this.queryConFileById(contractId);
			long fileName = 0;
			//导出DOC文件
			System.out.println("****************************DocStart********************     List<TbContractDoc>:"+idsd.size());
			for(int i = 0;i < idsd.size(); i++) {
				contractDoc = idsd.get(i);
				if(null != contractDoc) {
					String endPath = contractDoc.getTemplatesdocId().getPath();
					File bfile = new File(docTemp+"\\"+endPath);
					if(!bfile.exists())
					{
						return false;
					}else {
					fileName = System.currentTimeMillis();
					//判断文件是否是图片，不是图片才进行下面操作
					if(endPath.endsWith("docx")){
						String id = idsd.get(i).getId();
						List<TbContractDocVariableEntity> volist = this.queryAllContractDocVariable(id);
						docVariable = new ArrayList<TbContractDocVariableEntity>();
						for(int j = 0;j < volist.size(); j++) {
							var = new TbContractDocVariableEntity();
							var.setVariablename(volist.get(j).getVariablename());
							var.setContent(volist.get(j).getContent());
							docVariable.add(var);
						}
						System.out.println(docTemp+endPath+"       "+end+fileName+".docx");
						tools.export(docTemp+"\\"+endPath,docVariable,end+"\\"+fileName+".docx");
						contractDoc.setExportpath(fileName+".docx");
					}else if(endPath.endsWith("jpg")){
						//把图片移到下载的文件夹
						tools.moveFile(docTemp+endPath,end+fileName+".jpg");
						contractDoc.setExportpath(fileName+".jpg");
					}
					this.updateEntitie(contractDoc);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	/**
	 * 
	* 方法用途和描述:根据合同ID查询所有的合同文件
	* @param contractId 合同id
	* @return
	* @author lizl 新增日期：2012-12-27
	* @since ContractManage
	 */
	@Override
	public List<TbContractDocEntity> queryConFileById(String contractId) {
		String hql=" from TbContractDocEntity t where t.contractId.id = ? ";
		List<TbContractDocEntity> contractDocList = this.findHql(hql.toString(), contractId);
		return contractDocList;
	}
	
	public List<TbContractDocVariableEntity> queryAllContractDocVariable(String id)
	{
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT v.docVariable,v.docVariable,v.variableName,v.content,v.doc_id ");
		sql.append(" FROM tb_contract_doc_variable v,tb_contract_doc d,tb_contract_templates_doc_variable t3 ");
		sql.append(" where v.doc_id=? ");
		sql.append(" AND v.doc_id=d.doc_id ");
		sql.append(" AND v.variableName = t3.variableName ");
		sql.append(" and d.templatesDoc_id = t3.templatesDoc_id");
		List<TbContractDocVariableEntity> listContractDocVariable=new ArrayList<TbContractDocVariableEntity>();
		List<Map<String, Object>> list=this.findForJdbc(sql.toString(), id);
	    for(int i=0;i<list.size();i++){
	    	Map<String, Object> map = list.get(i);
	    	TbContractDocVariableEntity tb=new TbContractDocVariableEntity();
	    	tb.setId((String)map.get("id"));
	    	TbContractDocEntity docId=new TbContractDocEntity();
	    	docId.setId((String)map.get("doc_id"));
	    	tb.setDocId(docId);
	    	tb.setVariablename((String)map.get("variableName"));
	    	tb.setContent((String)map.get("content"));
	    	listContractDocVariable.add(tb);
	    }
	    return listContractDocVariable;
	}
}