package com.fh.controller.front;

import com.fh.controller.base.BaseController;
import com.fh.service.front.AccountManager;
import com.fh.service.front.Sys_configManager;
import com.fh.service.record.*;
import com.fh.util.*;
import com.fh.util.express.ThreadManagers;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/** 
 * 说明：系统参数配置
 * 创建人：Ajie
 * 创建时间：2019-11-25
 */
@Controller
@RequestMapping(value="/sys_config")
public class Sys_configController extends BaseController {
	
	String menuUrl = "sys_config/list.do"; //菜单地址(权限用)
	@Resource(name="sys_configService")
	private Sys_configManager sys_configService;

	// 前台用户管理
	@Resource(name="accountService")
	private AccountManager accountService;
	// 收益明细
	@Resource(name="income_detailsService")
	private Income_detailsManager income_detailsService;
	// 申购SMD
	@Resource(name="purchase_smdService")
	private Purchase_SMDManager purchase_smdService;
	// 出售SMD
	@Resource(name="sell_smdService")
	private Sell_SMDManager sell_smdService;
	// 轮录播图管理
	@Resource(name="sys_chartService")
	private Sys_chartManager sys_chartService;
	// 新闻公告管理
	@Resource(name="sys_newsService")
	private Sys_newsManager sys_newsService;
	// 匹配订单记录
	@Resource(name="smd_matchService")
	private Smd_matchManager smd_matchService;
	// 冻结明细
	@Resource(name="freezing_detailsService")
	private Freezing_detailsManager freezing_detailsService;
	@Resource(name="rechargeService")
	private RechargeManager rechargeService;
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	@ResponseBody
	public String edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Sys_config");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("GMT_MODIFIED", Tools.date2Str(new Date()));	//更新时间
		PageData map = (PageData) applicati.getAttribute(Const.PAR);
		// 如果系统启动时间没有修改则更新最新时间
		if (pd.getString("SYSTEM_START_TIME").equals(map.getString("SYSTEM_START_TIME"))){
			pd.put("SYSTEM_START_TIME", DateUtil.getTime());
		}
		sys_configService.edit(pd);
		System.out.println("修改系统参数："+pd);
		System.out.println("系统参数长度为："+pd.size());
		// 更新缓存
		applicati.setAttribute(Const.PAR, pd);
		return "success";
	}


	/**
	 * 功能描述：清空数据,保留顶点用户
	 * @author Ajie
	 * @date 2019/11/26 0026
	 */
	@RequestMapping(value="/wipeAllData")
	@ResponseBody
	public String wipeData(HttpServletRequest request) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"清空数据");
		PageData pd = new PageData();
		// 重置系统开始运行时间
		PageData par = (PageData) applicati.getAttribute(Const.PAR);
		par.put("SYSTEM_START_TIME", DateUtil.getTime());
		sys_configService.edit(par);
		applicati.setAttribute(Const.PAR, par);
		// 查询所有用户
		List<PageData> allUser = accountService.listAll(pd);
		// 移除所有定时任务
		List<PageData> list = freezing_detailsService.listAll(null);
		List<PageData> matchList = smd_matchService.listAll(null);
		int i = list.size();
		int k = matchList.size();
		if (i < k) {
			i = k;
		}
		// 移除定时任务
		for (int j = 1; j <= i; j++) {
			QuartzManager.removeJob(Const.STATIC_REWARD_TASK + j);
			QuartzManager.removeJob(Const.DYNAMIC_REWARD_TASK + j);
			QuartzManager.removeJob(Const.USER_FROZEN_TASK + j);
		}
		// 删除上传凭证图片
		String fullPath = request.getServletContext().getRealPath(Const.FILEPATHIMG);
		DelAllFile.delAllFile(fullPath);
		// 调用多线程清理缓存
		ThreadManagers.getThreadPollProxy().execute(new Runnable() {
			@Override
			public void run() {
				// 清空缓存
				for (PageData var : allUser) {
					if (!"15555555555".equals(var.getString("PHONE"))) {
						applicati.removeAttribute(var.get("PHONE").toString());
					}
				}
				// 清空表
				try {
					accountService.wipeDate(null);
					income_detailsService.wipeDate(null);
					purchase_smdService.wipeDate(null);
					sell_smdService.wipeDate(null);
					accountService.resetAccount(null);
					smd_matchService.wipeDate(null);
					freezing_detailsService.wipeDate(null);
					rechargeService.wipeDate(null);
					// 重置序列
					resetSeq(pd);
					QuartzManager.shutdownJobs();
				} catch (Exception e) {
					System.out.println("----------------清空数据时出错--------------");
					e.printStackTrace();
				}
			}
		});
		return "success";
	}

	/**
	 * 功能描述：调用存储过程重置序列
	 * @author Ajie
	 * @date 2019/11/27 0027
	 */
	private void resetSeq(PageData pd) throws Exception {
		pd.put("seqName", "FT_ACCOUNT_SEQ");
		pd.put("seqStart", "10001");
		accountService.reset_seq(pd);
		pd.put("seqName", "FT_INCOME_DETAILS_SEQ");
		pd.put("seqStart", "1");
		accountService.reset_seq(pd);
		pd.put("seqName", "FT_PURCHASE_SMD_SEQ");
		pd.put("seqStart", "1");
		accountService.reset_seq(pd);
		pd.put("seqName", "FT_SELL_SMD_SEQ");
		pd.put("seqStart", "1");
		accountService.reset_seq(pd);
		pd.put("seqName", "FT_SMD_MATCH_SEQ");
		pd.put("seqStart", "1");
		accountService.reset_seq(pd);
		pd.put("seqName", "FT_FREEZING_DETAILS_SEQ");
		pd.put("seqStart", "1");
		accountService.reset_seq(pd);
	}


	
	/**参数
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"参数Sys_config");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("SYS_CONFIG_ID","1");
		pd = sys_configService.findById(pd);
		mv.setViewName("front/sys_config/sys_config_list");
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}

}
