SET foreign_key_checks = 0;

DELETE FROM `BACK`.`ADMIN`;
ALTER TABLE `BACK`.`ADMIN` AUTO_INCREMENT=0;

DELETE FROM `BACK`.`ADMIN_LEVEL`;
ALTER TABLE `BACK`.`ADMIN_LEVEL` AUTO_INCREMENT=0;

DELETE FROM `BACK`.`ADMIN_STATUS`;
ALTER TABLE `BACK`.`ADMIN_STATUS` AUTO_INCREMENT=0;

DELETE FROM `BACK`.`OBJECT_TYPE`;
ALTER TABLE `BACK`.`OBJECT_TYPE` AUTO_INCREMENT=0;

DELETE FROM `BACK`.`REPORT_STATUS`;
ALTER TABLE `BACK`.`REPORT_STATUS` AUTO_INCREMENT=0;

DELETE FROM `BACK`.`REPORT_TYPE`;
ALTER TABLE `BACK`.`REPORT_TYPE` AUTO_INCREMENT=0;

DELETE FROM `BACK`.`REPORT`;
ALTER TABLE `BACK`.`REPORT` AUTO_INCREMENT=0;

INSERT INTO `BACK`.`ADMIN_LEVEL` (`LEVEL_ID`,`LEVEL_NAME`) VALUES (1,'工讀生');
INSERT INTO `BACK`.`ADMIN_LEVEL` (`LEVEL_ID`,`LEVEL_NAME`) VALUES (2,'正職');
INSERT INTO `BACK`.`ADMIN_LEVEL` (`LEVEL_ID`,`LEVEL_NAME`) VALUES (3,'主管');

INSERT INTO `BACK`.`ADMIN_STATUS` (`STATUS_ID`,`STATUS_NAME`) VALUES (1,'在職中');
INSERT INTO `BACK`.`ADMIN_STATUS` (`STATUS_ID`,`STATUS_NAME`) VALUES (2,'已停權');


INSERT INTO `BACK`.`REPORT_STATUS` (`STATUS_ID`,`STATUS_NAME`) VALUES (1,'未處理');
INSERT INTO `BACK`.`REPORT_STATUS` (`STATUS_ID`,`STATUS_NAME`) VALUES (2,'已處理');
INSERT INTO `BACK`.`REPORT_STATUS` (`STATUS_ID`,`STATUS_NAME`) VALUES (3,'已略過');

INSERT INTO `BACK`.`OBJECT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (1,'文章');
INSERT INTO `BACK`.`OBJECT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (2,'留言');
INSERT INTO `BACK`.`OBJECT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (3,'揪團');
INSERT INTO `BACK`.`OBJECT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (4,'自我介紹');
INSERT INTO `BACK`.`OBJECT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (5,'個人聊天');
INSERT INTO `BACK`.`OBJECT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (6,'多人聊天');

INSERT INTO `BACK`.`REPORT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (1,'裸露');
INSERT INTO `BACK`.`REPORT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (2,'暴力');
INSERT INTO `BACK`.`REPORT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (3,'騷擾');
INSERT INTO `BACK`.`REPORT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (4,'自殺自殘');
INSERT INTO `BACK`.`REPORT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (5,'不實資訊');
INSERT INTO `BACK`.`REPORT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (6,'垃圾訊息');
INSERT INTO `BACK`.`REPORT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (7,'販售違禁品');
INSERT INTO `BACK`.`REPORT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (8,'仇恨言論');
INSERT INTO `BACK`.`REPORT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (9,'恐怖主義');
INSERT INTO `BACK`.`REPORT_TYPE` (`TYPE_ID`,`TYPE_NAME`) VALUES (10,'其它');


INSERT INTO `BACK`.`ADMIN` (`ADMIN_ID`,`ADMIN_ACCOUNT`,`ADMIN_PASSWORD`,`ADMIN_NAME`,`ADMIN_JOIN`,`ADMIN_LEVEL`,`ADMIN_STATUS`) VALUES (1,'jason871314','871314','Jason','2020-12-11 11:11:11.0',2,1);
INSERT INTO `BACK`.`ADMIN` (`ADMIN_ID`,`ADMIN_ACCOUNT`,`ADMIN_PASSWORD`,`ADMIN_NAME`,`ADMIN_JOIN`,`ADMIN_LEVEL`,`ADMIN_STATUS`) VALUES (2,'angela871314','880118','Angela','2020-12-11 11:11:11.0',3,1);
INSERT INTO `BACK`.`ADMIN` (`ADMIN_ID`,`ADMIN_ACCOUNT`,`ADMIN_PASSWORD`,`ADMIN_NAME`,`ADMIN_JOIN`,`ADMIN_LEVEL`,`ADMIN_STATUS`) VALUES (3,'test','test','test','2020-12-11 11:11:11.0',1,1);


INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`) VALUES (1,1,1,1,6,1,'廢文','2020-12-11 11:11:11.0');
INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`) VALUES (2,2,1,1,8,1,'歧視原住民qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq','2020-12-12 01:11:12.0');
INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`) VALUES (3,3,1,1,2,1,'糾人尋仇','2020-12-12 11:11:13.0');
INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`,`EXECUTE_TIME`) VALUES (4,4,2,1,10,2,'假人','2020-12-13 11:11:14.0','2020-12-13 11:16:14.0');
INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`) VALUES (5,5,1,1,3,1,'騷擾','2020-12-14 11:11:15.0');
INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`,`EXECUTE_TIME`) VALUES (6,6,1,1,6,2,'貼亂碼亂群','2020-12-15 11:11:16.0','2020-12-16 11:11:16.0');
INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`,`EXECUTE_TIME`) VALUES (7,1,8,1,10,3,'亂檢舉我超爽!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!','2020-12-16 11:11:16.0','2020-12-16 11:14:16.0');
INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`,`EXECUTE_TIME`) VALUES (8,1,8,1,10,3,'亂檢舉我超爽!!','2020-12-16 11:11:17.0','2020-12-16 11:14:18.0');
INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`,`EXECUTE_TIME`) VALUES (9,1,8,1,10,3,'亂檢舉我超爽!!','2020-12-16 11:11:18.0','2020-12-16 11:14:19.0');
INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`,`EXECUTE_TIME`) VALUES (10,1,8,1,10,3,'亂檢舉我超爽!!','2020-12-16 11:11:19.0','2020-12-16 11:14:20.0');
INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`,`EXECUTE_TIME`) VALUES (11,1,8,1,10,3,'亂檢舉我超爽!!','2020-12-16 11:11:20.0','2020-12-16 11:14:21.0');
INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`) VALUES (12,2,1,1,8,1,'爛','2020-12-21 01:11:12.0');
INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`) VALUES (13,4,12,13,10,1,'假帳號','2020-12-22 11:11:14.0');
INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`) VALUES (14,4,12,13,10,1,'假帳號','2020-12-22 11:11:14.0');
INSERT INTO `BACK`.`REPORT` (`REPORT_NO`,`OBJECT_TYPE`,`REPORTER_ID`,`OBJECT_ID`,`REPORT_TYPE`,`REPORT_STATUS`,`REPORT_DESCRIPTION`,`REPORT_TIME`) VALUES (15,4,12,13,10,1,'假帳號','2020-12-22 11:11:14.0');
SET foreign_key_checks= 1;