package com.fh.entity.system;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 功能描述：前台用户实体类
 * @author Ajie
 * @date 2019/11/27 0027
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemUser {

    // 创建时间
    private String GMT_CREATE;
    // 更新时间
    private String GMT_MODIFIED;
    // 静态钱包
    private int STATIC_WALLET;
    // 动态钱包
    private int DYNAMIC_WALLET;
    // 算力余额
    private int COUNT_BALANCE;
    // 入场券余额
    private int TICKET;
    // 1 :已提现，0 :未提现。 每日0时 重置为 0
    private int IS_WITHDRAW;
    // 手机号
    private String PHONE;
    // 登录密码
    private String LOGIN_PASSWORD;
    // 交易密码
    private String TRANSACTION_PASSWORD;
    // 推荐人数
    private int RECOMMENDED_NUMBER;
    // 推荐人
    private String RECOMMENDER;
    // 推荐路径
    private String RE_PATH;
    // 用户等级 0:普通会员、1：高级经理
    private int USER_RANK;
    // 用户状态 1:账号冻结、0：资金冻结
    private int USER_STATE;
    // 不给匹配天数，如果大于0，每天-1
    private int REST_TIME;
    // 姓名
    private String NAME;
    // 支付宝账号
    private String ALIPAY;
    // 银行名称
    private String BANK_NAME;
    // 银行卡号
    private String BANK_NUMBER;
    // 开户行地址
    private String BANK_ADDRESS;
    // ETH钱包地址
    private String ETH_ADDRESS;
    // ID
    private String ACCOUNT_ID;


}
