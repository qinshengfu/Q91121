package com.fh.service.record;

import com.fh.entity.Page;
import com.fh.util.PageData;

import java.util.List;

/** 
 * 说明： 冻结明细表接口
 * 创建人：
 * 创建时间：2019-12-04
 * @version
 */
public interface Freezing_detailsManager{

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
	 * @param pd
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

	/**列表(按照时间查询)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> listByTime(PageData pd)throws Exception;

	/**列表(根据手机号查询)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listByPhone(PageData pd)throws Exception;

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;

	/**通过手机号获取总额
	 * @param pd
	 * @throws Exception
	 */
	PageData getSumByPhone(PageData pd)throws Exception;

	/**通过手机号获取最新ID
	 * @param pd
	 * @throws Exception
	 */
	PageData findByPhone(PageData pd)throws Exception;

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
}

