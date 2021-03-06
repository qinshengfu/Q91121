GO
/******  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE FT_RECHARGE (
 		RECHARGE_ID  nvarchar(100) NOT NULL,
		GMT_CREATE nvarchar(32) DEFAULT NULL,
		GMT_MODIFIED nvarchar(32) DEFAULT NULL,
		PHONE int NOT NULL,
		MONEY numeric(30,2) NULL,
		TYPE nvarchar(2) DEFAULT NULL,
		REMARKS nvarchar(255) DEFAULT NULL,
		AMOUNT_AFTER numeric(30,2) NULL,
PRIMARY KEY CLUSTERED 
(
	[RECHARGE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
