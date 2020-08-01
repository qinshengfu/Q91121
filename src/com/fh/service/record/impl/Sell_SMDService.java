package com.fh.service.record.impl;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.record.Sell_SMDManager;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/** 
 * 说明： 卖出SMD
 * 创建人：Ajie
 * 创建时间：2019-11-25
 * @version
 */
@Service("sell_smdService")
public class Sell_SMDService implements Sell_SMDManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("Sell_SMDMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("Sell_SMDMapper.delete", pd);
	}

	/**清空数据
	 * @throws Exception
	 */
	public void wipeDate(PageData pd)throws Exception{
		dao.delete("Sell_SMDMapper.wipeDate", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("Sell_SMDMapper.edit", pd);
	}

	/**更改状态并增加余额
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void editStateAndMoney(PageData pd)throws Exception{
		dao.update("Sell_SMDMapper.editStateAndMoney", pd);
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("Sell_SMDMapper.datalistPage", page);
	}

	/**余额大于0的列表
	 * @param page
	 * @throws Exception
	 */
	@Override
	public List<PageData> list1(Page page)throws Exception{
		return (List<PageData>)dao.findForList("Sell_SMDMapper.datalistPage1", page);
	}

	/**列表(通过手机号获取所有赎回列表)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public List<PageData> listByPhone(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Sell_SMDMapper.listByPhone", pd);
	}

	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Sell_SMDMapper.listAll", pd);
	}

	/**列表(根据ID获取未匹配的数据)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public List<PageData> listById(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Sell_SMDMapper.listById", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Sell_SMDMapper.findById", pd);
	}

	/**通过订单id获取数据
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findByOrderId(PageData pd)throws Exception{
		return (PageData) dao.findForObject("Sell_SMDMapper.findByOrderId", pd);
	}

	/**获取最大订单ID
	 * @throws Exception
	 */
	@Override
	public PageData getMaxOrderId()throws Exception{
		return (PageData)dao.findForObject("Sell_SMDMapper.getMaxOrderId", null);
	}

	/**获取所有未匹配的订单金额累计
	 * @throws Exception
	 */
	@Override
	public PageData getUnmatchCount()throws Exception{
		return (PageData) dao.findForObject("Sell_SMDMapper.getUnmatchCount", null);
	}


	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("Sell_SMDMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

