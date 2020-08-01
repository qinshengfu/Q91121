package com.fh.controller.front;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.front.AccountManager;
import com.fh.service.record.Income_detailsManager;
import com.fh.service.record.RechargeManager;
import com.fh.util.*;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/** 
 * 说明：前台用户表
 * 创建人：Ajie
 * 创建时间：2019-11-25
 */
@Controller
@RequestMapping(value="/account")
public class AccountController extends BaseController {
	
	String menuUrl = "account/list.do"; //菜单地址(权限用)
	@Resource(name="accountService")
	private AccountManager accountService;
	// 收益明细
	@Resource(name = "income_detailsService")
	private Income_detailsManager income_detailsService;
	// 充值记录
	@Resource(name="rechargeService")
	private RechargeManager rechargeService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Account");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ACCOUNT_ID", this.get32UUID());	//主键
		pd.put("GMT_CREATE", Tools.date2Str(new Date()));	//创建时间
		pd.put("GMT_MODIFIED", Tools.date2Str(new Date()));	//更新时间
		pd.put("IS_WITHDRAW", "0");	//1 :已提现，0 :未提现。 每日0时 重置为 0
		pd.put("PHONE", "0");	//手机号
		pd.put("RECOMMENDED_NUMBER", "0");	//推荐人数
		pd.put("RECOMMENDER", "");	//推荐人
		pd.put("RE_PATH", "");	//推荐路径
		pd.put("USER_RANK", "0");	//0:普通会员、1：高级经理
		pd.put("USER_STATE", "0");	//1:账号冻结、0：资金冻结
		pd.put("REST_TIME", "0");	//不给匹配天数，如果大于0，每天-1
		pd.put("NAME", "");	//姓名
		pd.put("ALIPAY", "");	//支付宝账号
		pd.put("BANK_NAME", "");	//银行名称
		pd.put("BANK_NUMBER", "");	//银行卡号
		pd.put("BANK_ADDRESS", "");	//开户行地址
		pd.put("ETH_ADDRESS", "");	//ETH钱包地址
		accountService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Account");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		accountService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Account");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		accountService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		// 更新缓存信息
		pd = accountService.findById(pd);
		applicati.setAttribute(pd.getString("PHONE"), pd);
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Account");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = accountService.list(page);	//列出Account列表
		mv.setViewName("front/account/account_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去更改密码和状态页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goUpdateState")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("front/account/account_edit1");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = accountService.findById(pd);	//根据ID读取
		mv.setViewName("front/account/account_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Account");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			accountService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Account到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("创建时间");	//1
		titles.add("更新时间");	//2
		titles.add("静态钱包余额");	//3
		titles.add("动态钱包余额");	//4
		titles.add("算力余额");	//5
		titles.add("入场券余额");	//6
		titles.add("1 :已提现，0 :未提现。 每日0时 重置为 0");	//7
		titles.add("手机号");	//8
		titles.add("登录密码");	//9
		titles.add("交易密码");	//10
		titles.add("推荐人数");	//11
		titles.add("推荐人");	//12
		titles.add("推荐路径");	//13
		titles.add("0:普通会员、1：高级经理");	//14
		titles.add("1:账号冻结、0：资金冻结");	//15
		titles.add("不给匹配天数，如果大于0，每天-1");	//16
		titles.add("姓名");	//17
		titles.add("支付宝账号");	//18
		titles.add("银行名称");	//19
		titles.add("银行卡号");	//20
		titles.add("开户行地址");	//21
		titles.add("ETH钱包地址");	//22
		dataMap.put("titles", titles);
		List<PageData> varOList = accountService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("GMT_CREATE"));	    //1
			vpd.put("var2", varOList.get(i).getString("GMT_MODIFIED"));	    //2
			vpd.put("var3", varOList.get(i).get("STATIC_WALLET").toString());	//3
			vpd.put("var4", varOList.get(i).get("DYNAMIC_WALLET").toString());	//4
			vpd.put("var5", varOList.get(i).get("COUNT_BALANCE").toString());	//5
			vpd.put("var6", varOList.get(i).get("TICKET").toString());	//6
			vpd.put("var7", varOList.get(i).get("IS_WITHDRAW").toString());	//7
			vpd.put("var8", varOList.get(i).get("PHONE").toString());	//8
			vpd.put("var9", varOList.get(i).getString("LOGIN_PASSWORD"));	    //9
			vpd.put("var10", varOList.get(i).getString("TRANSACTION_PASSWORD"));	    //10
			vpd.put("var11", varOList.get(i).get("RECOMMENDED_NUMBER").toString());	//11
			vpd.put("var12", varOList.get(i).getString("RECOMMENDER"));	    //12
			vpd.put("var13", varOList.get(i).getString("RE_PATH"));	    //13
			vpd.put("var14", varOList.get(i).get("USER_RANK").toString());	//14
			vpd.put("var15", varOList.get(i).get("USER_STATE").toString());	//15
			vpd.put("var16", varOList.get(i).get("REST_TIME").toString());	//16
			vpd.put("var17", varOList.get(i).getString("NAME"));	    //17
			vpd.put("var18", varOList.get(i).getString("ALIPAY"));	    //18
			vpd.put("var19", varOList.get(i).getString("BANK_NAME"));	    //19
			vpd.put("var20", varOList.get(i).getString("BANK_NUMBER"));	    //20
			vpd.put("var21", varOList.get(i).getString("BANK_ADDRESS"));	    //21
			vpd.put("var22", varOList.get(i).getString("ETH_ADDRESS"));	    //22
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}

	/**
	 * 功能描述： 访问【充值页面】
	 * @author Ajie
	 * @date 2019/12/7 0007
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/toRecharge")
	private ModelAndView toRecharge() {
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("front/account/Recharge");
		return mv;
	}

	/**
	 * 功能描述：后台充值
	 * @author Ajie
	 * @date 2019/12/7 0007
	 * @param record 充值信息 0：币种、1：账号、2:数额、3:备注
	 * @return
	 */
	@RequestMapping(value = "/addMoney", produces = "text/html;charset=UTF-8")
	@ResponseBody
	private String addMoney(@RequestParam(name = "record") String [] record) throws Exception {
		logBefore(logger, Jurisdiction.getUsername()+"充值币种");
		// 校验权限
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return "没有修改权限";}
		// 验证会员账号是否存在
		PageData pd = new PageData();
		pd.put("PHONE", record[1]);
		pd = accountService.findByPhone(pd);
		if (null == pd) {
			return record[1] + "用户未注册";
		}
		double amount = Double.parseDouble(pd.get(record[0]).toString());
		// 执行币种增加
		pd = new PageData();
		double money = Double.parseDouble(record[2]);
		pd.put(record[0],record[0]);
		pd.put("money", money);
		pd.put("PHONE", record[1]);
		accountService.addMoneyAmount(pd);
		// 创建收益记录
        String type = getTpye(record[0]);
		pd.put("GMT_CREATE", DateUtil.getTime());
		pd.put("GMT_MODIFIED", "");
		pd.put("BONUS_TYPE", type);
		pd.put("PHONE", record[1]);
		pd.put("MONEY", money);
		// 来源
		pd.put("SOURCE", record[3]);
		if (amount > 0) {
			pd.put("TAG","+");
		} else {
			pd.put("TAG","");
		}
		pd.put("INCOME_DETAILS_ID", "");
		income_detailsService.save(pd);
		// 更新缓存
		pd = accountService.findByPhone(pd);
		applicati.setAttribute(record[1], pd);
		amount += money;
		// 创建充值记录
		pd.put("GMT_CREATE", DateUtil.getTime());
		pd.put("GMT_MODIFIED", "");
		pd.put("PHONE", record[1]);
		pd.put("MONEY", money);
		pd.put("TYPE", type);
        pd.put("REMARKS", record[3]);
        pd.put("AMOUNT_AFTER", amount);
		pd.put("RECHARGE_ID", this.get32UUID());
		rechargeService.save(pd);
		return "success";
	}

	/**
	 * 功能描述：设置用户为高级经理
	 * @author Ajie
	 * @date 2019/12/7 0007
	 */
	@RequestMapping(value = "/setSeniorManager")
    @ResponseBody
	private String setSeniorManager() throws Exception {
		PageData pd = this.getPageData();
		accountService.setSenior(pd);
		return "success";
	}

	/**
	 * 功能描述：获取用户充值币种类型
	 * @author Ajie
	 * @date 2019/12/7 0007
	 */
	private String getTpye(String type) {
	    String resule = "";
	    if ("DYNAMIC_WALLET".equals(type)) {
            resule = "动态钱包";
        }
        if ("STATIC_WALLET".equals(type)) {
            resule = "静态钱包";
        }
        if ("COUNT_BALANCE".equals(type)) {
            resule = "算力账户";
        }
        if ("TICKET".equals(type)) {
            resule = "入场卷";
        }
	    return resule;
    }

    /**
     * 功能描述：更新用户状态和密码
     * @author Ajie
     * @date 2019/12/9 0009
     * @return 处理结果
     */
    @RequestMapping(value = "/upStateAndPassword", produces = "text/html;charset=UTF-8")
    private ModelAndView upStateAndPassword() throws Exception {
		ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	String phone = pd.getString("PHONE");
    	Object userState = pd.get("USER_STATE");
		String login =pd.getString("LOGIN_PASSWORD");
		String transac = pd.getString("TRANSACTION_PASSWORD");
		pd = new PageData();
		// 二次加密
    	if (Tools.notEmpty(login)) {
    		login = StringUtil.applySha256(login);
			pd.put("LOGIN_PASSWORD", login);
		}
		// 二次加密
		if (Tools.notEmpty(transac)) {
			transac = StringUtil.applySha256(transac);
			pd.put("TRANSACTION_PASSWORD", transac);
		}
		pd.put("PHONE", phone);
		pd.put("USER_STATE", userState);
		accountService.edit1(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		// 更新缓存
		pd = accountService.findByPhone(pd);
		applicati.setAttribute(pd.getString("PHONE"), pd);
		return mv;
	}

	/**
	 * 功能描述：访问前台【我的团队】页面
	 *
	 * @author Ajie
	 * @date 2019/11/26 0026
	 */
	@RequestMapping(value = "toTeamChart")
	private ModelAndView toTeam() throws Exception {
		ModelAndView mv = getModelAndView();
		PageData pd = new PageData();
		pd.put("ACCOUNT_ID", "10000");
		PageData user = accountService.findById(pd);
		// 根据用户ID查所有下级
		List<PageData> userList = accountService.recommendationMap(pd);
		// 查直推人数
		pd = accountService.getReCount(pd);
		mv.setViewName("front/account/chart");
		mv.addObject("userList", userList);
		mv.addObject("user", user);
		return mv;
	}

}
