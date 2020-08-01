package com.fh.util.timers;

import com.fh.service.record.Freezing_detailsManager;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.PageData;
import com.fh.util.QuartzManager;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimerTask;

/**
 * 说明：启动系统时，添加静态奖励定时任务
 * 创建人：Ajie
 * 创建时间：2019-12-04 12:07:57
 */
public class AddStaticTask extends TimerTask {

    @Override
    public void run() {
        try {
            //在这里写你要执行的内容
            System.out.println("--------------->>添加静态奖励释放定时任务");

            // 普通类从spring容器中拿出service
            ConfigurableApplicationContext context = new ClassPathXmlApplicationContext(new String[]{
                    "classpath:spring/ApplicationContext-dataSource.xml",
                    "classpath:spring/ApplicationContext-main.xml",
                    "classpath:spring/ApplicationContext-redis.xml"});
            // 冻结待释放表
            Freezing_detailsManager freezingDetailsService = (Freezing_detailsManager) context.getBean("freezing_detailsService");

            // 需要释放本金和利息的的列表
            List<PageData> list = freezingDetailsService.listByTime(null);

            // 就不用添加定时任务
            if (list == null || list.size() <= 0) {
                System.out.println("---------没有找到符合条件的定时任务--------");
                return;
            }
            // 循环添加到定时任务中
            String id;
            String name;
            // 定义释放时间、奖金类型
            String releaseTime;
            String type;
            int i = 0;
            for (PageData map : list) {
                // 获取奖金类型
                type = map.getString("TYPE");
                // 如果是动态奖 直接进入下一条
                if ("2".equals(type)) {
                    continue;
                }
                // 获取释放时间
                releaseTime = map.getString("RELEASE_TIME");
                id = map.get("FREEZING_DETAILS_ID").toString();
                name = Const.DYNAMIC_REWARD_TASK + id;
                releaseTime = DateUtil.getCron(releaseTime);
                // 设置参数
                Map<String, Object> parameter = new HashMap<String, Object>();
                parameter.put("orderId", id);
                QuartzManager.addJob(name, StaticBonusRelease.class, releaseTime, parameter);
                i++;
            }
            System.out.println("静态奖励释放定时任务添加完毕共"+ i +"个任务");
            context.close();
        } catch (Exception e) {
            System.out.println("-------------解析信息发生异常--------------");
            e.printStackTrace();
        }
    }
}
