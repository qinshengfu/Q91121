package com.fh.controller.front;

import com.fh.controller.base.BaseController;
import com.fh.entity.system.MemUser;
import com.fh.service.front.AccountManager;
import com.fh.util.*;
import com.fh.util.express.ImageUtils;
import com.fh.util.express.ThreadManagers;
import com.fh.util.verificationCode.EmailVerificaCodeUtil;
import com.fh.util.verificationCode.PhoneVerificaCodeUtil;
import com.fh.util.verificationCode.RandomCodeUtil;
import com.fh.util.verificationCode.VerifyCodeService;
import org.apache.shiro.session.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

/**
 * 功能描述：前台页面跳转【不需要登录】
 *
 * @author Ajie
 * @date 2019/11/26 0026
 */
@Controller
@RequestMapping(value = "/release")
public class ReleaseController extends BaseController {

    // 创建slf4j 日志
    final Logger log = LoggerFactory.getLogger(ReleaseController.class);

    // 加减乘 验证码
    @Resource(name = "verifyCode")
    private VerifyCodeService verifyCodeService;

    // 前台用户管理
    @Resource(name = "accountService")
    private AccountManager accountService;

    /**
     * 功能描述：测试图片压缩上传！！！！！！！！！
     * @author Ajie
     * @date 2019/10/29 0029
     * @param
     * @return
     */
    @RequestMapping(value = "/toAddimg")
    private ModelAndView toAddimg() {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("front/A_pictureUpload2");
        return mv;
    }

