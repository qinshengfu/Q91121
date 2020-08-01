package com.fh.controller.record;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.record.Purchase_SMDManager;
import com.fh.util.*;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/** 
 * 说明：申购SMD
 * 创建人：Ajie
 * 创建时间：2019-11-25
 */
@Controller
@RequestMapping(value="/purchase_smd")
public class Purchase_SMDController extends BaseController {
	
	String menuUrl = "purchase_smd/list.do"; //菜单地址(权限用)
	@Resource(name="purchase_smdService")
	private Purchase_SMDManager purchase_smdService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Purchase_SMD");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PURCHASE_SMD_ID", this.get32UUID());	//主键
		pd.put("GMT_CREATE", Tools.date2Str(new Date()));	//创建时间
		pd.put("GMT_MODIFIED", Tools.date2Str(new Date()));	//更新时间
		pd.put("NUMBER", "0");	//数量
		pd.put("PHONE", "0");	//手机号
		pd.put("MODE_PAYMENT", "0");	//1:人民币、0：ETH
		pd.put("INTEREST_CYCLE", "0");	//利息周期(天数)
		pd.put("ORDER_TYPE", "0");	//预付款
		pd.put("ORDER_NUMBER", "0");	//尾款
		pd.put("PAYMENT_TIME", Tools.date2Str(new Date()));	//打款时间
		pd.put("PAYMENT_STATE", "-1");	//0表示预付款已付，1表示尾款已付、2:撤单
		pd.put("RELEASE_TIME", Tools.date2Str(new Date()));	//释放时间
		purchase_smdService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @throws Exception
	 */
	@RequestMapping(value="/delete", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String delete() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Purchase_SMD");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return "没有权限删除";} //校验权限
		PageData pd;
		pd = this.getPageData();
		pd = purchase_smdService.findByOrderIdAndType(pd);
		String state = pd.getString("PAYMENT_STATE");
		if (!"5".equals(state)) {
			return "另外一笔订单已匹配";
		}
		purchase_smdService.deleteByOrderNumbe(pd);
		return "success";
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Purchase_SMD");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		purchase_smdService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Purchase_SMD");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = purchase_smdService.list(page);	//列出Purchase_SMD列表
		mv.setViewName("record/purchase_smd/purchase_smd_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}

	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("record/purchase_smd/purchase_smd_edit");
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
		pd = purchase_smdService.findById(pd);	//根据ID读取
		mv.setViewName("record/purchase_smd/purchase_smd_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Purchase_SMD");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			purchase_smdService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Purchase_SMD到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("创建时间");	//1
		titles.add("更新时间");	//2
		titles.add("数量");	//3
		titles.add("手机号");	//4
		titles.add("1:人民币、0：ETH");	//5
		titles.add("利息周期(天数)");	//6
		titles.add("预付款");	//7
		titles.add("尾款");	//8
		titles.add("打款时间");	//9
		titles.add("0表示预付款已付，1表示尾款已付、2:撤单");	//10
		titles.add("释放时间");	//11
		dataMap.put("titles", titles);
		List<PageData> varOList = purchase_smdService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("GMT_CREATE"));	    //1
			vpd.put("var2", varOList.get(i).getString("GMT_MODIFIED"));	    //2
			vpd.put("var3", varOList.get(i).get("NUMBER").toString());	//3
			vpd.put("var4", varOList.get(i).get("PHONE").toString());	//4
			vpd.put("var5", varOList.get(i).get("MODE_PAYMENT").toString());	//5
			vpd.put("var6", varOList.get(i).get("INTEREST_CYCLE").toString());	//6
			vpd.put("var7", varOList.get(i).get("ORDER_TYPE").toString());	//7
			vpd.put("var8", varOList.get(i).get("ORDER_NUMBER").toString());	//8
			vpd.put("var9", varOList.get(i).getString("PAYMENT_TIME"));	    //9
			vpd.put("var10", varOList.get(i).get("PAYMENT_STATE").toString());	//10
			vpd.put("var11", varOList.get(i).getString("RELEASE_TIME"));	    //11
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
}
