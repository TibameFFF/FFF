-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema group1
-- -----------------------------------------------------



-- -----------------------------------------------------
-- Schema group1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `group1` DEFAULT CHARACTER SET utf8mb4 ;
USE `group1` ;


SET foreign_key_checks = 0;

DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `type`;
DROP TABLE IF EXISTS `group`;
DROP TABLE IF EXISTS `member`;
DROP TABLE IF EXISTS `comment`;
DROP TABLE IF EXISTS `reply`;

-- -----------------------------------------------------
-- Table `group1`.`type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`type` (
  `g_type_no` INT NOT NULL AUTO_INCREMENT COMMENT '活動類型編號',
  `g_type` VARCHAR(45) NOT NULL COMMENT '活動類型',
  PRIMARY KEY (`g_type_no`))
ENGINE = InnoDB;

INSERT INTO `group1`.`type` (`g_type`) VALUES ('運動');
INSERT INTO `group1`.`type` (`g_type`) VALUES ('吃飯');
INSERT INTO `group1`.`type` (`g_type`) VALUES ('寵物');
INSERT INTO `group1`.`type` (`g_type`) VALUES ('程式');

-- -----------------------------------------------------
-- Table `group1`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT COMMENT '使用者',
  `user_name` VARCHAR(50) NULL COMMENT '使用者名稱',
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;

INSERT INTO `group1`.`user` (`user_name`) VALUES ('阿一');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('阿二');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('阿三');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('阿四');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('阿五');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('阿六');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('阿七');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('阿八');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('阿九');

-- -----------------------------------------------------
-- Table `group1`.`group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`group` (
  `g_no` INT NOT NULL AUTO_INCREMENT COMMENT '活動編號',
  `g_name` VARCHAR(50) NOT NULL COMMENT '活動名稱',
  `g_type_no` INT NOT NULL COMMENT '活動類型編號',
  `g_content` VARCHAR(200) NOT NULL COMMENT '活動內容',
  `g_start_time` DATETIME NOT NULL COMMENT '活動開始時間',
  `g_end_time` DATETIME NOT NULL COMMENT '活動結束時間',
  `apply_start_time` DATETIME NOT NULL COMMENT '報名開始時間',
  `apply_end_time` DATETIME NOT NULL COMMENT '報名結束時間',
  `place` VARCHAR(50) NOT NULL COMMENT '地點',
  `number_lower` INT NOT NULL COMMENT '人數下限',
  `number_upper` INT NULL COMMENT '人數上限',
  `number_total` INT NULL COMMENT '總人數',
  `user_id` INT NOT NULL COMMENT '開團者',
  `introduce` VARCHAR(200) NOT NULL COMMENT '開團者自我介紹',
  `phone` VARCHAR(10) NULL COMMENT '開團者手機',
  `email` VARCHAR(1000) NULL COMMENT '開團者EMAIL',
  `state_no` INT NULL COMMENT '狀態碼 0:流團 1:開團中2:成團 3:結束',
  `g_flow_cause` VARCHAR(200) NULL COMMENT '流團員因',
  `photo` BLOB NULL COMMENT '活動照片',
  `g_url` VARCHAR(400) NULL COMMENT '活動網址',
  PRIMARY KEY (`g_no`),
  INDEX `FK_gTypeNo_idx` (`g_type_no` ASC) VISIBLE,
  INDEX `FK_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `FK_gTypeNo`
    FOREIGN KEY (`g_type_no`)
    REFERENCES `group1`.`type` (`g_type_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_group_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `group1`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- GROUP
INSERT INTO `group1`.`group` (`g_name`,`g_type_no`,`g_content`,`g_start_time`,`g_end_time`,`apply_start_time`,`apply_end_time`,`place`,`number_lower`,`number_upper`,`number_total`, `user_id`, `introduce`, `phone`, `email`, `state_no`, `g_flow_cause`, `photo`, `g_url`) VALUES ('活動名稱1', '1', '這是活動1內容', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '台中','1', '3', '3', '1', '活動介紹1', '0911111111', 'aa@gmail.com', '0', '因為所以', null,null); 
INSERT INTO `group1`.`group` (`g_name`,`g_type_no`,`g_content`,`g_start_time`,`g_end_time`,`apply_start_time`,`apply_end_time`,`place`,`number_lower`,`number_upper`,`number_total`, `user_id`, `introduce`, `phone`, `email`, `state_no`, `g_flow_cause`, `photo`, `g_url`) VALUES ('活動名稱2', '2', '這是活動2內容', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '台北', '1','3','3', '2', '活動介紹2', '0922222222', 'bb@gmail.com', '1', null, null, null);
INSERT INTO `group1`.`group` (`g_name`,`g_type_no`,`g_content`,`g_start_time`,`g_end_time`,`apply_start_time`,`apply_end_time`,`place`,`number_lower`,`number_upper`,`number_total`, `user_id`, `introduce`, `phone`, `email`, `state_no`, `g_flow_cause`, `photo`, `g_url`) VALUES ('活動名稱3', '3', '這是活動3內容', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '高雄', '1', '3', '3', '3', '活動介紹3', '0933333333', 'cc@gmail.com', '2', null, null, 'www.yahoo.com');
INSERT INTO `group1`.`group` (`g_name`,`g_type_no`,`g_content`,`g_start_time`,`g_end_time`,`apply_start_time`,`apply_end_time`,`place`,`number_lower`,`number_upper`,`number_total`, `user_id`, `introduce`, `phone`, `email`, `state_no`, `g_flow_cause`, `photo`, `g_url`) VALUES ('活動名稱4', '4', '這是活動4內容', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '台北', '1', '3', '1', '9', '活動介紹4', '0999999999', 'dd@gmail.com', '3',null ,null , 'www.tibame.com');

-- -----------------------------------------------------
-- Table `group1`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`member` (
  `join_no` INT NOT NULL AUTO_INCREMENT COMMENT '加入團員編號',
  `role` INT NOT NULL COMMENT '0:組長1:組員',
  `user_id` INT NOT NULL COMMENT '會員帳號',
  `g_no` INT NOT NULL COMMENT '活動編號',
  `join_time` DATETIME NOT NULL COMMENT '加入時間',
  PRIMARY KEY (`join_no`),
  INDEX `FK_gNo_idx` (`g_no` ASC) VISIBLE,
  INDEX `FK_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `FK_member_gNo`
    FOREIGN KEY (`g_no`)
    REFERENCES `group1`.`group` (`g_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_member_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `group1`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('0', '1', '1', '2020-01-01 12:12:00');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('0', '2', '2', '2020-01-01 12:12:00');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('0', '3', '3', '2020-01-01 12:12:00');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('1', '4', '1', '2020-01-02 00:00:00');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('1', '5', '2', '2020-01-02 00:00:00');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('1', '6', '3', '2020-01-02 00:00:00');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('1', '7', '1', '2020-01-02 00:00:00');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('1', '8', '2', '2020-01-02 00:00:00');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('1', '9', '3', '2020-01-02 00:00:00');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('0', '9', '4', '2020-01-02 00:00:00');

-- -----------------------------------------------------
-- Table `group1`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`comment` (
  `comment_no` INT NOT NULL AUTO_INCREMENT COMMENT '活動留言編號',
  `user_id` INT NOT NULL COMMENT '留言者',
  `comment_time` DATETIME NOT NULL COMMENT '留言時間',
  `comment` VARCHAR(200) NOT NULL COMMENT '留言內容',
  `g_no` INT NOT NULL COMMENT '活動編號',
  PRIMARY KEY (`comment_no`),
  INDEX `FK_user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `FK_gNo_idx` (`g_no` ASC) VISIBLE,
  CONSTRAINT `FK_comment_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `group1`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_reply_gNo`
    FOREIGN KEY (`g_no`)
    REFERENCES `group1`.`group` (`g_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `group1`.`comment` (`user_id`, `comment_time`, `comment`, `g_no`) VALUES ('1', '2020-01-01 11:11:11', '留言1', '1');
INSERT INTO `group1`.`comment` (`user_id`, `comment_time`, `comment`, `g_no`) VALUES ('2', '2020-01-01 11:11:11', '留言2', '2');
INSERT INTO `group1`.`comment` (`user_id`, `comment_time`, `comment`, `g_no`) VALUES ('3', '2020-01-01 11:11:11', '留言3', '3');
INSERT INTO `group1`.`comment` (`user_id`, `comment_time`, `comment`, `g_no`) VALUES ('9', '2020-01-01 11:11:11', '留言4', '4');



-- -----------------------------------------------------
-- Table `group1`.`reply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`reply` (
  `reply_no` INT NOT NULL AUTO_INCREMENT COMMENT '活動回覆編號',
  `user_id` INT NOT NULL COMMENT '回覆者',
  `reply` VARCHAR(200) NOT NULL COMMENT '回覆',
  `reply_time` DATETIME NOT NULL COMMENT '回覆時間',
  `comment_no` INT NOT NULL COMMENT '留言編號',
  PRIMARY KEY (`reply_no`),
  INDEX `FK_user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `FK_commentNo_idx` (`comment_no` ASC) VISIBLE,
  CONSTRAINT `FK_reply_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `group1`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_commentNo`
    FOREIGN KEY (`comment_no`)
    REFERENCES `group1`.`comment` (`comment_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `group1`.`reply` ( `user_id`, `reply`, `reply_time`, `comment_no`) VALUES ('4', '回覆1', '2020-01-01 11:11:12', '1');
INSERT INTO `group1`.`reply` ( `user_id`, `reply`, `reply_time`, `comment_no`) VALUES ('3', '回覆2', '2020-01-01 11:11:12', '2');
INSERT INTO `group1`.`reply` ( `user_id`, `reply`, `reply_time`, `comment_no`) VALUES ('2', '回覆3', '2020-01-01 11:11:12', '3');
INSERT INTO `group1`.`reply` ( `user_id`, `reply`, `reply_time`, `comment_no`) VALUES ('1', '回覆4', '2020-01-01 11:11:12', '4');


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