    /**
     * 功能描述：生成验证码
     *
     * @author Ajie
     * @date 2019/10/30 0030
     */
    @RequestMapping(value = "/verifyCode")
    public void getMiaoshaVerifyCod(HttpServletResponse response) {

        try {
            BufferedImage image = verifyCodeService.getVerify();
            OutputStream out = response.getOutputStream();
            ImageIO.write(image, "JPEG", out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * @描述：图片上传
     * @参数：请求和文件数据
     * @返回值：UUID后的图片路径
     * @创建人：Ajie
     * @创建时间：2019/10/15 0015
     */
    @RequestMapping(value = "/addPic")
    @ResponseBody
    public String addUser(HttpServletRequest request, @RequestParam(name = "files") MultipartFile pictureFile) throws Exception {
        System.out.println(pictureFile);
        // 得到上传图片的地址
        String imgPath = "";
        try {
            //ImageUtils为之前添加的工具类
            imgPath = ImageUtils.upload(request, pictureFile);
            if (imgPath != null) {
                System.out.println("-----------------图片上传成功！");
            } else {
                System.out.println("-----------------图片上传失败！");
            }
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("----------------图片上传失败！");
        }
        System.out.println("图片上传路径：" + imgPath);
        return imgPath;
    }

    /**
     * 功能描述：发送邮箱验证码
     *
     * @author Ajie
     * @date 2019/10/31 0031
     */
    @RequestMapping(value = "/emailCode")
    public void emailCode() throws Exception {
        // 目标邮箱
        String email = "1243206485@qq.com";
        // 有效期
        int validity = 5;
        String time = validity + "分钟";
        // 获取六位随机数字验证码
        String code = RandomCodeUtil.getInvitaCode(6, 1);
        EmailVerificaCodeUtil.setEmail(email, time, code);
        // 放入session中
        Jurisdiction.getSession().setAttribute(Const.SESSION_EMAIL_CHECK_CODE, code);
        log.info("本次邮箱验证码：{}", code);

        // TimerTask实现N分钟后从session中删除验证码
        final Timer timer = new Timer();
        timer.schedule(new TimerTask() {
            @Override
            public void run() {
                Jurisdiction.getSession().removeAttribute(Const.SESSION_EMAIL_CHECK_CODE);
                System.out.println("邮箱验证码--> 删除成功");
                timer.cancel();
            }
        }, validity * 60 * 1000);
    }

    /**
     * 功能描述：获取邮箱验证码
     *
     * @author Ajie
     * @date 2019/10/31 0031
     */
    @RequestMapping(value = "/getEmailCode")
    @ResponseBody
    public Object getEmailCode() {
        return Jurisdiction.getSession().getAttribute(Const.SESSION_EMAIL_CHECK_CODE);
    }

    /**
     * 功能描述：发送短信验证码
     *
     * @param phone - 目标手机号
     * @author Ajie
     * @date 2019/10/31 0031
     */
    @RequestMapping(value = "/phoneCode", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
    @ResponseBody
    public String phoneCode(@RequestParam(name = "phone") String phone) throws Exception {
        // 获取6位 随机纯数字验证码
        String code = RandomCodeUtil.getInvitaCode(6, 1);
        System.out.println("短信验证码：" + code);
        // 有效期/分钟
        int validity = 3;
        String resule = PhoneVerificaCodeUtil.SendSMS(phone, code, validity);
        if ("success".equals(resule)) {
            // 放入session中
            Jurisdiction.getSession().setAttribute(Const.SESSION_PHONE_CHECK_CODE, code);
            log.info("本次短信验证码：{}", code);
        } else {
            log.info("短信验证码发送失败，原因是：{}", resule);
        }

        //TimerTask实现N分钟后从session中删除验证码
        final Timer timer = new Timer();
        timer.schedule(new TimerTask() {
            @Override
            public void run() {
                Jurisdiction.getSession().removeAttribute(Const.SESSION_PHONE_CHECK_CODE);
                System.out.println("短信验证码--> 删除成功");
                timer.cancel();
            }
        }, validity * 60 * 1000);
        String spare = PhoneVerificaCodeUtil.getSpare();
        log.info("短信余额：{}", spare);

        return resule;
    }


    /**
     * 功能描述：访问注册页
     *
     * @author Ajie
     * @date 2019/11/26 0026
     */
    @RequestMapping(value = "/toRegister")
    public ModelAndView toRegister() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        String tag = pd.getString("tag");
        if (Tools.notEmpty(tag)){
            mv.addObject("tag", tag);
        }
        mv.setViewName("front/login/register");
        return mv;
    }

    /**
     * 功能描述：访问登录页
     *
     * @author Ajie
     * @date 2019/11/26 0026
     */
    @RequestMapping(value = "/toLogin")
    public ModelAndView toLogin() throws Exception {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("front/login/login");
        return mv;
    }

    /**
     * 功能描述：访问忘记密码页
     *
     * @author Ajie
     * @date 2019/11/26 0026
     */
    @RequestMapping(value = "/forgetpassword")
    public ModelAndView toForgetpassword() throws Exception {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("front/login/forgetpassword");
        return mv;
    }


    /**
     * 功能描述：验证账号是否能注册
     *
     * @param userInfo 注册信息数组
     * @author Ajie
     * @date 2019/11/27 0027
     */
    @RequestMapping(value = "/register")
    @ResponseBody
    protected String register(@RequestParam("record") String[] userInfo) throws Exception {
        PageData pd = new PageData();
        PageData pd1;
        PageData pd2;
        // 参数验证
        if (userInfo.length != 6) {
            return "1";
        }
        // 推荐人、手机号、密码、确认密码、交易密码、确认密码
        String recommender = userInfo[0];
        String phone = userInfo[1];
        String login_password = StringUtil.applySha256(userInfo[2]);
        String login_confirm = StringUtil.applySha256(userInfo[3]);
        String transac_password = StringUtil.applySha256(userInfo[4]);
        String transac_confirm = StringUtil.applySha256(userInfo[5]);
        // 手机号格式验证
        if (!Tools.checkMobileNumber(phone)) {
            return "2";
        }
        // 验证手机号是否已经注册
        pd.put("PHONE", phone);
        pd2 = accountService.findByPhone(pd);
        if (pd2 != null) {
            return "3";
        }
        // 加密后的登录密码和确认密码验证
        if (!login_password.equals(login_confirm)) {
            return "4";
        }
        // 加密后的交易密码和确认密码验证
        if (!transac_password.equals(transac_confirm)) {
            return "5";
        }
        // 验证推荐人是否存在
        pd.put("PHONE", recommender);
        pd1 = accountService.findByPhone(pd);
        if ("".equals(pd1) || pd1 == null) {
            return "6";
        }
        // 传数据去保存新注册用户
        ThreadManagers.getThreadPollProxy().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    addRegisterUser(userInfo, pd1);
                } catch (Exception e) {
                    System.out.println("===============》多线程保存新注册用户失败");
                    e.printStackTrace();
                }
            }
        });

