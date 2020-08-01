import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.QuartzManager;
import com.fh.util.verificationCode.RandomCodeUtil;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 说明：测试总入口
 * 创建人：Ajie
 * 创建时间：2019年10月30日17:20:12
 */
public class MainTest {

    // 创建slf4j 日志
    final Logger log = LoggerFactory.getLogger(MainTest.class);

    /**
     * 功能描述：生成随机N位邀请码和类型测试
     *
     * @author Ajie
     * @date 2019/10/30 0030
     */
    @Test
    public void randomTest() {
        String result1 = RandomCodeUtil.getInvitaCode(15, 0);
        String result2 = RandomCodeUtil.getInvitaCode(14, 1);
        String result3 = RandomCodeUtil.getInvitaCode(13, 2);
        String result4 = RandomCodeUtil.getInvitaCode(12, 3);
        String result5 = RandomCodeUtil.getInvitaCode(11, 4);
        String result6 = RandomCodeUtil.getInvitaCode(10, 5);
        String result7 = RandomCodeUtil.getInvitaCode(9, 6);


        log.info("随机15位数（大小字母+数字）：{}", result1);
        log.info("随机14位数（纯数字）：{}", result2);
        log.info("随机13位数（纯小字母）：{}", result3);
        log.info("随机12位数（纯大字母）：{}", result4);
        log.info("随机11位数（大小字母）：{}", result5);
        log.info("随机10位数（小字母+数字）：{}", result6);
        log.info("随机9位数（大字母+数字）：{}", result7);

    }

    /**
     * 功能描述：邮箱验证码测试
     *
     * @author Ajie
     * @date 2019/10/31 0031
     */
    @Test
    public void EmailTest() throws Exception {
        String email = "1243206485@qq.com";
        //获得系统的时间，单位为毫秒,转换为妙
        long startTime = System.currentTimeMillis() / 60 % 60;
        long endTime = startTime + 2;
        log.info("开始时间：{}分，结束时间：{}分，有效期：{}分钟", startTime, endTime, endTime - startTime);

        long validity = endTime - startTime;


      /*  String code = (String) Jurisdiction.getSession().getAttribute(Const.SESSION_SECURITY_CODE);
        log.info("本次邮箱验证码：{}",code);*/
    }

    /**
     * 功能描述：通过System.currentTimeMillis 获取当前时、分、秒
     *
     * @author Ajie
     * @date 2019/10/31 0031
     */
    @Test
    public void timeMillisTest() {
        //获得系统的时间，单位为毫秒,转换为妙
        long totalMilliSeconds = System.currentTimeMillis();
        long totalSeconds = totalMilliSeconds / 1000;
        //求出现在的秒
        long currentSecond = totalSeconds % 60;
        //求出现在的分
        long totalMinutes = totalSeconds / 60;
        long currentMinute = totalMinutes % 60;
        //求出现在的小时(北京时间)
        long totalHour = totalMinutes / 60;
        long currentHour = totalHour % 24 + 8;
        DateUtil.getTime();
        //显示时间
        log.info("总毫秒 / 1000 为：{}", totalSeconds);
        log.info("总毫秒为：{}", totalMilliSeconds);
        log.info("现在的小时：{}，现在的分：{}，现在的秒：{}", currentHour, currentMinute, currentSecond);
    }

    /**
     * 功能描述：定时任务测试
     * @author Ajie
     * @date 2019/12/3 0003
     */
    public static void main(String[] args) {
        // 添加一个定位任务 每隔一分钟执行一次
//        QuartzManager.addJob("test", StaticBonusRelease.class, "0 */1 * * * ?");

        // 启动所有定时任务
//        QuartzManager.startJobs();

        // 移除定时任务
//        QuartzManager.removeJob("测试");

//        // 关闭所有定时任务
        QuartzManager.removeJob("staticRewardTask");
        String name = Const.STATIC_REWARD_TASK;
        String id = "1";
        name += id;
        System.out.println(name);

    }

    /**
     * 功能描述：随机数校验
     *
     * @author Ajie
     * @date 2019/11/15 0015
     */
    @Test
    public void mathRandomTest() {
        for (int j = 0; j < 10; j++) {
            int i = (int) (Math.random() * 3) + 1;
            System.out.println(i);
        }

    }


}