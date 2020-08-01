package com.fh.service.front;

import com.fh.entity.Page;
import com.fh.entity.system.MemUser;
import com.fh.util.PageData;

import java.util.List;

/** 
 * 说明： 前台用户表接口
 * 创建人：Ajie
 * 创建时间：2019-11-25
 * @version
 */
public interface AccountManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;

	/**清空数据
	 * @throws Exception
	 */
	void wipeDate(PageData pd)throws Exception;

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;

	/**循环字段修改
	 * @param pd
	 * @throws Exception
	 */
	void edit1(PageData pd)throws Exception;

	/**转账入场券
	 * @param pd
	 * @throws Exception
	 */
	void updateTicket(PageData pd)throws Exception;

	/**减少入场券
	 * @param pd
	 * @throws Exception
	 */
	void reduceTicket(PageData pd)throws Exception;

	/**设置用户为高级经理
	 * @param pd
	 * @throws Exception
	 */
	void setSenior(PageData pd)throws Exception;

	/**增加钱包余额
	 * @param pd
	 * @throws Exception
	 */
	void addMoneyAmount(PageData pd)throws Exception;

	/**增加提现次数
	 * @param pd
	 * @throws Exception
	 */
	void addCashCount(PageData pd)throws Exception;

	/**提现次数清0
	 * @param pd
	 * @throws Exception
	 */
	void cashCountZero(PageData pd)throws Exception;

	/**限制匹配天数减1
	 * @param pd
	 * @throws Exception
	 */
	void restTimeReduce(PageData pd)throws Exception;

	/**根据手机号修改
	 * @param pd
	 * @throws Exception
	 */
	void editByPhone(PageData pd)throws Exception;

	/**修改个人资料
	 * @param pd
	 * @throws Exception
	 */
	void editMyInfo(PageData pd)throws Exception;

	/**修改密码
	 * @param pd
	 * @throws Exception
	 */
	void editPassword(PageData pd)throws Exception;

	/**增加推荐人数量
	 * @param pd
	 * @throws Exception
	 */
	void addReNumber(PageData pd)throws Exception;

	/**增加算力余额
	 * @param pd
	 * @throws Exception
	 */
	void addPowerNumber(PageData pd)throws Exception;

	/**增加钱包余额
	 * @param pd
	 * @throws Exception
	 */
	void addMoney(PageData pd)throws Exception;

	/**钱包扣钱
	 * @param pd
	 * @throws Exception
	 */
	void reduceMoney(PageData pd)throws Exception;


	/**重置顶点账号信息
	 * @throws Exception
	 */
	void resetAccount(PageData pd)throws Exception;

	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;

	/**列表(推荐图)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> recommendationMap(PageData pd)throws Exception;

	/**列表(根据推荐路径查所有上级)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> listByRePath(PageData pd)throws Exception;

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;

	/**获取直推人数
	 * @param pd
	 * @throws Exception
	 */
	PageData getReCount(PageData pd)throws Exception;

	/**通过个人资料获取数据
	 * @param pd
	 * @throws Exception
	 */
	PageData findByMyInfo(PageData pd)throws Exception;

	/**通过手机号获取数据
	 * @param pd
	 * @throws Exception
	 */
	PageData findByPhone(PageData pd)throws Exception;

	/**通过手机号获取数据,返回实体类
	 * @param pd
	 * @throws Exception
	 * @return
	 */
	MemUser findByPhone1(PageData pd)throws Exception;


	/**重置Oracle序列
	 * @param pd
	 * @throws Exception
	 */
	PageData reset_seq(PageData pd)throws Exception;


	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
}

