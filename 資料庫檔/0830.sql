-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Center
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Center
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Center` DEFAULT CHARACTER SET utf8mb4 ;
-- -----------------------------------------------------
-- Schema SHOP
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SHOP
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SHOP` DEFAULT CHARACTER SET utf8mb4 ;
-- -----------------------------------------------------
-- Schema back
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema back
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `back` DEFAULT CHARACTER SET utf8mb4 ;
-- -----------------------------------------------------
-- Schema chat
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema chat
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `chat` DEFAULT CHARACTER SET utf8mb4 ;
-- -----------------------------------------------------
-- Schema group1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema group1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `group1` DEFAULT CHARACTER SET utf8mb4 ;
-- -----------------------------------------------------
-- Schema Forum
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Forum
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Forum` DEFAULT CHARACTER SET utf8mb4 ;
USE `Center` ;

-- -----------------------------------------------------
-- Table `Center`.`info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Center`.`info` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_status` TINYINT NOT NULL DEFAULT '0',
  `user_nickname` VARCHAR(45) NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `account` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `bitrhday` DATE NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `sex` TINYINT NOT NULL DEFAULT '0',
  `mapping` TINYINT NOT NULL DEFAULT '0',
  `age_min` TINYINT NOT NULL DEFAULT '18',
  `age_max` TINYINT NOT NULL DEFAULT '100',
  `mapping_sex` TINYINT NOT NULL DEFAULT '0',
  `photo` MEDIUMBLOB NULL DEFAULT NULL,
  `intro` VARCHAR(45) NULL DEFAULT NULL,
  `created_time` DATETIME NOT NULL,
  `violation_count` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `account_UNIQUE` (`account` ASC) VISIBLE,
  UNIQUE INDEX `infocol_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Center`.`block_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Center`.`block_list` (
  `serial_no` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `block_user_id` INT NOT NULL,
  `block_time` DATETIME NOT NULL,
  PRIMARY KEY (`serial_no`),
  INDEX `FK_USER_ID_idx` (`user_id` ASC) VISIBLE,
  INDEX `FK_BLOCK_USER_ID` (`block_user_id` ASC) VISIBLE,
  CONSTRAINT `FK_BLOCK_USER_ID`
    FOREIGN KEY (`block_user_id`)
    REFERENCES `Center`.`info` (`user_id`),
  CONSTRAINT `FK_USER_ID`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

USE `SHOP` ;

-- -----------------------------------------------------
-- Table `back`.`admin_level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`admin_level` (
  `level_id` INT NOT NULL AUTO_INCREMENT,
  `level_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`level_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `back`.`admin_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`admin_status` (
  `status_id` INT NOT NULL AUTO_INCREMENT,
  `status_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `back`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`admin` (
  `admin_id` INT NOT NULL AUTO_INCREMENT,
  `admin_account` VARCHAR(45) NOT NULL,
  `admin_password` VARCHAR(45) NOT NULL,
  `admin_name` VARCHAR(45) NOT NULL,
  `admin_join` DATETIME NOT NULL,
  `admin_left` DATETIME NULL,
  `admin_level` INT NOT NULL DEFAULT 1,
  `admin_status` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`admin_id`),
  UNIQUE INDEX `admin_account_UNIQUE` (`admin_account` ASC) VISIBLE,
  INDEX `FK_admin_level_idx` (`admin_level` ASC) VISIBLE,
  INDEX `FK_admin_status_idx` (`admin_status` ASC) VISIBLE,
  CONSTRAINT `FK_admin_level`
    FOREIGN KEY (`admin_level`)
    REFERENCES `back`.`admin_level` (`level_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_admin_status`
    FOREIGN KEY (`admin_status`)
    REFERENCES `back`.`admin_status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `SHOP`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`order` (
  `ord_no` INT NOT NULL AUTO_INCREMENT COMMENT '????????????',
  `support_admin_id` INT NULL DEFAULT NULL COMMENT '???????????????ID',
  `user_id` INT NULL DEFAULT NULL COMMENT '??????ID',
  `ord_time` DATETIME NOT NULL COMMENT '????????????',
  `ord_status` VARCHAR(10) NOT NULL COMMENT '????????????',
  `ord_total` INT NOT NULL COMMENT '????????????',
  `ship_method` VARCHAR(10) NOT NULL COMMENT '????????????',
  `ship_fee` INT NOT NULL COMMENT '??????',
  `ship_info` VARCHAR(100) NOT NULL COMMENT '??????????????????email',
  PRIMARY KEY (`ord_no`),
  INDEX `fk_info_order_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_admin_order_idx` (`support_admin_id` ASC) VISIBLE,
  CONSTRAINT `fk_info_order`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_admin_order`
    FOREIGN KEY (`support_admin_id`)
    REFERENCES `back`.`admin` (`admin_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '??????';


-- -----------------------------------------------------
-- Table `SHOP`.`prod_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`prod_type` (
  `prod_type_no` INT NOT NULL COMMENT '??????????????????',
  `type_name` VARCHAR(10) NOT NULL COMMENT '??????????????????',
  PRIMARY KEY (`prod_type_no`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '????????????';


-- -----------------------------------------------------
-- Table `SHOP`.`prod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`prod` (
  `prod_id` INT NOT NULL AUTO_INCREMENT COMMENT '????????????',
  `prod_type_no` INT NULL DEFAULT NULL COMMENT '??????????????????',
  `prod_name` VARCHAR(80) NOT NULL COMMENT '????????????',
  `prod_text` MEDIUMTEXT NULL DEFAULT NULL COMMENT '????????????',
  `prod_on_time` DATETIME NOT NULL COMMENT '??????????????????',
  `prod_off_time` DATETIME NULL DEFAULT NULL COMMENT '??????????????????',
  `prod_status` TINYINT NOT NULL COMMENT '????????????',
  PRIMARY KEY (`prod_id`),
  INDEX `fk_prodType_prod` (`prod_type_no` ASC) VISIBLE,
  CONSTRAINT `fk_prodType_prod`
    FOREIGN KEY (`prod_type_no`)
    REFERENCES `SHOP`.`prod_type` (`prod_type_no`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '??????';


-- -----------------------------------------------------
-- Table `SHOP`.`prod_spec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`prod_spec` (
  `prod_spec_id` INT NOT NULL AUTO_INCREMENT COMMENT '??????????????????',
  `prod_id` INT NULL DEFAULT NULL COMMENT '????????????',
  `spec_name` VARCHAR(20) NOT NULL COMMENT '??????????????????',
  `stock` INT NOT NULL COMMENT '????????????',
  `prod_price` INT NOT NULL COMMENT '????????????',
  PRIMARY KEY (`prod_spec_id`),
  INDEX `fk_prod_prodSpec` (`prod_id` ASC) VISIBLE,
  CONSTRAINT `fk_prod_prodSpec`
    FOREIGN KEY (`prod_id`)
    REFERENCES `SHOP`.`prod` (`prod_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '????????????';


-- -----------------------------------------------------
-- Table `SHOP`.`order_prod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`order_prod` (
  `ord_prod_id` INT NOT NULL AUTO_INCREMENT COMMENT '???????????????',
  `ord_no` INT NULL DEFAULT NULL COMMENT '????????????',
  `prod_spec_id` INT NULL DEFAULT NULL COMMENT '??????????????????',
  `hist_prod_name` VARCHAR(80) NOT NULL COMMENT '??????????????????',
  `hist_prod_spec` VARCHAR(20) NOT NULL COMMENT '????????????????????????',
  `hist_prod_price` INT NOT NULL COMMENT '??????????????????',
  `prod_num` INT NOT NULL COMMENT '????????????',
  `hist_prod_pic` MEDIUMBLOB NULL DEFAULT NULL COMMENT '????????????',
  `eval_star` INT NULL DEFAULT NULL COMMENT '????????????',
  `eval_text` VARCHAR(200) NULL DEFAULT NULL COMMENT '????????????',
  `re_ex_reason` VARCHAR(10) NULL DEFAULT NULL COMMENT '???????????????',
  `re_ex_detail` VARCHAR(50) NULL DEFAULT NULL COMMENT '???????????????',
  `re_ex_price` INT NULL DEFAULT NULL COMMENT '???????????????',
  `re_ex_num` INT NULL DEFAULT NULL COMMENT '???????????????',
  `re_ex_pic` MEDIUMBLOB NULL DEFAULT NULL COMMENT '???????????????',
  PRIMARY KEY (`ord_prod_id`),
  INDEX `fk_order_orderProd` (`ord_no` ASC) VISIBLE,
  INDEX `fk_prodSpec_orderProd` (`prod_spec_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_orderProd`
    FOREIGN KEY (`ord_no`)
    REFERENCES `SHOP`.`order` (`ord_no`),
  CONSTRAINT `fk_prodSpec_orderProd`
    FOREIGN KEY (`prod_spec_id`)
    REFERENCES `SHOP`.`prod_spec` (`prod_spec_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '????????????';


-- -----------------------------------------------------
-- Table `SHOP`.`eval_pic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`eval_pic` (
  `eval_pic_id` INT NOT NULL AUTO_INCREMENT COMMENT '???????????????',
  `ord_prod_id` INT NULL DEFAULT NULL COMMENT '?????????????????????',
  `eval_pic` MEDIUMBLOB NOT NULL COMMENT '????????????',
  PRIMARY KEY (`eval_pic_id`),
  INDEX `fk_orderProd_evalPic` (`ord_prod_id` ASC) VISIBLE,
  CONSTRAINT `fk_orderProd_evalPic`
    FOREIGN KEY (`ord_prod_id`)
    REFERENCES `SHOP`.`order_prod` (`ord_prod_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '????????????';


-- -----------------------------------------------------
-- Table `SHOP`.`fav_prod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`fav_prod` (
  `prod_fav_id` INT NOT NULL AUTO_INCREMENT COMMENT '?????????????????????',
  `user_id` INT NULL DEFAULT NULL COMMENT '??????ID',
  `prod_id` INT NULL DEFAULT NULL COMMENT '????????????',
  PRIMARY KEY (`prod_fav_id`),
  INDEX `fk_prod_favProd` (`prod_id` ASC) VISIBLE,
  INDEX `fk_info_favProd_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_prod_favProd`
    FOREIGN KEY (`prod_id`)
    REFERENCES `SHOP`.`prod` (`prod_id`),
  CONSTRAINT `fk_info_favProd`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '????????????';


-- -----------------------------------------------------
-- Table `SHOP`.`prod_pics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`prod_pics` (
  `prod_pic_id` INT NOT NULL AUTO_INCREMENT COMMENT '?????????????????????',
  `prod_id` INT NOT NULL COMMENT '????????????',
  `prod_pic` MEDIUMBLOB NOT NULL COMMENT '????????????',
  PRIMARY KEY (`prod_pic_id`),
  INDEX `fk_prod_prodPics` (`prod_id` ASC) VISIBLE,
  CONSTRAINT `fk_prod_prodPics`
    FOREIGN KEY (`prod_id`)
    REFERENCES `SHOP`.`prod` (`prod_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '????????????';


-- -----------------------------------------------------
-- Table `SHOP`.`ship_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`ship_method` (
  `ship_no` INT NOT NULL COMMENT '??????????????????',
  `ship_name` VARCHAR(10) NOT NULL COMMENT '??????????????????',
  `ship_fee` INT NOT NULL COMMENT '??????',
  PRIMARY KEY (`ship_no`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '????????????/??????';


-- -----------------------------------------------------
-- Table `SHOP`.`prod_ships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`prod_ships` (
  `prod_ship_id` INT NOT NULL AUTO_INCREMENT COMMENT '??????????????????',
  `prod_id` INT NULL DEFAULT NULL COMMENT '????????????',
  `ship_no` INT NULL DEFAULT NULL COMMENT '??????????????????',
  PRIMARY KEY (`prod_ship_id`),
  INDEX `fk_shipMethod_prodShip` (`ship_no` ASC) VISIBLE,
  CONSTRAINT `fk_shipMethod_prodShip`
    FOREIGN KEY (`ship_no`)
    REFERENCES `SHOP`.`ship_method` (`ship_no`),
  CONSTRAINT `fk_prod_prodShips`
    FOREIGN KEY (`prod_ship_id`)
    REFERENCES `SHOP`.`prod` (`prod_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '??????????????????';


-- -----------------------------------------------------
-- Table `SHOP`.`shop_cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`shop_cart` (
  `cart_id` INT NOT NULL AUTO_INCREMENT COMMENT '??????????????????',
  `prod_spec_id` INT NULL DEFAULT NULL COMMENT '??????????????????',
  `user_id` INT NULL DEFAULT NULL COMMENT '??????ID',
  `prod_num` INT NOT NULL COMMENT '??????',
  PRIMARY KEY (`cart_id`),
  INDEX `fk_prodSpec_shopCart` (`prod_spec_id` ASC) VISIBLE,
  INDEX `fk_info_shopCart_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_prodSpec_shopCart`
    FOREIGN KEY (`prod_spec_id`)
    REFERENCES `SHOP`.`prod_spec` (`prod_spec_id`),
  CONSTRAINT `fk_info_shopCart`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '???????????????';

USE `back` ;

-- -----------------------------------------------------
-- Table `back`.`ord_msg`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`ord_msg` (
  `message_id` INT NOT NULL AUTO_INCREMENT,
  `ord_no` INT NOT NULL,
  `message` VARCHAR(45) NOT NULL,
  `message_owner` TINYINT NOT NULL,
  `message_time` DATETIME NOT NULL,
  PRIMARY KEY (`message_id`),
  INDEX `FK_ord_no_idx` (`ord_no` ASC) VISIBLE,
  CONSTRAINT `FK_ord_no`
    FOREIGN KEY (`ord_no`)
    REFERENCES `SHOP`.`order` (`ord_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `back`.`report_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`report_type` (
  `type_id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `back`.`object_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`object_type` (
  `type_id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `back`.`report_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`report_status` (
  `status_id` INT NOT NULL AUTO_INCREMENT,
  `status_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `back`.`report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`report` (
  `report_no` INT NOT NULL AUTO_INCREMENT,
  `object_type` INT NOT NULL,
  `reporter_id` INT NOT NULL,
  `object_id` INT NOT NULL,
  `report_type` INT NULL,
  `report_status` INT NOT NULL DEFAULT 1,
  `report_description` VARCHAR(250) NULL,
  `report_time` DATETIME NOT NULL,
  `execute_time` DATETIME NULL,
  PRIMARY KEY (`report_no`),
  INDEX `FK_s_object_type_idx` (`object_type` ASC) VISIBLE,
  INDEX `FK_reporter_id_idx` (`reporter_id` ASC) VISIBLE,
  INDEX `FK_report)type_idx` (`report_type` ASC) VISIBLE,
  INDEX `FK_report_status_idx` (`report_status` ASC) VISIBLE,
  CONSTRAINT `FK_report_object_type`
    FOREIGN KEY (`object_type`)
    REFERENCES `back`.`object_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_reporter_id`
    FOREIGN KEY (`reporter_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_report_type`
    FOREIGN KEY (`report_type`)
    REFERENCES `back`.`report_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_report_status`
    FOREIGN KEY (`report_status`)
    REFERENCES `back`.`report_status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

USE `chat` ;

-- -----------------------------------------------------
-- Table `chat`.`group_chat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chat`.`group_chat` (
  `chat_no` INT NOT NULL AUTO_INCREMENT,
  `chat_theme_no` INT NULL DEFAULT NULL,
  `chat_leader` INT NULL DEFAULT NULL,
  `chat_name` INT NULL DEFAULT NULL,
  `chat_theme` VARCHAR(45) NULL,
  INDEX `fk_chat_leader_id_idx` (`chat_leader` ASC) VISIBLE,
  PRIMARY KEY (`chat_no`),
  CONSTRAINT `fk_chat_leader_id`
    FOREIGN KEY (`chat_leader`)
    REFERENCES `Center`.`info` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `chat`.`chat_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chat`.`chat_member` (
  `member_id` INT NOT NULL AUTO_INCREMENT,
  `chat_no` INT NULL DEFAULT NULL,
  `user_id` INT NULL DEFAULT NULL,
  `join_time` DATETIME NULL DEFAULT NULL,
  `leave_time` DATETIME NULL DEFAULT NULL,
  `user_mode` INT NULL DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  INDEX `fk_chat_no_idx` (`chat_no` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_chat_no`
    FOREIGN KEY (`chat_no`)
    REFERENCES `chat`.`group_chat` (`chat_no`),
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `chat`.`friend`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chat`.`friend` (
  `friend_list_id` INT NOT NULL AUTO_INCREMENT,
  `friend_id` INT NULL DEFAULT NULL,
  `user_id` INT NULL DEFAULT NULL,
  `friend_mode` INT NULL DEFAULT NULL,
  PRIMARY KEY (`friend_list_id`),
  INDEX `fk_friend_id_idx` (`friend_id` ASC) VISIBLE,
  CONSTRAINT `f_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`),
  CONSTRAINT `fk_friend_id`
    FOREIGN KEY (`friend_id`)
    REFERENCES `Center`.`info` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `chat`.`group_message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chat`.`group_message` (
  `message_no` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL DEFAULT NULL,
  `message_time` DATETIME NULL DEFAULT NULL,
  `message_date` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `fk_user_id_idx` (`user_id` ASC) VISIBLE,
  PRIMARY KEY (`message_no`),
  CONSTRAINT `fk_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `chat`.`s_message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chat`.`s_message` (
  `s_message_no` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL DEFAULT NULL,
  `c_no` INT NULL DEFAULT NULL,
  `message_time` DATETIME NULL DEFAULT NULL,
  `message_data` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`s_message_no`),
  INDEX `fk_c_no_idx` (`c_no` ASC) VISIBLE,
  INDEX `s_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_c_no`
    FOREIGN KEY (`c_no`)
    REFERENCES `chat`.`friend` (`friend_list_id`),
  CONSTRAINT `s_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

USE `group1` ;

-- -----------------------------------------------------
-- Table `group1`.`type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`type` (
  `g_type_no` INT NOT NULL AUTO_INCREMENT COMMENT '??????????????????',
  `g_type` VARCHAR(45) NOT NULL COMMENT '????????????',
  PRIMARY KEY (`g_type_no`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `group1`.`group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`group` (
  `g_no` INT NOT NULL AUTO_INCREMENT COMMENT '????????????',
  `g_name` VARCHAR(50) NOT NULL COMMENT '????????????',
  `g_type_no` INT NOT NULL COMMENT '??????????????????',
  `g_content` VARCHAR(200) NOT NULL COMMENT '????????????',
  `g_start_time` DATETIME NOT NULL COMMENT '??????????????????',
  `g_end_time` DATETIME NOT NULL COMMENT '??????????????????',
  `apply_start_time` DATETIME NOT NULL COMMENT '??????????????????',
  `apply_end_time` DATETIME NOT NULL COMMENT '??????????????????',
  `place` VARCHAR(50) NOT NULL COMMENT '??????',
  `number_lower` INT NOT NULL COMMENT '????????????',
  `number_upper` INT NULL DEFAULT NULL COMMENT '????????????',
  `number_total` INT NULL DEFAULT NULL COMMENT '?????????',
  `user_id` INT NOT NULL COMMENT '?????????',
  `introduce` VARCHAR(200) NOT NULL COMMENT '?????????????????????',
  `phone` VARCHAR(10) NULL DEFAULT NULL COMMENT '???????????????',
  `email` VARCHAR(1000) NULL DEFAULT NULL COMMENT '?????????EMAIL',
  `state_no` INT NOT NULL COMMENT '????????? 0:?????? 1:?????????2:?????? 3:??????',
  `g_flow_cause` VARCHAR(200) NULL DEFAULT NULL COMMENT '????????????',
  `photo` MEDIUMBLOB NULL DEFAULT NULL COMMENT '????????????',
  `g_url` VARCHAR(400) NULL DEFAULT NULL,
  PRIMARY KEY (`g_no`),
  INDEX `FK_gTypeNo_idx` (`g_type_no` ASC) VISIBLE,
  INDEX `FK_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `FK_g_type_no`
    FOREIGN KEY (`g_type_no`)
    REFERENCES `group1`.`type` (`g_type_no`),
  CONSTRAINT `FK_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `group1`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`comment` (
  `comment_no` INT NOT NULL AUTO_INCREMENT COMMENT '??????????????????',
  `user_id` INT NOT NULL COMMENT '?????????',
  `comment_time` DATETIME NOT NULL COMMENT '????????????',
  `comment` VARCHAR(200) NOT NULL COMMENT '????????????',
  `g_no` INT NOT NULL COMMENT '????????????',
  PRIMARY KEY (`comment_no`),
  INDEX `FK_gNo_idx` (`g_no` ASC) VISIBLE,
  INDEX `FK_comment_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `FK_comment_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`),
  CONSTRAINT `FK_reply_gno`
    FOREIGN KEY (`g_no`)
    REFERENCES `group1`.`group` (`g_no`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `group1`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`member` (
  `join_no` INT NOT NULL AUTO_INCREMENT COMMENT '??????????????????',
  `role` INT NOT NULL COMMENT '0:??????1:??????',
  `user_id` INT NOT NULL COMMENT '????????????',
  `g_no` INT NOT NULL COMMENT '????????????',
  `join_time` DATETIME NOT NULL COMMENT '????????????',
  PRIMARY KEY (`join_no`),
  INDEX `FK_gNo_idx` (`g_no` ASC) VISIBLE,
  INDEX `FK_member_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `FK_member_gno`
    FOREIGN KEY (`g_no`)
    REFERENCES `group1`.`group` (`g_no`),
  CONSTRAINT `FK_member_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `group1`.`reply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`reply` (
  `reply_no` INT NOT NULL AUTO_INCREMENT COMMENT '??????????????????',
  `user_id` INT NOT NULL COMMENT '?????????',
  `reply` VARCHAR(200) NOT NULL,
  `reply_time` DATETIME NOT NULL,
  `comment_no` INT NOT NULL,
  PRIMARY KEY (`reply_no`),
  INDEX `FK_commentNo_idx` (`comment_no` ASC) VISIBLE,
  INDEX `FK_reply_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `FK_comment_no`
    FOREIGN KEY (`comment_no`)
    REFERENCES `group1`.`comment` (`comment_no`),
  CONSTRAINT `FK_reply_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

USE `Forum` ;

-- -----------------------------------------------------
-- Table `Forum`.`article_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Forum`.`article_type` (
  `article_type_num` INT NOT NULL AUTO_INCREMENT COMMENT '??????????????????',
  `article_type_name` VARCHAR(10) NOT NULL COMMENT '??????????????????',
  PRIMARY KEY (`article_type_num`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Forum`.`article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Forum`.`article` (
  `article_id` INT NOT NULL AUTO_INCREMENT COMMENT '????????????',
  `user_id` INT NOT NULL COMMENT '?????????ID',
  `article_type_num` INT NOT NULL COMMENT '??????????????????',
  `title` VARCHAR(10) NOT NULL COMMENT '????????????',
  `article_content` VARCHAR(50) NOT NULL COMMENT '????????????',
  `article_time` DATETIME NOT NULL COMMENT '????????????',
  `pageviews` INT NULL COMMENT '????????????',
  `article_num_count` INT NULL COMMENT '????????????',
  `article_status` VARCHAR(50) NOT NULL COMMENT '????????????',
  PRIMARY KEY (`article_id`),
  INDEX `article_type_num_idx` (`article_type_num` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `FK_article_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `article_type_num`
    FOREIGN KEY (`article_type_num`)
    REFERENCES `Forum`.`article_type` (`article_type_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Forum`.`reply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Forum`.`reply` (
  `reply_id` INT NOT NULL AUTO_INCREMENT COMMENT '????????????',
  `article_id` INT NOT NULL COMMENT '????????????',
  `reply_user_id` INT NOT NULL COMMENT '?????????',
  `reply_content` VARCHAR(50) NOT NULL COMMENT '????????????',
  `reply_time` DATETIME NOT NULL COMMENT '????????????',
  `reply_like_count` INT NULL COMMENT '????????????',
  `reply_status` VARCHAR(50) NOT NULL COMMENT '????????????',
  `lastreplytime` DATETIME NOT NULL COMMENT '??????????????????',
  INDEX `article_id_idx` (`article_id` ASC) VISIBLE,
  PRIMARY KEY (`reply_id`),
  INDEX `reply_user_id_idx` (`reply_user_id` ASC) VISIBLE,
  CONSTRAINT `FK_comment_article_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `Forum`.`article` (`article_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_comment_reply_user_id`
    FOREIGN KEY (`reply_user_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Forum`.`article_like`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Forum`.`article_like` (
  `like_id` INT NOT NULL AUTO_INCREMENT COMMENT '????????????',
  `user_id` INT NOT NULL COMMENT '?????????',
  `article_id` INT NOT NULL COMMENT '????????????',
  `like_time` DATETIME NOT NULL COMMENT '?????????',
  PRIMARY KEY (`like_id`),
  INDEX `article_id_idx` (`article_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `article_like_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `article_like_article_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `Forum`.`article` (`article_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Forum`.`reply_like`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Forum`.`reply_like` (
  `like_id` INT NOT NULL AUTO_INCREMENT COMMENT '????????????',
  `user_id` INT NOT NULL COMMENT '?????????',
  `reply_id` INT NOT NULL COMMENT '????????????',
  `like_time` DATETIME NOT NULL COMMENT '?????????\n',
  PRIMARY KEY (`like_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `comment_like_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `comment_like_reply_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Forum`.`article_picture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Forum`.`article_picture` (
  `pic_id` INT NOT NULL AUTO_INCREMENT COMMENT '???????????????',
  `article_id` INT NOT NULL COMMENT '????????????',
  `image` MEDIUMBLOB NULL,
  PRIMARY KEY (`pic_id`),
  INDEX `article_id_idx` (`article_id` ASC) VISIBLE,
  CONSTRAINT `FK_picture_article_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `Forum`.`article` (`article_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
