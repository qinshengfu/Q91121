package com.fh.util.express;

import com.fh.util.QuartzManager;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 定时任务监听器
 * 
 * @author liming
 *
 */
 
public class DailyDataTaskListener implements ServletContextListener {
 
	@Override
	public void contextInitialized(ServletContextEvent event) {
		new TimerManager();
		//new DailyDataTimerTask();//启动执行
	}
 
	@Override
	public void contextDestroyed(ServletContextEvent event) {
		// 关闭所有quartz定时任务
		QuartzManager.shutdownJobs();
		// 关闭线程池
		ThreadManagers.shutDown();
	}
 
}