        return "success";
    }

    /**
     * 功能描述：保存新注册用户
     *
     * @param userInfo 注册信息
     * @param Re       推荐人资料
     * @author Ajie
     * @date 2019/11/27 0027
     */
    private void addRegisterUser(String[] userInfo, PageData Re) throws Exception {
        removeCache();
        PageData pd = new PageData();
        PageData pd1 = new PageData();
        // 推荐关系路径、推荐人ID
        String rePath = Re.getString("RE_PATH");
        String reId = Re.getString("ACCOUNT_ID");
        // 定义新注册用户的推荐关系路径
        String path = "";
        if (Tools.isEmpty(rePath)) {
            path = reId;
        } else {
            path = rePath + "," + reId;
        }
        pd.put("GMT_CREATE", DateUtil.getTime());
        pd.put("GMT_MODIFIED", "");
        pd.put("STATIC_WALLET", 0);
        pd.put("DYNAMIC_WALLET", 0);
        pd.put("COUNT_BALANCE", 0);
        pd.put("TICKET", 0);
        pd.put("IS_WITHDRAW", 0);
        pd.put("PHONE", userInfo[1]);
        pd.put("LOGIN_PASSWORD", StringUtil.applySha256(userInfo[2]));
        pd.put("TRANSACTION_PASSWORD", StringUtil.applySha256(userInfo[4]));
        pd.put("RECOMMENDED_NUMBER", 0);
        pd.put("RECOMMENDER", userInfo[0]);
        pd.put("RECOMMENDER_ID", reId);
        pd.put("RE_PATH", path);
        pd.put("USER_RANK", 0);
        pd.put("USER_STATE", -1);
        pd.put("REST_TIME", 0);
        pd.put("NAME", "");
        pd.put("ALIPAY", "");
        pd.put("BANK_NAME", "");
        pd.put("BANK_NUMBER", "");
        pd.put("BANK_ADDRESS", "");
        pd.put("ETH_ADDRESS", "");
        pd.put("ACCOUNT_ID", "");
        accountService.save(pd);
        pd = accountService.findByPhone(pd);
        // 把新注册的用户添加到服务器缓存中
        applicati.setAttribute(userInfo[1], pd);
        List<PageData> userList = (List<PageData>) applicati.getAttribute(Const.APP_USER);
        userList.add(pd);
        applicati.setAttribute(Const.APP_USER, userList);
        // 更新推荐人的推荐数量
        pd1.put("PHONE", Re.getString("PHONE"));
        accountService.addReNumber(pd1);
        // 根据推荐人ID查信息，重新赋值到服务器缓存中
        pd1 = accountService.findById(Re);
        applicati.setAttribute(pd1.get("PHONE").toString(), pd1);
    }

    /**
     * 功能描述：请求登录，验证用户
     *
     * @param userInfo 登录信息
     * @return 处理结果
     * @author Ajie
     * @date 2019/11/27 0027
     */
    @RequestMapping(value = "/login")
    @ResponseBody
    protected String login(@RequestParam("record") String[] userInfo) throws Exception {
        PageData pd = new PageData();
        // 参数验证
        if (userInfo.length != 3) {
            return "1";
        }
        // 手机号、密码、验证码、缓存的验证码
        String phone = userInfo[0];
        String login_password = StringUtil.applySha256(userInfo[1]);
		/*String yzm = userInfo[2];
		String mem_yzm = (String) Jurisdiction.getSession().getAttribute(Const.SESSION_SECURITY_CODE);*/
        // 手机号格式验证
        if (!Tools.checkMobileNumber(phone)) {
            return "2";
        }
        // 验证手机号是否存在
        pd = (PageData) applicati.getAttribute(phone);
        if ("".equals(pd) || pd == null) {
            return "3";
        }
        // 账号状态验证 1:账号冻结、0：资金冻结
        int state = Integer.parseInt(pd.get("USER_STATE").toString());
        if (state == 1) {
            return "6";
        }
        // 加密后的登录密码验证
        if (!login_password.equals(pd.getString("LOGIN_PASSWORD"))) {
            return "4";
        }
        // 验证码验证
		/*if (!yzm.equals(mem_yzm)) {
			return "5";
		}*/
        // 传数据去存到登录序列中和session中
        addLogin(phone);
        return "success";
    }

    /**
     * 功能描述：后台请求登录前台用户，验证用户
     *
     * @return 处理结果
     * @author Ajie
     * @date 2019/11/27 0027
     */
    @RequestMapping(value = "/adminLogin", produces="text/html;charset=UTF-8")
    @ResponseBody
    protected String adminLogin() throws Exception {
        PageData pd;
        pd = this.getPageData();
        // 手机号、密码
        String phone = pd.getString("phone");
        // 验证手机号是否存在
        pd = (PageData) applicati.getAttribute(phone);
        if ("".equals(pd) || pd == null) {
            return "手机号不存在";
        }
        // 传数据去存到登录序列中和session中
        addLogin(phone);
        return "success";
    }

    /**
     * 功能描述：把新登录的用户添加的 登录序列中 并添加的session缓存
     *
     * @param phone 用户手机号
     * @author Ajie
     * @date 2019/11/27 0027
     */
    private void addLogin(String phone) throws Exception {
        Session session = Jurisdiction.getSession();
        String sessionId = session.getId().toString();
        // 查询数据库 赋值到实体类
        PageData pd = new PageData();
        pd.put("PHONE", phone);
        MemUser user = accountService.findByPhone1(pd);
        // 从全局缓存获取登录序列
        Map<String, String> loginMap = (Map<String, String>) applicati.getAttribute("loginMap");
        if (loginMap == null) {
            loginMap = new HashMap<String, String>();
        }
        // 更新到缓存中
        loginMap.put(user.getACCOUNT_ID(), sessionId);
        applicati.setAttribute("loginMap", loginMap);
        // 把用户添加到session中
        session.setAttribute(Const.SESSION_MEMUSER, user);
    }

    /**
     * 功能描述：清除缓存
     *
     * @author Ajie
     * @date 2019/11/27 0027
     */
    public void removeCache() {
        Session session = Jurisdiction.getSession();
        // 以下清除session缓存
        session.removeAttribute(Const.SESSION_MEMUSER);
    }

    /**
     * 功能描述：发送短信验证码，找回密码用
     *
     * @author Ajie
     * @date 2019/11/28 0028
     */
    @RequestMapping(value = "/sendPhoneSms", produces="text/html;charset=UTF-8")
    @ResponseBody
    private String phoneSms() {
        Session session = Jurisdiction.getSession();
        String info = "";
        // 验证手机号是否已注册、并且未被封号
        PageData pd = new PageData();
        pd = this.getPageData();
        pd = (PageData) applicati.getAttribute(pd.getString("PHONE"));
        if ("".equals(pd) || null == pd) {
            return "手机号未注册";
        }
        if ("1".equals(pd.get("USER_STATE").toString())) {
            return "账号已被冻结";
        }
        // 设置验证码
        // String yzm = RandomCodeUtil.getInvitaCode(6, 1);
        String yzm = "666";
        // 存session中
        session.setAttribute(Const.SESSION_PHONE_CHECK_CODE, yzm);
        session.setAttribute(Const.SESSION_PHONE, pd.getString("PHONE"));
        // 发短信
        String content = "您本次修改密码的验证码为：【" + yzm + "】。(该验证码300秒内有效)";
        /*try {
            info = SendSMS.sendSMS(phone.trim(), content);
        } catch (Exception e) {
            return info;
        }*/
        //TimerTask实现N分钟后从session中删除验证码
        final Timer timer = new Timer();
        timer.schedule(new TimerTask() {
            @Override
            public void run() {
                Jurisdiction.getSession().removeAttribute(Const.SESSION_PHONE_CHECK_CODE);
                System.out.println("短信验证码 5分钟已过==========》【删除成功】");
                timer.cancel();
            }
        }, 5 * 60 * 1000);
        return "success";
    }

    /**
     * 功能描述：请求寻回密码，验证参数是否正确
     *
     * @param record 密码信息
     * @author Ajie
     * @date 2019/11/28 0028
     */
    @RequestMapping(value = "/retrievePassword")
    @ResponseBody
    public String retrievePassword(@RequestParam(name = "record") String[] record) throws Exception {
        Session session = Jurisdiction.getSession();
        // 获取短信验证码、寻回密码的手机号
        String sessionCode = (String) session.getAttribute(Const.SESSION_PHONE_CHECK_CODE);
        String phone = (String) session.getAttribute(Const.SESSION_PHONE);
        // 验证码失效
        if (Tools.isEmpty(sessionCode) || Tools.isEmpty(phone)) {
            return "5";
        }
        // 参数是否够
        if (record.length != 4) {
            return "1";
        }
        // 密码是否一致
        if (!record[1].equals(record[2])) {
            return "2";
        }
        // 验证码是否正确
        if (!sessionCode.equals(record[3])) {
            return "3";
        }
        // 手机号是否匹配
        if (!phone.equals(record[0])) {
            return "4";
        }
        confirmChange(record);
        return "success";
    }

    /**
     * 功能描述：验证通过、修改密码
     *
     * @param record 经过验证后的参数
     * @author Ajie
     * @date 2019/11/28 0028
     */
    private void confirmChange(String[] record) throws Exception {
        PageData pd = new PageData();
        // 通过手机号获取用户信息赋值到pd
        pd.put("PHONE", record[0]);
        pd = accountService.findByPhone(pd);
        // 执行修改
        String newPass = StringUtil.applySha256(record[2]);
        pd.put("LOGIN_PASSWORD", newPass);
        accountService.editPassword(pd);
        // 更新缓存
        applicati.setAttribute(pd.getString("PHONE"), pd);
    }


}