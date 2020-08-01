package com.fh.service.record.impl;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.record.Freezing_detailsManager;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/** 
 * 说明： 冻结明细表
 * 创建人：
 * 创建时间：2019-12-04
 * @version
 */
@Service("freezing_detailsService")
public class Freezing_detailsService implements Freezing_detailsManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("Freezing_detailsMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("Freezing_detailsMapper.delete", pd);
	}

	/**清空数据
	 * @param pd
	 * @throws Exception
	 */
	public void wipeDate(PageData pd)throws Exception{
		dao.delete("Freezing_detailsMapper.wipeDate", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("Freezing_detailsMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("Freezing_detailsMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Freezing_detailsMapper.listAll", pd);
	}

	/**列表(按照时间查询)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public List<PageData> listByTime(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Freezing_detailsMapper.listByTime", pd);
	}

	/**列表(根据手机号查询)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public List<PageData> listByPhone(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Freezing_detailsMapper.listByPhone", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Freezing_detailsMapper.findById", pd);
	}

	/**通过手机号获取总额
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData getSumByPhone(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Freezing_detailsMapper.getSumByPhone", pd);
	}

	/**通过手机号获取最新ID
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findByPhone(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Freezing_detailsMapper.findByPhone", pd);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("Freezing_detailsMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

