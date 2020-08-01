package com.fh.service.front.impl;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.system.MemUser;
import com.fh.service.front.AccountManager;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/** 
 * 说明： 前台用户表
 * 创建人：Ajie
 * 创建时间：2019-11-25
 * @version
 */
@Service("accountService")
public class AccountService implements AccountManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("AccountMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("AccountMapper.delete", pd);
	}

	/**清空数据
	 * @throws Exception
	 */
	@Override
	public void wipeDate(PageData pd)throws Exception{
		dao.delete("AccountMapper.wipeDate", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("AccountMapper.edit", pd);
	}

	/**循环字段修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void edit1(PageData pd)throws Exception{
		dao.update("AccountMapper.edit1", pd);
	}

	/**转账入场券
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@Transactional
	public void updateTicket(PageData pd)throws Exception{
		dao.update("AccountMapper.addTicket", pd);
		dao.update("AccountMapper.reduceTicket", pd);
	}

	/**减少入场券
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@Transactional
	public void reduceTicket(PageData pd)throws Exception{
		dao.update("AccountMapper.reduceTicket", pd);
	}

	/**设置用户为高级经理
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void setSenior(PageData pd)throws Exception{
		dao.update("AccountMapper.setSenior", pd);
	}

	/**增加钱包余额
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void addMoneyAmount(PageData pd)throws Exception{
		dao.update("AccountMapper.addMoneyAmount", pd);
	}

	/**增加提现次数
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void addCashCount(PageData pd)throws Exception{
		dao.update("AccountMapper.addCashCount", pd);
	}

	/**提现次数清0
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void cashCountZero(PageData pd)throws Exception{
		dao.update("AccountMapper.cashCountZero", pd);
	}

	/**限制匹配天数减1
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void restTimeReduce(PageData pd)throws Exception{
		dao.update("AccountMapper.restTimeReduce", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void editByPhone(PageData pd)throws Exception{
		dao.update("AccountMapper.editByPhone", pd);
	}

	/**修改个人资料
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void editMyInfo(PageData pd)throws Exception{
		dao.update("AccountMapper.editMyInfo", pd);
	}

	/**修改密码
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void editPassword(PageData pd)throws Exception{
		dao.update("AccountMapper.editPassword", pd);
	}

	/**钱包扣钱
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void reduceMoney(PageData pd)throws Exception{
		dao.update("AccountMapper.reduceMoney", pd);
	}

	/**增加算力余额
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void addPowerNumber(PageData pd)throws Exception{
		dao.update("AccountMapper.addPowerNumber", pd);
	}

	/**增加推荐人数量
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void addReNumber(PageData pd)throws Exception{
		dao.update("AccountMapper.addReNumber", pd);
	}

	/**增加钱包余额
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void addMoney(PageData pd)throws Exception{
		dao.update("AccountMapper.addMoney", pd);
	}

	/**重置顶点账号信息
	 * @throws Exception
	 */
	public void resetAccount(PageData pd)throws Exception{
		dao.update("AccountMapper.resetAccount", pd);
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("AccountMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AccountMapper.listAll", pd);
	}

	/**列表(推荐图)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public List<PageData> recommendationMap(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AccountMapper.recommendationMap", pd);
	}

	/**列表(根据推荐路径查所有上级)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public List<PageData> listByRePath(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AccountMapper.listByRePath", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AccountMapper.findById", pd);
	}

	/**获取直推人数
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData getReCount(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AccountMapper.getReCount", pd);
	}

	/**通过个人资料获取数据
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findByMyInfo(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AccountMapper.findByMyInfo", pd);
	}

	/**通过手机号获取数据
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findByPhone(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AccountMapper.findByPhone", pd);
	}

	/**通过手机号获取数据，返回实体类
	 * @param pd
	 * @throws Exception
	 * @return
	 */
	public MemUser findByPhone1(PageData pd)throws Exception{
		return (MemUser) dao.findForObject("AccountMapper.findByPhone1", pd);
	}


	/**重置序列
	 * @param pd
	 * @throws Exception
	 */
	public PageData reset_seq(PageData pd)throws Exception{
		return (PageData) dao.findForObject("AccountMapper.reset_seq", pd);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("AccountMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

