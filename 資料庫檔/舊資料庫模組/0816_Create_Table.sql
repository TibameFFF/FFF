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
-- Table `back`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`admin` (
  `admin_id` INT NOT NULL AUTO_INCREMENT,
  `admin_account` VARCHAR(45) NOT NULL,
  `admin_password` VARCHAR(45) NOT NULL,
  `admin_name` VARCHAR(45) NOT NULL,
  `admin_join` DATETIME NOT NULL,
  `admin_left` DATETIME NULL,
  `admin_level` TINYINT NOT NULL,
  `admin_status` TINYINT NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE INDEX `admin_account_UNIQUE` (`admin_account` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `SHOP`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`order` (
  `ord_no` INT NOT NULL AUTO_INCREMENT COMMENT '訂單編號',
  `support_admin_id` INT NULL DEFAULT NULL COMMENT '客服管理員ID',
  `user_id` INT NULL DEFAULT NULL COMMENT '會員ID',
  `ord_time` DATETIME NOT NULL COMMENT '購買時間',
  `ord_status` VARCHAR(10) NOT NULL COMMENT '訂單狀態',
  `ord_total` INT NOT NULL COMMENT '訂單金額',
  `ship_method` VARCHAR(10) NOT NULL COMMENT '運送方式',
  `ship_fee` INT NOT NULL COMMENT '運費',
  `ship_info` VARCHAR(100) NOT NULL COMMENT '姓名電話地址email',
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
COMMENT = '訂單';


-- -----------------------------------------------------
-- Table `SHOP`.`prod_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`prod_type` (
  `prod_type_no` INT NOT NULL COMMENT '商品類別編號',
  `type_name` VARCHAR(10) NOT NULL COMMENT '商品類別名稱',
  PRIMARY KEY (`prod_type_no`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '商品類別';


-- -----------------------------------------------------
-- Table `SHOP`.`prod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`prod` (
  `prod_id` INT NOT NULL AUTO_INCREMENT COMMENT '商品編號',
  `prod_type_no` INT NULL DEFAULT NULL COMMENT '商品類別編號',
  `prod_name` VARCHAR(80) NOT NULL COMMENT '商品名稱',
  `prod_text` MEDIUMTEXT NULL DEFAULT NULL COMMENT '商品詳情',
  `prod_on_time` DATETIME NOT NULL COMMENT '商品上架時間',
  `prod_off_time` DATETIME NULL DEFAULT NULL COMMENT '商品下架時間',
  `prod_status` TINYINT NOT NULL COMMENT '上架狀態',
  PRIMARY KEY (`prod_id`),
  INDEX `fk_prodType_prod` (`prod_type_no` ASC) VISIBLE,
  CONSTRAINT `fk_prodType_prod`
    FOREIGN KEY (`prod_type_no`)
    REFERENCES `SHOP`.`prod_type` (`prod_type_no`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '商品';


-- -----------------------------------------------------
-- Table `SHOP`.`prod_spec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`prod_spec` (
  `prod_spec_id` INT NOT NULL AUTO_INCREMENT COMMENT '商品規格編號',
  `prod_id` INT NULL DEFAULT NULL COMMENT '商品編號',
  `spec_name` VARCHAR(20) NOT NULL COMMENT '商品規格名稱',
  `stock` INT NOT NULL COMMENT '商品數量',
  `prod_price` INT NOT NULL COMMENT '商品價格',
  PRIMARY KEY (`prod_spec_id`),
  INDEX `fk_prod_prodSpec` (`prod_id` ASC) VISIBLE,
  CONSTRAINT `fk_prod_prodSpec`
    FOREIGN KEY (`prod_id`)
    REFERENCES `SHOP`.`prod` (`prod_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '商品規格';


-- -----------------------------------------------------
-- Table `SHOP`.`order_prod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`order_prod` (
  `ord_prod_id` INT NOT NULL AUTO_INCREMENT COMMENT '商品流水號',
  `ord_no` INT NULL DEFAULT NULL COMMENT '訂單編號',
  `prod_spec_id` INT NULL DEFAULT NULL COMMENT '商品規格編號',
  `hist_prod_name` VARCHAR(80) NOT NULL COMMENT '歷史商品名稱',
  `hist_prod_spec` VARCHAR(20) NOT NULL COMMENT '歷史商品規格名稱',
  `hist_prod_price` INT NOT NULL COMMENT '歷史商品價格',
  `prod_num` INT NOT NULL COMMENT '商品數量',
  `hist_prod_pic` MEDIUMBLOB NULL DEFAULT NULL COMMENT '商品縮圖',
  `eval_star` INT NULL DEFAULT NULL COMMENT '評價星數',
  `eval_text` VARCHAR(200) NULL DEFAULT NULL COMMENT '評論內容',
  `re_ex_reason` VARCHAR(10) NULL DEFAULT NULL COMMENT '退換貨原因',
  `re_ex_detail` VARCHAR(50) NULL DEFAULT NULL COMMENT '退換貨詳情',
  `re_ex_price` INT NULL DEFAULT NULL COMMENT '退換貨金額',
  `re_ex_num` INT NULL DEFAULT NULL COMMENT '退換貨數量',
  `re_ex_pic` MEDIUMBLOB NULL DEFAULT NULL COMMENT '退換貨圖片',
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
COMMENT = '訂單商品';


-- -----------------------------------------------------
-- Table `SHOP`.`eval_pic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`eval_pic` (
  `eval_pic_id` INT NOT NULL AUTO_INCREMENT COMMENT '圖片流水號',
  `ord_prod_id` INT NULL DEFAULT NULL COMMENT '訂單商品流水號',
  `eval_pic` MEDIUMBLOB NOT NULL COMMENT '評價圖片',
  PRIMARY KEY (`eval_pic_id`),
  INDEX `fk_orderProd_evalPic` (`ord_prod_id` ASC) VISIBLE,
  CONSTRAINT `fk_orderProd_evalPic`
    FOREIGN KEY (`ord_prod_id`)
    REFERENCES `SHOP`.`order_prod` (`ord_prod_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '評價圖片';


-- -----------------------------------------------------
-- Table `SHOP`.`fav_prod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`fav_prod` (
  `prod_fav_id` INT NOT NULL AUTO_INCREMENT COMMENT '收藏商品流水號',
  `user_id` INT NULL DEFAULT NULL COMMENT '會員ID',
  `prod_id` INT NULL DEFAULT NULL COMMENT '商品編號',
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
COMMENT = '收藏商品';


-- -----------------------------------------------------
-- Table `SHOP`.`prod_pics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`prod_pics` (
  `prod_pic_id` INT NOT NULL AUTO_INCREMENT COMMENT '商品圖片流水號',
  `prod_id` INT NOT NULL COMMENT '商品編號',
  `prod_pic` MEDIUMBLOB NOT NULL COMMENT '商品圖片',
  PRIMARY KEY (`prod_pic_id`),
  INDEX `fk_prod_prodPics` (`prod_id` ASC) VISIBLE,
  CONSTRAINT `fk_prod_prodPics`
    FOREIGN KEY (`prod_id`)
    REFERENCES `SHOP`.`prod` (`prod_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '商品圖片';


-- -----------------------------------------------------
-- Table `SHOP`.`ship_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`ship_method` (
  `ship_no` INT NOT NULL COMMENT '運送方式編號',
  `ship_name` VARCHAR(10) NOT NULL COMMENT '運送方式名稱',
  `ship_fee` INT NOT NULL COMMENT '運費',
  PRIMARY KEY (`ship_no`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '運送方式/運費';


-- -----------------------------------------------------
-- Table `SHOP`.`prod_ships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`prod_ships` (
  `prod_ship_id` INT NOT NULL AUTO_INCREMENT COMMENT '運送流水編號',
  `prod_id` INT NULL DEFAULT NULL COMMENT '商品編號',
  `ship_no` INT NULL DEFAULT NULL COMMENT '運送方式編號',
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
COMMENT = '商品運送資訊';


-- -----------------------------------------------------
-- Table `SHOP`.`shop_cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SHOP`.`shop_cart` (
  `cart_id` INT NOT NULL AUTO_INCREMENT COMMENT '購物車流水號',
  `prod_spec_id` INT NULL DEFAULT NULL COMMENT '商品規格編號',
  `user_id` INT NULL DEFAULT NULL COMMENT '會員ID',
  `prod_num` INT NOT NULL COMMENT '數量',
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
COMMENT = '購物車商品';

USE `back` ;

-- -----------------------------------------------------
-- Table `Forum`.`article_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Forum`.`article_type` (
  `article_type_num` INT NOT NULL AUTO_INCREMENT COMMENT '文章分類編號',
  `article_type_name` VARCHAR(10) NOT NULL COMMENT '文章分類名稱',
  PRIMARY KEY (`article_type_num`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Forum`.`article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Forum`.`article` (
  `article_id` INT NOT NULL AUTO_INCREMENT COMMENT '文章編號',
  `user_id` INT NOT NULL COMMENT '發文者ID',
  `article_type_num` INT NOT NULL COMMENT '文章分類編號',
  `title` VARCHAR(10) NOT NULL COMMENT '文章標題',
  `article_content` VARCHAR(50) NOT NULL COMMENT '文章內容',
  `article_time` DATETIME NOT NULL COMMENT '發文時間',
  `pageviews` INT NULL COMMENT '瀏覽次數',
  `article_num_count` INT NULL COMMENT '案讚次數',
  `article_status` VARCHAR(50) NOT NULL COMMENT '文章狀態',
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
-- Table `back`.`report_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`report_type` (
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
-- Table `back`.`article_report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`article_report` (
  `report_no` INT NOT NULL AUTO_INCREMENT,
  `reporter_id` INT NOT NULL,
  `article_id` INT NOT NULL,
  `report_type` INT NOT NULL,
  `report_status` INT NOT NULL,
  `report_description` VARCHAR(45) NULL DEFAULT NULL,
  `report_time` DATETIME NOT NULL,
  PRIMARY KEY (`report_no`),
  INDEX `FK_article_reporter_idx` (`reporter_id` ASC) VISIBLE,
  INDEX `FK_article_id_idx` (`article_id` ASC) VISIBLE,
  INDEX `FK_article_report_type_idx` (`report_type` ASC) VISIBLE,
  INDEX `FK_article_report_status_idx` (`report_status` ASC) VISIBLE,
  CONSTRAINT `FK_article_reporter`
    FOREIGN KEY (`reporter_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_article_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `Forum`.`article` (`article_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_article_report_type`
    FOREIGN KEY (`report_type`)
    REFERENCES `back`.`report_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_article_report_status`
    FOREIGN KEY (`report_status`)
    REFERENCES `back`.`report_status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `group1`.`type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group1`.`type` (
  `g_type_no` INT NOT NULL AUTO_INCREMENT COMMENT '活動類型編號',
  `g_type` VARCHAR(45) NOT NULL COMMENT '活動類型',
  PRIMARY KEY (`g_type_no`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


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
  `number_upper` INT NULL DEFAULT NULL COMMENT '人數上限',
  `number_total` INT NULL DEFAULT NULL COMMENT '總人數',
  `user_id` INT NOT NULL COMMENT '開團者',
  `introduce` VARCHAR(200) NOT NULL COMMENT '開團者自我介紹',
  `phone` VARCHAR(10) NULL DEFAULT NULL COMMENT '開團者手機',
  `email` VARCHAR(1000) NULL DEFAULT NULL COMMENT '開團者EMAIL',
  `state_no` INT NOT NULL COMMENT '狀態碼 0:流團 1:開團中2:成團 3:結束',
  `g_flow_cause` VARCHAR(200) NULL DEFAULT NULL COMMENT '流團員因',
  `photo` MEDIUMBLOB NULL DEFAULT NULL COMMENT '活動照片',
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
-- Table `back`.`group_report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`group_report` (
  `report_no` INT NOT NULL AUTO_INCREMENT,
  `reporter_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  `report_type` INT NOT NULL,
  `report_status` INT NOT NULL,
  `report_description` VARCHAR(45) NULL,
  `report_time` DATETIME NOT NULL,
  PRIMARY KEY (`report_no`),
  INDEX `FK_group_reporter_idx` (`reporter_id` ASC) VISIBLE,
  INDEX `FK_group_id_idx` (`group_id` ASC) VISIBLE,
  INDEX `FK_report_type_idx` (`report_type` ASC) VISIBLE,
  INDEX `FK_g_report_type_idx` (`report_status` ASC) VISIBLE,
  CONSTRAINT `FK_group_reporter`
    FOREIGN KEY (`reporter_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_group_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `group1`.`group` (`g_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_g_report_type`
    FOREIGN KEY (`report_type`)
    REFERENCES `back`.`report_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_g_report_status`
    FOREIGN KEY (`report_status`)
    REFERENCES `back`.`report_status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
-- Table `back`.`groupchat_report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`groupchat_report` (
  `report_no` INT NOT NULL AUTO_INCREMENT,
  `reporter_id` INT NOT NULL,
  `message_no` INT NOT NULL,
  `report_type` INT NOT NULL,
  `report_status` INT NOT NULL,
  `report_description` VARCHAR(45) NULL DEFAULT NULL,
  `report_time` DATETIME NOT NULL,
  PRIMARY KEY (`report_no`, `report_time`),
  INDEX `FK_groupchat_reporter_idx` (`reporter_id` ASC) VISIBLE,
  INDEX `FK_message_no_idx` (`message_no` ASC) VISIBLE,
  INDEX `FK_report_type_idx` (`report_type` ASC) VISIBLE,
  INDEX `FK_gc_report_status_idx` (`report_status` ASC) VISIBLE,
  CONSTRAINT `FK_groupchat_reporter`
    FOREIGN KEY (`reporter_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_g_message_no`
    FOREIGN KEY (`message_no`)
    REFERENCES `chat`.`group_message` (`message_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_gc_report_type`
    FOREIGN KEY (`report_type`)
    REFERENCES `back`.`report_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_gc_report_status`
    FOREIGN KEY (`report_status`)
    REFERENCES `back`.`report_status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `back`.`intro_report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`intro_report` (
  `report_no` INT NOT NULL AUTO_INCREMENT,
  `reporter_id` INT NOT NULL,
  `reported_id` INT NOT NULL,
  `report_type` INT NOT NULL,
  `report_status` INT NOT NULL,
  `report_description` VARCHAR(45) NULL DEFAULT NULL,
  `report_time` DATETIME NOT NULL,
  PRIMARY KEY (`report_no`),
  INDEX `FK_intro_reporter_idx` (`reporter_id` ASC) VISIBLE,
  INDEX `FK_report_type_idx` (`report_type` ASC) VISIBLE,
  INDEX `FK_i_report_status_idx` (`report_status` ASC) VISIBLE,
  CONSTRAINT `FK_intro_reporter`
    FOREIGN KEY (`reporter_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_intro_reported`
    FOREIGN KEY (`report_no`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_i_report_type`
    FOREIGN KEY (`report_type`)
    REFERENCES `back`.`report_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_i_report_status`
    FOREIGN KEY (`report_status`)
    REFERENCES `back`.`report_status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


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
-- Table `Forum`.`reply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Forum`.`reply` (
  `reply_id` INT NOT NULL AUTO_INCREMENT COMMENT '留言編號',
  `article_id` INT NOT NULL COMMENT '文章編號',
  `reply_user_id` INT NOT NULL COMMENT '留言者',
  `reply_content` VARCHAR(50) NOT NULL COMMENT '留言內容',
  `reply_time` DATETIME NOT NULL COMMENT '留言時間',
  `reply_like_count` INT NULL COMMENT '案讚次數',
  `reply_status` VARCHAR(50) NOT NULL COMMENT '留言狀態',
  `lastreplytime` DATETIME NOT NULL COMMENT '最後回文時間',
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
-- Table `back`.`reply_report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`reply_report` (
  `report_no` INT NOT NULL AUTO_INCREMENT,
  `reporter_id` INT NOT NULL,
  `reply_id` INT NOT NULL,
  `report_type` INT NOT NULL,
  `report_status` INT NOT NULL,
  `report_description` VARCHAR(45) NULL DEFAULT NULL,
  `report_time` DATETIME NOT NULL,
  PRIMARY KEY (`report_no`),
  INDEX `FK_reply_reporter_idx` (`reporter_id` ASC) VISIBLE,
  INDEX `FK_reply_id_idx` (`reply_id` ASC) VISIBLE,
  INDEX `FK_reply_report_type_idx` (`report_type` ASC) VISIBLE,
  INDEX `FK_reply_report_status_idx` (`report_status` ASC) VISIBLE,
  CONSTRAINT `FK_reply_reporter`
    FOREIGN KEY (`reporter_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_reply_id`
    FOREIGN KEY (`reply_id`)
    REFERENCES `Forum`.`reply` (`reply_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_reply_report_type`
    FOREIGN KEY (`report_type`)
    REFERENCES `back`.`report_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_reply_report_status`
    FOREIGN KEY (`report_status`)
    REFERENCES `back`.`report_status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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


-- -----------------------------------------------------
-- Table `back`.`singlechat_report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `back`.`singlechat_report` (
  `report_no` INT NOT NULL AUTO_INCREMENT,
  `reporter_id` INT NOT NULL,
  `message_no` INT NOT NULL,
  `report_type` INT NOT NULL,
  `report_status` INT NOT NULL,
  `report_description` VARCHAR(45) NULL DEFAULT NULL,
  `report_time` DATETIME NOT NULL,
  PRIMARY KEY (`report_no`),
  INDEX `FK_singlechat_reporter_idx` (`reporter_id` ASC) VISIBLE,
  INDEX `FK_message_no_idx` (`message_no` ASC) VISIBLE,
  INDEX `FK_report_type_idx` (`report_type` ASC) VISIBLE,
  INDEX `FK_s_report_status_idx` (`report_status` ASC) VISIBLE,
  CONSTRAINT `FK_singlechat_reporter`
    FOREIGN KEY (`reporter_id`)
    REFERENCES `Center`.`info` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_s_message_no`
    FOREIGN KEY (`message_no`)
    REFERENCES `chat`.`s_message` (`s_message_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_s_report_type`
    FOREIGN KEY (`report_type`)
    REFERENCES `back`.`report_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_s_report_status`
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

USE `group1` ;

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
  `join_no` INT NOT NULL AUTO_INCREMENT COMMENT '加入團員編號',
  `role` INT NOT NULL COMMENT '0:組長1:組員',
  `user_id` INT NOT NULL COMMENT '會員帳號',
  `g_no` INT NOT NULL COMMENT '活動編號',
  `join_time` DATETIME NOT NULL COMMENT '加入時間',
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
  `reply_no` INT NOT NULL AUTO_INCREMENT COMMENT '活動回覆編號',
  `user_id` INT NOT NULL COMMENT '回覆者',
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
-- Table `Forum`.`article_like`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Forum`.`article_like` (
  `like_id` INT NOT NULL AUTO_INCREMENT COMMENT '案讚編號',
  `user_id` INT NOT NULL COMMENT '案讚者',
  `article_id` INT NOT NULL COMMENT '文章編號',
  `like_time` DATETIME NOT NULL COMMENT '讚時間',
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
  `like_id` INT NOT NULL AUTO_INCREMENT COMMENT '案讚編號',
  `user_id` INT NOT NULL COMMENT '案讚者',
  `reply_id` INT NOT NULL COMMENT '留言編號',
  `like_time` DATETIME NOT NULL COMMENT '讚時間\n',
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
  `pic_id` INT NOT NULL AUTO_INCREMENT COMMENT '圖片流水號',
  `article_id` INT NOT NULL COMMENT '文章編號',
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
