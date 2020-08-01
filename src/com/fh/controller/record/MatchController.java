package com.fh.controller.record;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.record.Purchase_SMDManager;
import com.fh.service.record.Sell_SMDManager;
import com.fh.service.record.Smd_matchManager;
import com.fh.util.*;
import com.fh.util.express.ThreadManagers;
import com.fh.util.timers.PayEndTime;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 说明：匹配管理
 * 创建人：Ajie
 * 创建时间：2019年11月29日09:23:30
 */
@Controller
@RequestMapping(value = "/match")
public class MatchController extends BaseController {
    // 菜单地址(权限用)
    String menuUrl = "match/list.do";
    // 申购SMD
    @Resource(name = "purchase_smdService")
    private Purchase_SMDManager purchase_smdService;
    // 赎回SMD
    @Resource(name = "sell_smdService")
    private Sell_SMDManager sell_smdService;
    // 匹配订单记录
    @Resource(name="smd_matchService")
    private Smd_matchManager smd_matchService;

    /**
     * 预付款匹配列表
     *
     * @param page
     * @throws Exception
     */
    @RequestMapping(value = "/downPaymentsList")
    public ModelAndView downPaymentsList(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String keywords = pd.getString("keywords");                //关键词检索条件
        if (null != keywords && !"".equals(keywords)) {
            pd.put("keywords", keywords.trim());
        }
        // 查找余额大于0的 预付款
        pd.put("ORDER_TYPE", 1);
        page.setPd(pd);
        // 列出预付款列表
        List<PageData> buyList = purchase_smdService.downPaymentsList(page);
        // 列出出售列表
        List<PageData> sellList = sell_smdService.list1(page);
        // 统计所有未匹配总额
        double buyCount = Double.parseDouble(purchase_smdService.getUnmatchCount().get("COUNT").toString());
        double sellCount = Double.parseDouble(sell_smdService.getUnmatchCount().get("COUNT").toString());
        // 统计预付款未匹配总额 1：预付款 2：尾款
        pd.put("ORDER_TYPE", 1);
        double buyCount1 = Double.parseDouble(purchase_smdService.getUnmatchCount1(pd).get("COUNT").toString());
        mv.setViewName("record/match/downPay");
        mv.addObject("buyList", buyList);
        mv.addObject("sellList", sellList);
        mv.addObject("buyCount", buyCount);
        mv.addObject("buyCount1", buyCount1);
        mv.addObject("sellCount", sellCount);
        mv.addObject("pd", pd);
        mv.addObject("QX", Jurisdiction.getHC());    //按钮权限
        return mv;
    }

    /**
     * 尾款匹配列表
     *
     * @param page
     * @throws Exception
     */
    @RequestMapping(value = "/tailMoneyList")
    public ModelAndView tailMoneyList(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String keywords = pd.getString("keywords");                //关键词检索条件
        if (null != keywords && !"".equals(keywords)) {
            pd.put("keywords", keywords.trim());
        }
        // 查找余额大于0的 查找尾款
        pd.put("ORDER_TYPE", 2);
        page.setPd(pd);
        // 列出尾款款列表
        List<PageData> buyList = purchase_smdService.downPaymentsList(page);
        //列出出售列表
        List<PageData> sellList = sell_smdService.list1(page);
        // 统计所有未匹配总额
        double buyCount = Double.parseDouble(purchase_smdService.getUnmatchCount().get("COUNT").toString());
        double sellCount = Double.parseDouble(sell_smdService.getUnmatchCount().get("COUNT").toString());
        // 统计预尾款未匹配总额 1：预付款 2：尾款
        pd.put("ORDER_TYPE", 2);
        double buyCount1 = Double.parseDouble(purchase_smdService.getUnmatchCount1(pd).get("COUNT").toString());
        mv.setViewName("record/match/tailMoney");
        mv.addObject("buyList", buyList);
        mv.addObject("sellList", sellList);
        mv.addObject("buyCount", buyCount);
        mv.addObject("buyCount1", buyCount1);
        mv.addObject("sellCount", sellCount);
        mv.addObject("pd", pd);
        mv.addObject("QX", Jurisdiction.getHC());    //按钮权限
        return mv;
    }


