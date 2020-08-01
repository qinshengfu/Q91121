package com.fh.util.express;

import com.fh.service.fhoa.impl.FhfileService;
import com.fh.service.front.AccountManager;
import com.fh.service.front.Sys_configManager;
import com.fh.service.front.impl.AccountService;
import com.fh.service.front.impl.Sys_configService;
import com.fh.service.record.Sys_chartManager;
import com.fh.service.record.Sys_newsManager;
import com.fh.service.record.impl.Sys_chartService;
import com.fh.service.record.impl.Sys_newsService;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.Logger;
import com.fh.util.PageData;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.ContextLoader;

import javax.servlet.ServletContext;
import java.util.List;
import java.util.TimerTask;

/**
 * 定时任务操作主体
 *
 * @author liming
 */
public class DailyDataTimerTask extends TimerTask {

    private static Logger log = Logger.getLogger(DailyDataTimerTask.class);


    @Override
    public void run() {
        try {
            //在这里写你要执行的内容
            System.out.println("执行时间：//" + DateUtil.getTime().toString());
            ServletContext applicati = ContextLoader.getCurrentWebApplicationContext().getServletContext();
            ApplicationContext context = new ClassPathXmlApplicationContext(new String[]{
                    "classpath:spring/ApplicationContext-dataSource.xml",
                    "classpath:spring/ApplicationContext-main.xml",
                    "classpath:spring/ApplicationContext-redis.xml"});
            FhfileService fhfileService = context.getBean("fhfileService", FhfileService.class);

            AccountManager accountService = context.getBean("accountService", AccountService.class);
            Sys_chartManager sys_chartService = context.getBean("sys_chartService", Sys_chartService.class);
            Sys_newsManager sys_newsService = context.getBean("sys_newsService", Sys_newsService.class);
            Sys_configManager sys_configService = context.getBean("sys_configService", Sys_configService.class);


            PageData par = new PageData();
            // 赋值ID 查询参数表信息
            par.put("SYS_CONFIG_ID", "1");
			// 系统启动时间
			par.put("SYSTEM_START_TIME", DateUtil.getTime());
			sys_configService.edit(par);
            par = sys_configService.findById(par);

            // 用户列表
            List<PageData> userList = accountService.listAll(null);
            // 前台轮播图
            List<PageData> chartList = sys_chartService.listAll(null);
            // 前台新闻公告
            List<PageData> newsList = sys_newsService.listAll(null);

            System.out.println(userList);
            List<PageData> lbt = fhfileService.listAll(null);


            // 存到缓存中
            applicati.setAttribute(Const.PAR, par); // 参数配置
            applicati.setAttribute(Const.APP_NEWS, newsList);
            applicati.setAttribute(Const.APP_CHART, chartList);
            applicati.setAttribute(Const.APP_USER, userList);


            applicati.setAttribute("lbt", lbt);// 后台轮播图

            // 用户手机号当作键 单独存缓存中
            for (PageData map : userList) {
                applicati.setAttribute(map.getString("PHONE"), map);
            }

            ((ConfigurableApplicationContext) context).close();
        } catch (Exception e) {
            log.info("-------------解析信息发生异常--------------");
            e.printStackTrace();
        }
    }


}

