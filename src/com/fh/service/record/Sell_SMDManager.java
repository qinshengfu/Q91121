package com.fh.service.record;

import com.fh.entity.Page;
import com.fh.util.PageData;

import java.util.List;

/** 
 * 说明： 卖出SMD接口
 * 创建人：Ajie
 * 创建时间：2019-11-25
 * @version
 */
public interface Sell_SMDManager{

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

	/**更改状态并增加余额
	 * @param pd
	 * @throws Exception
	 */
	public void editStateAndMoney(PageData pd)throws Exception;

	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;

	/**余额大于0的列表
	 * @param page
	 * @throws Exception
	 */
	List<PageData> list1(Page page)throws Exception;

	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;

	/**列表(通过手机号获取所有赎回列表)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> listByPhone(PageData pd)throws Exception;

	/**列表(根据ID获取未匹配的数据)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> listById(PageData pd)throws Exception;

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;

	/**通过订单id获取数据
	 * @param pd
	 * @throws Exception
	 */
	PageData findByOrderId(PageData pd)throws Exception;

	/**获取最大订单ID
	 * @throws Exception
	 */
	PageData getMaxOrderId()throws Exception;

	/**获取所有未匹配的订单金额累计
	 * @throws Exception
	 */
	PageData getUnmatchCount()throws Exception;

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
}