    /**
     * 列表
     *
     * @param page
     * @throws Exception
     */
    @RequestMapping(value = "/list")
    public ModelAndView list(Page page) throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "列表Purchase_SMD");
        //if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String keywords = pd.getString("keywords");                //关键词检索条件
        if (null != keywords && !"".equals(keywords)) {
            pd.put("keywords", keywords.trim());
        }
        page.setPd(pd);
        List<PageData> buyList = purchase_smdService.list(page);    //列出Purchase_SMD列表
        mv.setViewName("record/smd_match/smd_match_list");
        mv.addObject("buyList", buyList);
        mv.addObject("pd", pd);
        mv.addObject("QX", Jurisdiction.getHC());    //按钮权限
        return mv;
    }

    /**
     * 功能描述：请求匹配订单，参数校验
     *
     * @author Ajie
     * @date 2019/11/30 0030
     */
    @RequestMapping(value = "/startMatch", produces = "text/html;charset=UTF-8")
    @ResponseBody
    private String startMatchChecking() throws Exception {
        PageData pd = new PageData();
        pd = this.getPageData();
        // 获取左边列表ID、右边列表ID，以【，】号分割
        String left = pd.getString("Left");
        String rifht = pd.getString("Right");
        double money = Double.parseDouble(pd.getString("Money"));
        if (Tools.isEmpty(left)) {
            return "未选择进场列表的任何数据";
        }
        if (Tools.isEmpty(rifht)) {
            return "未选择出场列表的任何数据";
        }
        // 根据id获取余额大于0的申购、赎回列表
        pd.put("PURCHASE_SMD_ID", left);
        List<PageData> buyList = purchase_smdService.listById(pd);
        // 判断 预付款还是尾款 1：预付款 0：尾款
        String tag = pd.getString("tag");
        PageData order = new PageData();
        if ("0".equals(tag)){
            // 判断预付款是否匹配了
            for (PageData map : buyList) {
                // 根据订单号查预付款 1:预付款，2：尾款
                String orderNumber =  map.getString("ORDER_NUMBER");
                pd.put("ORDER_NUMBER", orderNumber);
                pd.put("ORDER_TYPE", 1);
                order = purchase_smdService.findByOrderIdAndType(pd);
                // 如果预付款处于等待匹配的
                if ("5".equals(order.getString("PAYMENT_STATE"))) {
                    return "订单号"+ orderNumber +"的预付款未匹配";
                }
            }
        }
        pd.put("SELL_SMD_ID", rifht);
        List<PageData> sellList = sell_smdService.listById(pd);
        // 校验订单 接收和支付类型
        for (PageData i : buyList) {
            boolean lock = false;
            boolean locks = false;
            String buyOrder = "";
            String sellOrder = "";
            buyOrder = i.getString("ORDER_NUMBER");
            for (PageData j : sellList) {
                sellOrder = j.getString("ORDER_NUMBER");
                String modePayment = i.get("MODE_PAYMENT").toString();
                String receiveType = j.get("RECEIVE_TYPE").toString();
                String buyPhone = i.getString("PHONE");
                String sellPhone = j.getString("PHONE");
                // 如果其中一条订单的收款类型和打款类型不相等 就返回
                if (!modePayment.equals(receiveType)){
                    lock = true;
                    break;
                }
                // 如果其中一条订单的用户手机号一致就 返回
                if (buyPhone.equals(sellOrder)){
                    locks = true;
                    break;
                }
            }
            if (lock){
                return "入场订单【" + buyOrder +"】跟出场订单【"+sellOrder+"】的收款类型不一致";
            }
            if (locks){
                return "入场订单【" + buyOrder +"】跟出场订单【"+sellOrder+"】的用户为同一人";
            }
        }

        // 调用多线程，进行匹配交易
        ThreadManagers.getThreadPollProxy().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    startMatch(buyList, sellList, money);
                } catch (Exception e) {
                    System.out.println("===============》多线程执行匹配交易失败");
                    e.printStackTrace();
                }
            }
        });

        return "success";
    }

    /**
     * 功能描述：手动匹配开始
     *
     * @param buyList  申购列表
     * @param sellList 赎回（提现）列表
     * @param money  匹配总金额
     * @author Ajie
     * @date 2019/11/30 0030
     */
    private void startMatch( List<PageData> buyList, List<PageData> sellList, double money) throws Exception {
        PageData pd = new PageData();
        // 定义申购订单、赎回订单余额
        double buyBalance = 0;
        double sellBalance = 0;
        // 定义用户手机号
        String buyPhone;
        String sellPhone;
        // 定义下标
        int i = 0;
        int j = 0;
        // 循环匹配
        while (i < buyList.size() && j < sellList.size()) {
            // 不能跟自己匹配
            buyPhone = buyList.get(i).getString("PHONE");
            sellPhone = sellList.get(j).getString("PHONE");
            if (buyPhone.equals(sellPhone)){
                // 跟下一条订单匹配
                if (sellList.size() < j) {
                    j++;
                    sellBalance = 0;
                    continue;
                } else {
                    j = i;
                    sellBalance = 0;
                    i++;
                    continue;
                }
            }
            // 打款方式和收款方式匹配   1:人民币、0：ETH
            int modePayment = Integer.parseInt(buyList.get(i).get("MODE_PAYMENT").toString());
            int receiveType = Integer.parseInt(sellList.get(j).get("RECEIVE_TYPE").toString());
            if (modePayment != receiveType){
                j++;
                continue;
            }
            // 取申购、赎回订单余额
            if (buyBalance <= 0) {
                buyBalance = Double.parseDouble(buyList.get(i).get("BALANCE").toString());
            }
            if (sellBalance <= 0) {
                sellBalance = Double.parseDouble(sellList.get(j).get("BALANCE").toString());
            }
            if (buyBalance <= 0) {
                i++;
                continue;
            }
            if (sellBalance <= 0) {
                j++;
                continue;
            }
            if (money <= 0 ) {
                break;
            }
            if (buyBalance >= sellBalance && buyBalance >= money) {
                // 以匹配总额创建匹配订单
                addMatchOrder(buyList.get(i), sellList.get(j), money);
                // 更新订单余额
                buyBalance -= money;
                sellBalance -= money;
                // 减匹配总额
                money -= money;
                // 继续循环
                j++;
                continue;
            }
            if (sellBalance >= buyBalance && sellBalance >= money) {
                // 以申购金额创建匹配订单
                addMatchOrder(buyList.get(i), sellList.get(j), buyBalance);
                // 减匹配总额
                money -= buyBalance;
                // 更新订单余额
                sellBalance -= buyBalance;
                buyBalance -= buyBalance;
                // 继续循环
                i++;
                continue;
            }
            if (buyBalance >= sellBalance && sellBalance < money) {
                // 以赎回订单金额创建订单
                addMatchOrder(buyList.get(i), sellList.get(j), sellBalance);
                // 减匹配总额
                money -= sellBalance;
                // 更新订单金额
                buyBalance -= sellBalance;
                sellBalance = 0;
                j++;
                continue;
            }
            if (sellBalance >= buyBalance && buyBalance < money) {
                // 以赎回订单金额创建订单
                addMatchOrder(buyList.get(i), sellList.get(j), buyBalance);
                // 减匹配总额
                money -= buyBalance;
                // 更新订单金额
                sellBalance -= buyBalance;
                buyBalance = 0;
                i++;
            }
        }
    }

    /**
     * 功能描述：创建匹配订单记录
     *
     * @param buy   申购订单
     * @param sell  赎回订单
     * @param money 匹配金额
     * @author Ajie
     * @date 2019/12/2 0002
     */
    private void addMatchOrder(PageData buy, PageData sell, double money) throws Exception {
        System.out.println("申购订单信息："+buy);
        System.out.println("赎回订单信息："+sell);
        System.out.println("匹配金额："+money);
        PageData pd = new PageData();
        String time = DateUtil.getTime();
        pd.put("GMT_CREATE", time);
        pd.put("GMT_MODIFIED", time);
        pd.put("NUMBER", money);
        pd.put("BUY_ORDER", buy.getString("ORDER_NUMBER"));
        pd.put("SELL_ORDER", sell.getString("ORDER_NUMBER"));
        pd.put("ORDER_STATE", 0);
        pd.put("TRANSACTION_ORDER", getOrderNumber());
        pd.put("BUY_PHONE",buy.getString("PHONE"));
        pd.put("SELL_PHONE",sell.getString("PHONE"));
        pd.put("PIC_PATH", "");
        pd.put("BUY_ID", buy.get("PURCHASE_SMD_ID"));
        pd.put("SELL_ID", sell.get("SELL_SMD_ID"));
        pd.put("SMD_MATCH_ID", "");
        smd_matchService.save(pd);
        // 创建完匹配记录 马上获取订单ID
        pd = smd_matchService.getMaxOrderId(pd);
        String id = pd.get("MAX_ID").toString();
        // 更新订单状态和扣除匹配金额
        pd = new PageData();
        // 申购订单 状态为 待付款
        double balance = Double.parseDouble(buy.get("BALANCE").toString());
        balance -= money;
        pd.put("GMT_MODIFIED", time);
        pd.put("PAYMENT_STATE", 3);
        pd.put("BALANCE", balance);
        pd.put("PURCHASE_SMD_ID", buy.get("PURCHASE_SMD_ID"));
        purchase_smdService.edit(pd);
        pd = new PageData();
        // 赎回订单改为： 已匹配
        sell = sell_smdService.findById(sell);
        balance = Double.parseDouble(sell.get("BALANCE").toString());
        balance -= money;
        pd.put("GMT_MODIFIED", time);
        pd.put("RECEIVE_STATE", 1);
        pd.put("BALANCE", balance);
        pd.put("SELL_SMD_ID", sell.get("SELL_SMD_ID"));
        sell_smdService.edit(pd);
        // 创建打款时间定时任务，过期自动封号
        PageData par = (PageData) applicati.getAttribute(Const.PAR);
        // 根据系统参数 获取打款限制时间 并转为cron表达式
        String hours = par.getString("PAYMENT_TIME");
        String payEndTime = DateUtil.getAddHourDate(time, hours);
        String name = Const.USER_FROZEN_TASK;
        name += id;
        payEndTime = DateUtil.getCron(payEndTime);
        // 设置参数
        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("orderId", id);
        QuartzManager.addJob(name, PayEndTime.class, payEndTime, parameter);
    }

    /**
     * 功能描述：生成订单号
     * @author Ajie
     * @date 2019/12/2 0002
     */
    private String getOrderNumber() throws Exception {
        // 创建字符串缓冲区
        StringBuffer sb = new StringBuffer();
        // 获取时间戳
        sb.append(System.currentTimeMillis() / 1000);
        PageData pd = new PageData();
        pd = smd_matchService.getMaxOrderId(pd);
        int maxId = 1;
        if (pd != null) {
            maxId = Integer.parseInt(pd.get("MAX_ID").toString());
        }
        sb.append(maxId);
        return sb.toString();
    }


}
