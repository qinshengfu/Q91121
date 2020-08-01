package com.fh.util.timers;

import com.fh.controller.base.BaseController;
import com.fh.service.front.AccountManager;
import com.fh.service.record.Freezing_detailsManager;
import com.fh.service.record.Income_detailsManager;
import com.fh.service.record.Purchase_SMDManager;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.PageData;
import com.fh.util.QuartzManager;
import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.ServletContext;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 功能描述：动态奖金释放，执行后自动移除定时任务
 *
 * @author Ajie
 * @date 2019/12/4 0004
 */
public class DynamicBonusRelease extends BaseController implements Job {

    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {
        String nowTime = DateUtil.getTime();
        System.out.println("开始执行动态奖的释放====>>" + nowTime);

        // 获取参数
        JobDataMap dataMap = context.getJobDetail().getJobDataMap();
        Map<String, Object> parameter = (Map<String, Object>) dataMap.get("parameterList");
        String orderId = parameter.get("orderId").toString();
        System.out.println("获取到的订单ID参数为：" + orderId);

        // 普通类从spring容器中拿出service
        WebApplicationContext webctx = ContextLoader.getCurrentWebApplicationContext();
        // 用户表
        AccountManager accountService = (AccountManager) webctx.getBean("accountService");
        // 冻结记录表
        Freezing_detailsManager freezingDetailsService = (Freezing_detailsManager) webctx.getBean("freezing_detailsService");
        // 冻结记录表
        Purchase_SMDManager purchase_smdService = (Purchase_SMDManager) webctx.getBean("purchase_smdService");

        ServletContext applicati = ContextLoader.getCurrentWebApplicationContext().getServletContext();
        PageData pd;
        List<PageData> list = new ArrayList<PageData>(16);
        try {
            // 查询根据ID查询冻结明细记录
            pd = new PageData();
            pd.put("FREEZING_DETAILS_ID", orderId);
            pd = freezingDetailsService.findById(pd);
            // 根据订单号 查询预付款和尾款记录
            list = purchase_smdService.listByOrderNumber(pd);
            // 取来源手机号，为了确认是那个用户产生的
            String sourcePhone = list.get(0).getString("PHONE");
            PageData finalPd = pd;
            System.out.println("查询到的 数据为：" + finalPd);
            if (null == pd) {
                return;
            }
            // 执行奖金发放
            double money;
            String phone;
            money = Double.parseDouble(pd.get("MONEY").toString());
            phone = pd.getString("PHONE");
            // 给用户加钱
            pd.put("GMT_MODIFIED", nowTime);
            pd.put("money", money);
            pd.put("PHONE", phone);
            // 0:静态钱包 1 动态钱包
            pd.put("type", 1);
            accountService.addMoney(pd);
            // 更新缓存信息
            pd = accountService.findByPhone(pd);
            applicati.setAttribute(phone, pd);
            // 更改冻结记录状态为 已完成
            pd = new PageData();
            pd.put("FREEZING_DETAILS_ID", orderId);
            pd.put("STATE", 1);
            freezingDetailsService.edit(pd);
            // 创建收益明细并移除定时任务
            addIncomeRecord(finalPd, money, nowTime, sourcePhone);
            System.out.println("动态奖释放执行完毕==>>" + DateUtil.getTime());
        } catch (Exception e) {
            System.out.println("-------------奖金发放异常--------------");
            e.printStackTrace();
        }
    }

    /**
     * 功能描述：创建收益记录并移除定时任务，更改冻结记录状态为 已完成
     *
     * @param rec         冻结记录的订单
     * @param money       本次获的钱
     * @param time        日期
     * @param sourcePhone 来源手机号
     * @author Ajie
     * @date 2019/12/4 0004
     */
    private void addIncomeRecord(PageData rec, double money, String time, String sourcePhone) throws Exception {
        // 普通类从spring容器中拿出service
        WebApplicationContext webctx = ContextLoader.getCurrentWebApplicationContext();
        // 收益明细
        Income_detailsManager incomeDetailsService = (Income_detailsManager) webctx.getBean("income_detailsService");
        PageData pd = new PageData();
        pd.put("GMT_CREATE", time);
        pd.put("GMT_MODIFIED", "");
        pd.put("BONUS_TYPE", "动态奖金");
        pd.put("PHONE", rec.getString("PHONE"));
        pd.put("MONEY", money);
        // 来源
        pd.put("SOURCE", sourcePhone);
        pd.put("TAG", "+");
        pd.put("INCOME_DETAILS_ID", "");
        incomeDetailsService.save(pd);
        // 移除定时任务
        String id = rec.get("FREEZING_DETAILS_ID").toString();
        String name = Const.DYNAMIC_REWARD_TASK;
        name += id;
        QuartzManager.removeJob(name);
    }
}
