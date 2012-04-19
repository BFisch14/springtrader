
-- Run as nanotrader user - Reference: http://pubs.vmware.com/vfabric5/index.jsp?topic=/com.vmware.vfabric.sqlfire.1.0/reference/language_ref/ref-data-types.html
DROP TABLE  "ORDER" ;
DROP TABLE  QUOTE ;
DROP TABLE  HOLDING ;
DROP TABLE  KEYGEN ;
DROP TABLE  ACCOUNT ;
DROP TABLE  ACCOUNTPROFILE ;




CREATE TABLE HOLDING (
	PURCHASEPRICE NUMERIC(14, 2) NULL,
   	HOLDINGID INTEGER NOT NULL,
   	QUANTITY NUMERIC(25,0) NOT NULL,
   	PURCHASEDATE DATE NULL,
   	ACCOUNT_ACCOUNTID INTEGER NULL,
   	QUOTE_SYMBOL varchar(250) NULL );

ALTER TABLE HOLDING
  ADD CONSTRAINT PK_HOLDING PRIMARY KEY (HOLDINGID);

CREATE TABLE ACCOUNTPROFILE
  (PROFILEID INTEGER NOT NULL,
   ADDRESS varchar(250) NULL,
   PASSWD varchar(250) NULL,
   USERID varchar(250) NOT NULL,
   EMAIL varchar(250) NULL,
   CREDITCARD varchar(250) NULL,
   FULLNAME varchar(250) NULL,
   AUTHTOKEN varchar(100) NULL);

ALTER TABLE ACCOUNTPROFILE
  ADD CONSTRAINT PK_ACCOUNTPROFILE PRIMARY KEY (PROFILEID);

ALTER TABLE ACCOUNTPROFILE
  ADD CONSTRAINT UNIQ_ACCOUNTPROFILE UNIQUE (USERID);

  CREATE TABLE QUOTE
  (QUOTEID INTEGER NOT NULL,
   LOW NUMERIC(14, 2) NULL,
   OPEN1 NUMERIC(14, 2) NULL,
   VOLUME NUMERIC (14, 2) NOT NULL,
   PRICE NUMERIC(14, 2) NULL,
   HIGH NUMERIC(14, 2) NULL,
   COMPANYNAME varchar(250) NULL,
   SYMBOL varchar(250) NOT NULL,
   CHANGE1 NUMERIC (14, 2) NOT NULL);

ALTER TABLE QUOTE
  ADD CONSTRAINT PK_QUOTE PRIMARY KEY (QUOTEID);

ALTER TABLE QUOTE
  ADD CONSTRAINT UNIQ_QUOTE UNIQUE (SYMBOL);

--CREATE TABLE KEYGEN
--  (KEYVAL INTEGER NOT NULL,
--   KEYNAME varchar(250) NOT NULL);

--ALTER TABLE KEYGEN
--  ADD CONSTRAINT PK_KEYGEN PRIMARY KEY (KEYNAME);

CREATE TABLE ACCOUNT
  (CREATIONDATE DATE NULL,
   OPENBALANCE NUMERIC(14, 2) NULL,
   LOGOUTCOUNT INTEGER NOT NULL,
   BALANCE NUMERIC(14, 2) NULL,
   ACCOUNTID INTEGER NOT NULL,
   LASTLOGIN DATE NULL,
   LOGINCOUNT INTEGER NOT NULL,
   PROFILE_PROFILEID Integer NULL);

ALTER TABLE ACCOUNT
  ADD CONSTRAINT PK_ACCOUNT PRIMARY KEY (ACCOUNTID);

ALTER TABLE
  ACCOUNT ADD CONSTRAINT FK_ACCT_PROF FOREIGN KEY (PROFILE_PROFILEID) REFERENCES ACCOUNTPROFILE (PROFILEID);

CREATE TABLE ORDERS
  (ORDERFEE NUMERIC(14, 2) NULL,
   COMPLETIONDATE DATE NULL,
   ORDERTYPE varchar(250) NULL,
   ORDERSTATUS varchar(250) NULL,
   PRICE NUMERIC(14, 2) NULL,
   QUANTITY NUMERIC(25,0) NOT NULL,
   OPENDATE DATE NULL,
   ORDERID INTEGER NOT NULL,
   ACCOUNT_ACCOUNTID INTEGER NULL,
   QUOTE_SYMBOL varchar(250) NULL,
   HOLDING_HOLDINGID INTEGER NULL);


ALTER TABLE "ORDERS"
  ADD CONSTRAINT PK_ORDER PRIMARY KEY (ORDERID);

ALTER TABLE "ORDERS"
  ADD CONSTRAINT FK_ORD_ACCT FOREIGN KEY (ACCOUNT_ACCOUNTID) REFERENCES ACCOUNT (ACCOUNTID);

ALTER TABLE "ORDERS"
  ADD CONSTRAINT FK_ORD_HOLD FOREIGN KEY (HOLDING_HOLDINGID) REFERENCES HOLDING (HOLDINGID);  
  
CREATE INDEX ACCOUNT_PROFILEID  ON ACCOUNT(PROFILE_PROFILEID);
CREATE INDEX HOLDING_ACCOUNTID ON HOLDING (ACCOUNT_ACCOUNTID);
CREATE INDEX ORDER_ACCOUNTID ON "ORDERS" (ACCOUNT_ACCOUNTID);
CREATE INDEX ORDER_HOLDINGID ON "ORDERS" (HOLDING_HOLDINGID);
CREATE INDEX CLOSED_ORDERS   ON "ORDERS" (ACCOUNT_ACCOUNTID,ORDERSTATUS);



