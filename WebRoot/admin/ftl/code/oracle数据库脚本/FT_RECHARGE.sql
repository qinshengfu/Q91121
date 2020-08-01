-- ----------------------------
-- Table structure for "FT_RECHARGE"
-- ----------------------------
-- DROP TABLE "FT_RECHARGE";
CREATE TABLE "FT_RECHARGE" (
	"GMT_CREATE" VARCHAR2(32 BYTE) NULL ,
	"GMT_MODIFIED" VARCHAR2(32 BYTE) NULL ,
	"PHONE" NUMBER(11) NULL ,
	"MONEY" NUMBER(30,2) NULL ,
	"TYPE" VARCHAR2(2 BYTE) NULL ,
	"REMARKS" VARCHAR2(255 BYTE) NULL ,
	"AMOUNT_AFTER" NUMBER(30,2) NULL ,
	"RECHARGE_ID" VARCHAR2(100 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE
;

COMMENT ON COLUMN "FT_RECHARGE"."GMT_CREATE" IS '创建时间';
COMMENT ON COLUMN "FT_RECHARGE"."GMT_MODIFIED" IS '更新时间';
COMMENT ON COLUMN "FT_RECHARGE"."PHONE" IS '手机号';
COMMENT ON COLUMN "FT_RECHARGE"."MONEY" IS '金额';
COMMENT ON COLUMN "FT_RECHARGE"."TYPE" IS '类型，0：动态钱包、1：静态钱包、2：算力账户、3：入场券';
COMMENT ON COLUMN "FT_RECHARGE"."REMARKS" IS '备注';
COMMENT ON COLUMN "FT_RECHARGE"."AMOUNT_AFTER" IS '充值后的金额';
COMMENT ON COLUMN "FT_RECHARGE"."RECHARGE_ID" IS 'ID';

-- ----------------------------
-- Indexes structure for table FT_RECHARGE
-- ----------------------------

-- ----------------------------
-- Checks structure for table "FT_RECHARGE"

-- ----------------------------

ALTER TABLE "FT_RECHARGE" ADD CHECK ("RECHARGE_ID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table "FT_RECHARGE"
-- ----------------------------
ALTER TABLE "FT_RECHARGE" ADD PRIMARY KEY ("RECHARGE_ID");
