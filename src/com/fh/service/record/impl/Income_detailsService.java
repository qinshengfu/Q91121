package com.fh.service.record.impl;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.record.Income_detailsManager;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/** 
 * 说明： 收益明细
 * 创建人：Ajie
 * 创建时间：2019-12-04
 * @version
 */
@Service("income_detailsService")
public class Income_detailsService implements Income_detailsManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("Income_detailsMapper.save", pd);
	}
	
	/**删除
	 * @param pd wipeDate
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("Income_detailsMapper.delete", pd);
	}

	/**清空数据
	 * @param pd wipeDate
	 * @throws Exception
	 */
	@Override
	public void wipeDate(PageData pd)throws Exception{
		dao.delete("Income_detailsMapper.wipeDate", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("Income_detailsMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("Income_detailsMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Income_detailsMapper.listAll", pd);
	}

	/**列表(根据手机号查询)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public List<PageData> listByPhone(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Income_detailsMapper.listByPhone", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Income_detailsMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("Income_detailsMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

