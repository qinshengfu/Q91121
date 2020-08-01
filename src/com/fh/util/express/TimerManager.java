package com.fh.util.express;

import com.fh.util.timers.AddDynamicTask;
import com.fh.util.timers.AddStaticTask;
import org.springframework.web.context.ContextLoader;

import javax.servlet.ServletContext;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;


/**
 * 定时任务时间控制
 * 
 * @author liming
 *
 */
public class TimerManager {
 
	// 时间间隔一天  刷新一次
	private static final long PERIOD_DAY =  24 * 60 * 60 * 1000;
	// 时间间隔5分钟  刷新一次
	private static final long PERIOD_MIN =  5 * 60 * 1000;
	// 时间间隔 2小时 刷新一次
	private static final long PERIOD_HOUR = 2 * 60 * 60 * 1000;

	private static ServletContext sContext=ContextLoader.getCurrentWebApplicationContext().getServletContext();
 
	public TimerManager() {
		Calendar calendar = Calendar.getInstance();

		Calendar calendar1 = Calendar.getInstance();
 
		Date date = calendar.getTime(); //执行定时任务的时间
		// 在启动服务器时如果第一次执行定时任务的时间小于当前的时间任务会立即执行。
		// 因此为了防止重启服务器造成任务重复执行，需要将执行定时任务的时间修改为第二天。
		/*if (date.before(new Date())) {
			date = this.addDay(date, 1);
		}*/
 
		Timer timer = new Timer();
 
		DailyDataTimerTask task = new DailyDataTimerTask();
		AddStaticTask addStaticTask = new AddStaticTask();
		AddDynamicTask addDynamicTask = new AddDynamicTask();
		// 任务执行间隔。
		//timer.schedule(task, date, PERIOD_DAY);//时间间隔
		timer.schedule(task, date);//执行一次
		// 执行一次添加定时任务
		timer.schedule(addStaticTask, date);
		timer.schedule(addDynamicTask, date);
		
		
		/*** 定制每日00:00执行方法 ***/
		calendar.set(Calendar.HOUR_OF_DAY, 2);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);

		/*** 定制每日02:00执行方法 ***/
		calendar1.set(Calendar.HOUR_OF_DAY, 2);
		calendar1.set(Calendar.MINUTE, 0);
		calendar1.set(Calendar.SECOND, 0);
		
		DailyTimerTask timerTask = new DailyTimerTask();
		DailyDataTimerTask dailyDataTimerTask = new DailyDataTimerTask();
		// 获取当天的0点
		Date need = calendar.getTime();
		// 获取当天的凌晨2点
		Date need1 = calendar.getTime();
		
		if (need.before(new Date())) {
			need = this.addDay(need, 1);
		}

		if (need1.before(new Date())) {
			need1 = this.addDay(need1, 1);
		}
			// 添加任务
		timer.scheduleAtFixedRate(timerTask, need, PERIOD_DAY); // 每天执行
	
	}
 
	// 增加或减少天数
	public Date addDay(Date date, int num) {
		Calendar startDT = Calendar.getInstance();
		startDT.setTime(date);
		startDT.add(Calendar.DAY_OF_MONTH, num);
		return startDT.getTime();
	}

}
