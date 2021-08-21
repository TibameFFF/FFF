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
  `g_type_no` INT NOT NULL AUTO_INCREMENT COMMENT '���������s��',
  `g_type` VARCHAR(45) NOT NULL COMMENT '��������',
  PRIMARY KEY (`g_type_no`))
ENGINE = InnoDB;

INSERT INTO `group1`.`type` (`g_type`) VALUES ('�B��');
INSERT INTO `group1`.`type` (`g_type`) VALUES ('�Y��');
INSERT INTO `group1`.`type` (`g_type`) VALUES ('�d��');
INSERT INTO `group1`.`type` (`g_type`) VALUES ('�{��');

-- -----------------------------------------------------
-- Table `group1`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT COMMENT '�ϥΪ�',
  `user_name` VARCHAR(50) NULL COMMENT '�ϥΪ̦W��',
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;

INSERT INTO `group1`.`user` (`user_name`) VALUES ('���@');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('���G');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('���T');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('���|');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('����');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('����');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('���C');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('���K');
INSERT INTO `group1`.`user` (`user_name`) VALUES ('���E');

-- -----------------------------------------------------
-- Table `group1`.`group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`group` (
  `g_no` INT NOT NULL AUTO_INCREMENT COMMENT '���ʽs��',
  `g_name` VARCHAR(50) NOT NULL COMMENT '���ʦW��',
  `g_type_no` INT NOT NULL COMMENT '���������s��',
  `g_content` VARCHAR(200) NOT NULL COMMENT '���ʤ��e',
  `g_start_time` DATETIME NOT NULL COMMENT '���ʶ}�l�ɶ�',
  `g_end_time` DATETIME NOT NULL COMMENT '���ʵ����ɶ�',
  `apply_start_time` DATETIME NOT NULL COMMENT '���W�}�l�ɶ�',
  `apply_end_time` DATETIME NOT NULL COMMENT '���W�����ɶ�',
  `place` VARCHAR(50) NOT NULL COMMENT '�a�I',
  `number_lower` INT NOT NULL COMMENT '�H�ƤU��',
  `number_upper` INT NULL COMMENT '�H�ƤW��',
  `number_total` INT NULL COMMENT '�`�H��',
  `user_id` INT NOT NULL COMMENT '�}�Ϊ�',
  `introduce` VARCHAR(200) NOT NULL COMMENT '�}�Ϊ̦ۧڤ���',
  `phone` VARCHAR(10) NULL COMMENT '�}�Ϊ̤��',
  `email` VARCHAR(1000) NULL COMMENT '�}�Ϊ�EMAIL',
  `state_no` INT NULL COMMENT '���A�X 0:�y�� 1:�}�Τ�2:���� 3:����',
  `g_flow_cause` VARCHAR(200) NULL COMMENT '�y�έ��]',
  `photo` BLOB NULL COMMENT '���ʷӤ�',
  `g_url` VARCHAR(400) NULL COMMENT '���ʺ��}',
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
INSERT INTO `group1`.`group` (`g_name`,`g_type_no`,`g_content`,`g_start_time`,`g_end_time`,`apply_start_time`,`apply_end_time`,`place`,`number_lower`,`number_upper`,`number_total`, `user_id`, `introduce`, `phone`, `email`, `state_no`, `g_flow_cause`, `photo`, `g_url`) VALUES ('���ʦW��1', '1', '�o�O����1���e', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '�x��','1', '3', '3', '1', '���ʤ���1', '0911111111', 'aa@gmail.com', '0', '�]���ҥH', null,null); 
INSERT INTO `group1`.`group` (`g_name`,`g_type_no`,`g_content`,`g_start_time`,`g_end_time`,`apply_start_time`,`apply_end_time`,`place`,`number_lower`,`number_upper`,`number_total`, `user_id`, `introduce`, `phone`, `email`, `state_no`, `g_flow_cause`, `photo`, `g_url`) VALUES ('���ʦW��2', '2', '�o�O����2���e', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '�x�_', '1','3','3', '2', '���ʤ���2', '0922222222', 'bb@gmail.com', '1', null, null, null);
INSERT INTO `group1`.`group` (`g_name`,`g_type_no`,`g_content`,`g_start_time`,`g_end_time`,`apply_start_time`,`apply_end_time`,`place`,`number_lower`,`number_upper`,`number_total`, `user_id`, `introduce`, `phone`, `email`, `state_no`, `g_flow_cause`, `photo`, `g_url`) VALUES ('���ʦW��3', '3', '�o�O����3���e', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '����', '1', '3', '3', '3', '���ʤ���3', '0933333333', 'cc@gmail.com', '2', null, null, 'www.yahoo.com');
INSERT INTO `group1`.`group` (`g_name`,`g_type_no`,`g_content`,`g_start_time`,`g_end_time`,`apply_start_time`,`apply_end_time`,`place`,`number_lower`,`number_upper`,`number_total`, `user_id`, `introduce`, `phone`, `email`, `state_no`, `g_flow_cause`, `photo`, `g_url`) VALUES ('���ʦW��4', '4', '�o�O����4���e', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '2020-01-01 11:11:00', '2020-02-02 22:22:00', '�x�_', '1', '3', '1', '9', '���ʤ���4', '0999999999', 'dd@gmail.com', '3',null ,null , 'www.tibame.com');

