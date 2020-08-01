package com.fh.service.record;

import com.fh.entity.Page;
import com.fh.util.PageData;

import java.util.List;

/** 
 * 说明： 匹配订单接口
 * 创建人：
 * 创建时间：2019-11-30
 * @version
 */
public interface Smd_matchManager{

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

	/**列表(根据时间查询)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> listByTime(PageData pd)throws Exception;

	/**列表(只完成了预付款的订单)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> listByState(PageData pd)throws Exception;

	/**列表(完成了尾款的订单)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> listByState1(PageData pd)throws Exception;

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;

	/**通过订单id获取数据
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> findByOrderId(PageData pd)throws Exception;

	/**获取最新订单id
	 * @param pd
	 * @throws Exception
	 */
	PageData getMaxOrderId(PageData pd)throws Exception;

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
}

