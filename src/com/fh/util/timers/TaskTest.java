package com.fh.util.timers;

import com.fh.service.front.AccountManager;
import com.fh.service.record.Freezing_detailsManager;
import com.fh.service.record.Income_detailsManager;
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

import java.util.Map;

/**
 * 功能描述：定时任务测试，获取参数，执行后自动移除定时任务
 *
 * @author Ajie
 * @date 2019/12/4 0004
 */
public class TaskTest implements Job {

    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {
        String nowTime = DateUtil.getTime();
        System.out.println("开始执行=========>>" + nowTime);
        // 获取参数
        JobDataMap dataMap = context.getJobDetail().getJobDataMap();
        Map<String,Object> parameter = (Map<String,Object>)dataMap.get("parameterList");
        String orderId = parameter.get("buyId").toString();
        System.out.println("获取到的参数为：" + orderId);

        // 普通类从spring容器中拿出service
        WebApplicationContext webctx = ContextLoader.getCurrentWebApplicationContext();
        // 用户表
        AccountManager accountService = (AccountManager) webctx.getBean("accountService");
        // 冻结记录表
        Freezing_detailsManager freezingDetailsService = (Freezing_detailsManager) webctx.getBean("freezing_detailsService");

//        ServletContext applicati = ContextLoader.getCurrentWebApplicationContext().getServletContext();
        PageData pd;
        try {
            // 查询根据ID查询冻结明细记录
            pd = new PageData();
            pd.put("FREEZING_DETAILS_ID", orderId);
            pd = freezingDetailsService.findById(pd);
            System.out.println("查询到的 数据为：" + pd);
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
            pd.put("type", 0);
            accountService.addMoney(pd);
            // 更新缓存信息
//            pd = accountService.findByPhone(pd);
//            applicati.setAttribute(phone, pd);
            // 创建收益明细并移除定时任务
            addIncomeRecord(pd, money, nowTime);
            System.out.println("静态奖的本金+利息发放执行完毕==>>" + DateUtil.getTime());
        } catch (Exception e) {
            System.out.println("-------------静态奖的本金+利息发放异常--------------");
            e.printStackTrace();
        }
    }

    /**
     * 功能描述：创建收益记录并移除定时任务
     *
     * @param rec   冻结记录的订单
     * @param money 本次获的钱
     * @param time  日期
     * @author Ajie
     * @date 2019/12/4 0004
     */
    private void addIncomeRecord(PageData rec, double money, String time) throws Exception {
        // 普通类从spring容器中拿出service
        WebApplicationContext webctx = ContextLoader.getCurrentWebApplicationContext();
        // 收益明细
        Income_detailsManager incomeDetailsService = (Income_detailsManager) webctx.getBean("income_detailsService");
        PageData pd = new PageData();
        pd.put("GMT_CREATE", time);
        pd.put("GMT_MODIFIED", "");
        if ("0".equals(rec.getString("TYPE"))) {
            pd.put("BONUS_TYPE", "本金");
        }
        if ("1".equals(rec.getString("TYPE"))) {
            pd.put("BONUS_TYPE", "利息");
        }
        pd.put("PHONE", rec.getString("PHONE"));
        pd.put("MONEY", money);
        // 1:已完成 0:冻结中
        pd.put("STATE", "1");
        pd.put("INCOME_DETAILS_ID", "");
        incomeDetailsService.save(pd);
        // 移除定时任务
        String id = rec.get("FREEZING_DETAILS_ID").toString();
        String name = Const.STATIC_REWARD_TASK + id;
        QuartzManager.removeJob(name);
        System.out.println("==============》定时任务移除完毕");
    }
}