-- -----------------------------------------------------
-- Table `group1`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`member` (
  `join_no` INT NOT NULL AUTO_INCREMENT COMMENT '�[�J�έ��s��',
  `role` INT NOT NULL COMMENT '0:�ժ�1:�խ�',
  `user_id` INT NOT NULL COMMENT '�|���b��',
  `g_no` INT NOT NULL COMMENT '���ʽs��',
  `join_time` DATETIME NOT NULL COMMENT '�[�J�ɶ�',
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
  `comment_no` INT NOT NULL AUTO_INCREMENT COMMENT '���ʯd���s��',
  `user_id` INT NOT NULL COMMENT '�d����',
  `comment_time` DATETIME NOT NULL COMMENT '�d���ɶ�',
  `comment` VARCHAR(200) NOT NULL COMMENT '�d�����e',
  `g_no` INT NOT NULL COMMENT '���ʽs��',
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

INSERT INTO `group1`.`comment` (`user_id`, `comment_time`, `comment`, `g_no`) VALUES ('1', '2020-01-01 11:11:11', '�d��1', '1');
INSERT INTO `group1`.`comment` (`user_id`, `comment_time`, `comment`, `g_no`) VALUES ('2', '2020-01-01 11:11:11', '�d��2', '2');
INSERT INTO `group1`.`comment` (`user_id`, `comment_time`, `comment`, `g_no`) VALUES ('3', '2020-01-01 11:11:11', '�d��3', '3');
INSERT INTO `group1`.`comment` (`user_id`, `comment_time`, `comment`, `g_no`) VALUES ('9', '2020-01-01 11:11:11', '�d��4', '4');



-- -----------------------------------------------------
-- Table `group1`.`reply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`reply` (
  `reply_no` INT NOT NULL AUTO_INCREMENT COMMENT '���ʦ^�нs��',
  `user_id` INT NOT NULL COMMENT '�^�Ъ�',
  `reply` VARCHAR(200) NOT NULL COMMENT '�^��',
  `reply_time` DATETIME NOT NULL COMMENT '�^�Юɶ�',
  `comment_no` INT NOT NULL COMMENT '�d���s��',
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

INSERT INTO `group1`.`reply` ( `user_id`, `reply`, `reply_time`, `comment_no`) VALUES ('4', '�^��1', '2020-01-01 11:11:12', '1');
INSERT INTO `group1`.`reply` ( `user_id`, `reply`, `reply_time`, `comment_no`) VALUES ('3', '�^��2', '2020-01-01 11:11:12', '2');
INSERT INTO `group1`.`reply` ( `user_id`, `reply`, `reply_time`, `comment_no`) VALUES ('2', '�^��3', '2020-01-01 11:11:12', '3');
INSERT INTO `group1`.`reply` ( `user_id`, `reply`, `reply_time`, `comment_no`) VALUES ('1', '�^��4', '2020-01-01 11:11:12', '4');


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
