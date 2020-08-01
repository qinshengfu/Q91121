package com.fh.service.record.impl;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.record.Purchase_SMDManager;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/** 
 * 说明： 申购SMD
 * 创建人：Ajie
 * 创建时间：2019-11-25
 * @version
 */
@Service("purchase_smdService")
public class Purchase_SMDService implements Purchase_SMDManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("Purchase_SMDMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("Purchase_SMDMapper.delete", pd);
	}

	/**根据订单号删除
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void deleteByOrderNumbe(PageData pd)throws Exception{
		dao.delete("Purchase_SMDMapper.deleteByOrderNumbe", pd);
	}

	/**清空数据
	 * @throws Exception
	 */
	@Override
	public void wipeDate(PageData pd)throws Exception{
		dao.delete("Purchase_SMDMapper.wipeDate", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("Purchase_SMDMapper.edit", pd);
	}

	/**更改状态并增加余额
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void editStateAndMoney(PageData pd)throws Exception{
		dao.update("Purchase_SMDMapper.editStateAndMoney", pd);
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("Purchase_SMDMapper.datalistPage", page);
	}

	/**预付款或者尾款列表
	 * @param page
	 * @throws Exception
	 */
	@Override
	public List<PageData> downPaymentsList(Page page)throws Exception{
		return (List<PageData>)dao.findForList("Purchase_SMDMapper.downPaymentsListPage", page);
	}

	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Purchase_SMDMapper.listAll", pd);
	}

	/**列表(根据订单号获取预付款和尾款据)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public List<PageData> listByOrderNumber(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Purchase_SMDMapper.listByOrderNumber", pd);
	}

	/**列表(根据ID获取未匹配的数据)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public List<PageData> listById(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Purchase_SMDMapper.listById", pd);
	}

	/**列表(通过手机号查所有数据)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public List<PageData> listAllByPhone(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Purchase_SMDMapper.listAllByPhone", pd);
	}

	/**通过订单号查预付款或者尾款
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findByOrderIdAndType(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Purchase_SMDMapper.findByOrderIdAndType", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Purchase_SMDMapper.findById", pd);
	}

	/**通过手机号获取最新的一条订单
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData getNewOrderByPhone(PageData pd)throws Exception{
		return (PageData) dao.findForObject("Purchase_SMDMapper.getNewOrderByPhone", pd);
	}

	/**通过手机号统计尾款查交易完成订单的数据
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData getCountByPhoneAndFulfil(PageData pd)throws Exception{
		return (PageData) dao.findForObject("Purchase_SMDMapper.getCountByPhoneAndFulfil", pd);
	}

	/**通过手机号统计交易完成的总额
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData getSumAmount(PageData pd)throws Exception{
		return (PageData) dao.findForObject("Purchase_SMDMapper.getSumAmount", pd);
	}

	/**通过订单id获取数据
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findByOrderId(PageData pd)throws Exception{
		return (PageData) dao.findForObject("Purchase_SMDMapper.findByOrderId", pd);
	}

	/**获取最新的订单ID
	 * @throws Exception
	 */
	@Override
	public PageData getMaxOrderId()throws Exception{
		return (PageData) dao.findForObject("Purchase_SMDMapper.getMaxOrderId", null);
	}

	/**获取所有未匹配的订单金额累计
	 * @throws Exception
	 */
	@Override
	public PageData getUnmatchCount()throws Exception{
		return (PageData) dao.findForObject("Purchase_SMDMapper.getUnmatchCount", null);
	}

    /**获取预付款或尾款未匹配的订单金额累计
     * @param pd
     * @throws Exception
     */
    @Override
    public PageData getUnmatchCount1(PageData pd)throws Exception{
        return (PageData)dao.findForObject("Purchase_SMDMapper.getUnmatchCount1", pd);
    }

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("Purchase_SMDMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

