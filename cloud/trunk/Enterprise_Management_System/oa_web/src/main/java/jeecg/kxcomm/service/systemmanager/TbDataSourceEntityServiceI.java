package jeecg.kxcomm.service.systemmanager;



import java.io.InputStream;
import java.util.List;

import javax.transaction.SystemException;

import jeecg.kxcomm.entity.contactm.TbOrderEntity;
import jeecg.kxcomm.entity.systemmanager.TbDataSourceEntityEntity;
import jeecg.kxcomm.vo.systemmanager.DataBean;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.jeecgframework.core.common.service.CommonService;

public interface TbDataSourceEntityServiceI extends CommonService{

	public List<DataBean> listDetailDataRecord(String id);
	
	public void delMain (TbDataSourceEntityEntity tbDataSource);
	
	public boolean uploadDataSource(XSSFWorkbook workbook,TbDataSourceEntityEntity dataSource) throws SystemException;
}