
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `FT_RECHARGE`
-- ----------------------------
DROP TABLE IF EXISTS `FT_RECHARGE`;
CREATE TABLE `FT_RECHARGE` (
 		`RECHARGE_ID` varchar(100) NOT NULL,
		`GMT_CREATE` varchar(32) DEFAULT NULL COMMENT '创建时间',
		`GMT_MODIFIED` varchar(32) DEFAULT NULL COMMENT '更新时间',
		`PHONE` int(11) NOT NULL COMMENT '手机号',
		`MONEY` double(30,2) DEFAULT NULL COMMENT '金额',
		`TYPE` varchar(2) DEFAULT NULL COMMENT '类型，0：动态钱包、1：静态钱包、2：算力账户、3：入场券',
		`REMARKS` varchar(255) DEFAULT NULL COMMENT '备注',
		`AMOUNT_AFTER` double(30,2) DEFAULT NULL COMMENT '充值后的金额',
  		PRIMARY KEY (`RECHARGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
