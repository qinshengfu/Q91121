package com.fh.util.timers;

import com.fh.controller.base.BaseController;
import com.fh.service.front.AccountManager;
import com.fh.service.record.Purchase_SMDManager;
import com.fh.service.record.Smd_matchManager;
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
import java.util.Map;

/**
 * 功能描述：排单打款时间定时任务，规定时间内未打款封号处理
 *
 * @author Ajie
 * @date 2019/12/4 0004
 */
public class PayEndTime extends BaseController implements Job {

    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {
        String nowTime = DateUtil.getTime();
        System.out.println("开始排单打款时间定时任务====>>" + nowTime);

        // 获取参数
        JobDataMap dataMap = context.getJobDetail().getJobDataMap();
        Map<String, Object> parameter = (Map<String, Object>) dataMap.get("parameterList");
        String orderId = parameter.get("orderId").toString();
        System.out.println("获取到的限制打款时间订单ID参数为：" + orderId);

        // 普通类从spring容器中拿出service
        WebApplicationContext webctx = ContextLoader.getCurrentWebApplicationContext();
        // 用户表
        AccountManager accountService = (AccountManager) webctx.getBean("accountService");
        // 匹配订单记录和申购订单记录连表查询
        Smd_matchManager smdMatchService = (Smd_matchManager) webctx.getBean("smd_matchService");
        // 申购订单
        Purchase_SMDManager purchase_smdService = (Purchase_SMDManager) webctx.getBean("purchase_smdService");

        ServletContext applicati = ContextLoader.getCurrentWebApplicationContext().getServletContext();
        PageData pd;
        try {
            // 根据匹配订单ID查询数据
            pd = new PageData();
            pd.put("SMD_MATCH_ID", orderId);
            pd = smdMatchService.findById(pd);
            System.out.println("限制打款时间查询到的数据为：" + pd);
            String buyId = pd.getString("BUY_ID");
            if (null == pd) {
                return;
            }
            // 执行封号
            // 取申购订单用户手机号
            String phone = pd.getString("BUY_PHONE");
            // 1: 账号冻结 0：资金冻结 -1 正常
            pd = new PageData();
            pd.put("USER_STATE", 1);
            pd.put("PHONE", phone);
            accountService.editByPhone(pd);
            // 更新匹配订单状态 已超时 状态码为 3
            pd = new PageData();
            pd.put("ORDER_STATE", 3);
            pd.put("SMD_MATCH_ID", orderId);
            smdMatchService.edit(pd);
            // 更改申购订单状态为 已超时 状态码为 0
            pd = new PageData();
            pd.put("PAYMENT_STATE", 0);
            pd.put("PURCHASE_SMD_ID", buyId);
            purchase_smdService.edit(pd);
            // 更新缓存信息
            pd = (PageData) applicati.getAttribute(phone);
            pd.put("USER_STATE", 1);
            applicati.setAttribute(phone, pd);
            // 移除定时任务
            String name = Const.USER_FROZEN_TASK + orderId;
            QuartzManager.removeJob(name);
            System.out.println("排单限制打款时间定时任务执行完毕 用户已被封号==>>" + DateUtil.getTime());
        } catch (Exception e) {
            System.out.println("-------------排单打款时间定时任务解析异常--------------");
            e.printStackTrace();
        }
    }
}
