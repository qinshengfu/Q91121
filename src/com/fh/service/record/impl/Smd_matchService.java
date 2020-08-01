package com.fh.service.record.impl;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.record.Smd_matchManager;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/** 
 * 说明： 匹配订单
 * 创建人：
 * 创建时间：2019-11-30
 * @version
 */
@Service("smd_matchService")
public class Smd_matchService implements Smd_matchManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("Smd_matchMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("Smd_matchMapper.delete", pd);
	}

	/**清空数据
	 * @throws Exception
	 */
	@Override
	public void wipeDate(PageData pd)throws Exception{
		dao.delete("Smd_matchMapper.wipeDate", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("Smd_matchMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("Smd_matchMapper.datalistPage", page);
	}

	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Smd_matchMapper.listAll", pd);
	}

	/**列表(根据时间查询)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public List<PageData> listByTime(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Smd_matchMapper.listByTime", pd);
	}

	/**列表(只完成了预付款的订单)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public List<PageData> listByState(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Smd_matchMapper.listByState", pd);
	}

	/**列表(只完成了尾款的订单)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public List<PageData> listByState1(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Smd_matchMapper.listByState1", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Smd_matchMapper.findById", pd);
	}

	/**通过订单id获取数据
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public List<PageData> findByOrderId(PageData pd)throws Exception{
		return (List<PageData>) dao.findForList("Smd_matchMapper.findByOrderId", pd);
	}

	/**获取最新订单id
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData getMaxOrderId(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Smd_matchMapper.getMaxOrderId", pd);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("Smd_matchMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

