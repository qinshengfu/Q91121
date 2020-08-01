package com.fh.service.record;

import com.fh.entity.Page;
import com.fh.util.PageData;

import java.util.List;

/** 
 * 说明： 申购SMD接口
 * 创建人：Ajie
 * 创建时间：2019-11-25
 * @version
 */
public interface Purchase_SMDManager{

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

	/**根据订单号删除
	 * @param pd
	 * @throws Exception
	 */
	void deleteByOrderNumbe(PageData pd)throws Exception;

	/**清空数据
	 * @throws Exception
	 */
	void wipeDate(PageData pd)throws Exception;

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;

	/**更改状态并增加余额
	 * @param pd
	 * @throws Exception
	 */
	void editStateAndMoney(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;

	/**预付款或者尾款列表
	 * @param page
	 * @throws Exception
	 */
	List<PageData> downPaymentsList(Page page)throws Exception;

	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;

	/**列表(根据订单号获取预付款和尾款)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> listByOrderNumber(PageData pd)throws Exception;

	/**列表(根据ID获取未匹配的数据)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> listById(PageData pd)throws Exception;

	/**列表(通过手机号查所有数据)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> listAllByPhone(PageData pd)throws Exception;

	/**通过订单号查预付款或者尾款
	 * @param pd
	 * @throws Exception
	 */
	PageData findByOrderIdAndType(PageData pd)throws Exception;

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;

	/**通过手机号获取最新的一条订单
	 * @param pd
	 * @throws Exception
	 */
	PageData getNewOrderByPhone(PageData pd)throws Exception;

	/**通过手机号统计尾款查交易完成订单的数据
	 * @param pd
	 * @throws Exception
	 */
	PageData getCountByPhoneAndFulfil(PageData pd)throws Exception;

	/**通过手机号统计交易完成的总额
	 * @param pd
	 * @throws Exception
	 */
	PageData getSumAmount(PageData pd)throws Exception;

	/**通过订单id获取数据
	 * @param pd
	 * @throws Exception
	 */
	PageData findByOrderId(PageData pd)throws Exception;

	/**获取最新的订单ID
	 * @throws Exception
	 */
	PageData getMaxOrderId()throws Exception;

	/**获取所有未匹配的订单金额累计
	 * @throws Exception
	 */
	PageData getUnmatchCount()throws Exception;

    /**获取预付款或尾款未匹配的订单金额累计
     *  @param pd
     * @throws Exception
     */
    PageData getUnmatchCount1(PageData pd)throws Exception;

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
}

