-- -----------------------------------------------------
-- DROP ALL SCEHMA
-- -----------------------------------------------------

SET foreign_key_checks = 0;

drop schema IF EXISTS center;
drop schema IF EXISTS back;
drop schema IF EXISTS shop;
drop schema IF EXISTS forum;
drop schema IF EXISTS chat;
drop schema IF EXISTS group1;

SET foreign_key_checks = 1;


-- -----------------------------------------------------
-- CREATE ALL SCEHMA
-- -----------------------------------------------------

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



-- Schema Center
CREATE SCHEMA IF NOT EXISTS `Center` DEFAULT CHARACTER SET utf8mb4 ;

-- Schema SHOP
CREATE SCHEMA IF NOT EXISTS `SHOP` DEFAULT CHARACTER SET utf8mb4 ;

-- Schema back
CREATE SCHEMA IF NOT EXISTS `back` DEFAULT CHARACTER SET utf8mb4 ;

-- Schema chat
CREATE SCHEMA IF NOT EXISTS `chat` DEFAULT CHARACTER SET utf8mb4 ;

-- Schema group1
CREATE SCHEMA IF NOT EXISTS `group1` DEFAULT CHARACTER SET utf8mb4 ;

-- Schema Forum
CREATE SCHEMA IF NOT EXISTS `Forum` DEFAULT CHARACTER SET utf8mb4 ;


USE `Center` ;
-- Table `Center`.`info`
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


-- Table `Center`.`block_list`
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

-- Table `back`.`admin`
CREATE TABLE IF NOT EXISTS `back`.`admin` (
  `admin_id` INT NOT NULL AUTO_INCREMENT,
  `admin_account` VARCHAR(45) NOT NULL,
  `admin_password` VARCHAR(45) NOT NULL,
  `admin_name` VARCHAR(45) NOT NULL,
  `admin_join` DATETIME NOT NULL,
  `admin_left` DATETIME NOT NULL,
  `admin_level` TINYINT NOT NULL,
  `admin_status` TINYINT NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE INDEX `admin_account_UNIQUE` (`admin_account` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- Table `SHOP`.`order`
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


-- Table `SHOP`.`prod_type`
CREATE TABLE IF NOT EXISTS `SHOP`.`prod_type` (
  `prod_type_no` INT NOT NULL COMMENT '商品類別編號',
  `type_name` VARCHAR(10) NOT NULL COMMENT '商品類別名稱',
  PRIMARY KEY (`prod_type_no`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '商品類別';


-- Table `SHOP`.`prod`
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


-- Table `SHOP`.`prod_spec`
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


-- Table `SHOP`.`order_prod`
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


-- Table `SHOP`.`eval_pic`
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


-- Table `SHOP`.`fav_prod`
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


-- Table `SHOP`.`prod_pics`
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


-- Table `SHOP`.`ship_method`
CREATE TABLE IF NOT EXISTS `SHOP`.`ship_method` (
  `ship_no` INT NOT NULL COMMENT '運送方式編號',
  `ship_name` VARCHAR(10) NOT NULL COMMENT '運送方式名稱',
  `ship_fee` INT NOT NULL COMMENT '運費',
  PRIMARY KEY (`ship_no`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '運送方式/運費';


-- Table `SHOP`.`prod_ships`
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


-- Table `SHOP`.`shop_cart`
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

-- Table `Forum`.`article_type`
CREATE TABLE IF NOT EXISTS `Forum`.`article_type` (
  `article_type_num` INT NOT NULL AUTO_INCREMENT COMMENT '文章分類編號',
  `article_type_name` VARCHAR(10) NOT NULL COMMENT '文章分類名稱',
  PRIMARY KEY (`article_type_num`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- Table `Forum`.`article`
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


-- Table `back`.`report_type`
CREATE TABLE IF NOT EXISTS `back`.`report_type` (
  `type_id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- Table `back`.`report_status`
CREATE TABLE IF NOT EXISTS `back`.`report_status` (
  `status_id` INT NOT NULL AUTO_INCREMENT,
  `status_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- Table `back`.`article_report`
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


-- Table `group1`.`type`
CREATE TABLE IF NOT EXISTS `group1`.`type` (
  `g_type_no` INT NOT NULL AUTO_INCREMENT COMMENT '活動類型編號',
  `g_type` VARCHAR(45) NOT NULL COMMENT '活動類型',
  PRIMARY KEY (`g_type_no`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- Table `group1`.`group`
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


-- Table `back`.`group_report`
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


-- Table `chat`.`group_message`
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


-- Table `back`.`groupchat_report`
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


-- Table `back`.`intro_report`
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


-- Table `back`.`ord_msg`
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


-- Table `Forum`.`reply`
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


-- Table `back`.`reply_report`
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


-- Table `chat`.`friend`
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


-- Table `chat`.`s_message`
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


-- Table `back`.`singlechat_report`
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

-- Table `chat`.`group_chat`
CREATE TABLE IF NOT EXISTS `chat`.`group_chat` (
  `chat_no` INT NOT NULL AUTO_INCREMENT,
  `chat_theme_no` INT NULL DEFAULT NULL,
  `chat_leader` INT NULL DEFAULT NULL,
  `chat_name` VARCHAR(10) NULL,
  `chat_theme` VARCHAR(45) NULL,
  INDEX `fk_chat_leader_id_idx` (`chat_leader` ASC) VISIBLE,
  PRIMARY KEY (`chat_no`),
  CONSTRAINT `fk_chat_leader_id`
    FOREIGN KEY (`chat_leader`)
    REFERENCES `Center`.`info` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- Table `chat`.`chat_member`
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

-- Table `group1`.`comment`
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


-- Table `group1`.`member`
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


-- Table `group1`.`reply`
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

-- Table `Forum`.`article_like`
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


-- Table `Forum`.`reply_like`
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


-- Table `Forum`.`article_picture`
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


-- -----------------------------------------------------
-- CREATE ALL FAKE DATA
-- -----------------------------------------------------

SET foreign_key_checks = 0;

-- Table `Center`.`info`
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (1,0,'大傑0','小傑0','test0','test0@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:27',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (2,0,'大傑1','小傑1','test1','test1@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:27',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (3,0,'大傑2','小傑2','test2','test2@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:28',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (4,0,'大傑3','小傑3','test3','test3@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:28',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (5,0,'大傑4','小傑4','test4','test4@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:29',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (6,0,'大傑5','小傑5','test5','test5@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:29',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (7,0,'大傑6','小傑6','test6','test6@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:29',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (8,0,'大傑7','小傑7','test7','test7@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:29',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (9,0,'大傑8','小傑8','test8','test8@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:30',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (10,0,'大傑9','小傑9','test9','test9@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:30',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (11,0,'大傑10','小傑10','test10','test10@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:30',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (12,0,'大傑11','小傑11','test11','test11@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:30',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (13,0,'大傑12','小傑12','test12','test12@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:30',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (14,0,'大傑13','小傑13','test13','test13@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:31',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (15,0,'大傑14','小傑14','test14','test14@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:31',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (16,0,'大傑15','小傑15','test15','test15@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:31',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (17,0,'大傑16','小傑16','test16','test16@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:31',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (18,0,'大傑17','小傑17','test17','test17@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:31',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (19,0,'大傑18','小傑18','test18','test18@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:31',0);
INSERT INTO `Center`.`info` (`user_id`,`user_status`,`user_nickname`,`user_name`,`account`,`email`,`bitrhday`,`password`,`sex`,`mapping`,`age_min`,`age_max`,`mapping_sex`,`photo`,`intro`,`created_time`,`violation_count`) VALUES (20,0,'大傑19','小傑19','test19','test19@gmail.com','1989-06-04','123456',0,1,18,30,2,null,'HelloWorld','2021-08-11 15:20:32',0);

-- Table `group1`
INSERT INTO `group1`.`type` (`g_type`) VALUES ('運動');
INSERT INTO `group1`.`type` (`g_type`) VALUES ('吃飯');
INSERT INTO `group1`.`type` (`g_type`) VALUES ('寵物');
INSERT INTO `group1`.`type` (`g_type`) VALUES ('程式');

INSERT INTO `group1`.`group` (`g_name`,`g_type_no`,`g_content`,`g_start_time`,`g_end_time`,`apply_start_time`,`apply_end_time`,`place`,`number_lower`,`number_upper`,`number_total`, `user_id`, `introduce`, `phone`, `email`, `state_no`, `g_flow_cause`, `photo`, `g_url`) VALUES ('活動名稱1', '1', '這是活動1內容', '2020-01-01', '2020-02-02', '2020-01-01', '2020-02-02', '台中','1', '3', '3', '1', '活動介紹1', '0911111111', 'aa@gmail.com', '0', '因為所以', null,null); 
INSERT INTO `group1`.`group` (`g_name`,`g_type_no`,`g_content`,`g_start_time`,`g_end_time`,`apply_start_time`,`apply_end_time`,`place`,`number_lower`,`number_upper`,`number_total`, `user_id`, `introduce`, `phone`, `email`, `state_no`, `g_flow_cause`, `photo`, `g_url`) VALUES ('活動名稱2', '2', '這是活動2內容', '2020-01-01', '2020-02-02', '2020-01-01', '2020-02-02', '台北', '1','3','3', '2', '活動介紹2', '0922222222', 'bb@gmail.com', '1', null, null, null);
INSERT INTO `group1`.`group` (`g_name`,`g_type_no`,`g_content`,`g_start_time`,`g_end_time`,`apply_start_time`,`apply_end_time`,`place`,`number_lower`,`number_upper`,`number_total`, `user_id`, `introduce`, `phone`, `email`, `state_no`, `g_flow_cause`, `photo`, `g_url`) VALUES ('活動名稱3', '3', '這是活動3內容', '2020-01-01', '2020-02-02', '2020-01-01', '2020-02-02', '高雄', '1', '3', '3', '3', '活動介紹3', '0933333333', 'cc@gmail.com', '2', null, null, 'www.yahoo.com');
INSERT INTO `group1`.`group` (`g_name`,`g_type_no`,`g_content`,`g_start_time`,`g_end_time`,`apply_start_time`,`apply_end_time`,`place`,`number_lower`,`number_upper`,`number_total`, `user_id`, `introduce`, `phone`, `email`, `state_no`, `g_flow_cause`, `photo`, `g_url`) VALUES ('活動名稱4', '4', '這是活動4內容', '2020-01-01', '2020-02-02', '2020-01-01', '2020-02-02', '台北', '1', '3', '1', '9', '活動介紹4', '0999999999', 'dd@gmail.com', '3',null ,null , 'www.tibame.com');



INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('0', '1', '1', '2020-01-01');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('0', '2', '2', '2020-01-01');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('0', '3', '3', '2020-01-01');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('1', '4', '1', '2020-01-02');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('1', '5', '2', '2020-01-02');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('1', '6', '3', '2020-01-02');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('1', '7', '1', '2020-01-02');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('1', '8', '2', '2020-01-02');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('1', '9', '3', '2020-01-02');
INSERT INTO `group1`.`member` (`role`, `user_id`, `g_no`, `join_time`) VALUES ('0', '9', '4', '2020-01-02');


INSERT INTO `group1`.`comment` (`user_id`, `comment_time`, `comment`, `g_no`) VALUES ('1', '2020-01-01', '留言1', '1');
INSERT INTO `group1`.`comment` (`user_id`, `comment_time`, `comment`, `g_no`) VALUES ('2', '2020-01-01', '留言2', '2');
INSERT INTO `group1`.`comment` (`user_id`, `comment_time`, `comment`, `g_no`) VALUES ('3', '2020-01-01', '留言3', '3');
INSERT INTO `group1`.`comment` (`user_id`, `comment_time`, `comment`, `g_no`) VALUES ('9', '2020-01-01', '留言4', '4');


INSERT INTO `group1`.`reply` ( `user_id`, `reply`, `reply_time`, `comment_no`) VALUES ('4', '回覆1', '2020-01-01', '1');
INSERT INTO `group1`.`reply` ( `user_id`, `reply`, `reply_time`, `comment_no`) VALUES ('3', '回覆2', '2020-01-01', '2');
INSERT INTO `group1`.`reply` ( `user_id`, `reply`, `reply_time`, `comment_no`) VALUES ('2', '回覆3', '2020-01-01', '3');
INSERT INTO `group1`.`reply` ( `user_id`, `reply`, `reply_time`, `comment_no`) VALUES ('1', '回覆4', '2020-01-01', '4');

-- Table in Chat
INSERT INTO `chat`.`chat_member` (`member_id`,`chat_no`,`user_id`,`join_time`,`leave_time`,`user_mode`) VALUES (1,1,132,'2021-08-13 22:50:23','2021-08-13 22:50:23',1);
INSERT INTO `chat`.`chat_member` (`member_id`,`chat_no`,`user_id`,`join_time`,`leave_time`,`user_mode`) VALUES (2,2,232,'2021-08-13 23:09:14','2021-08-13 23:09:14',0);
INSERT INTO `chat`.`chat_member` (`member_id`,`chat_no`,`user_id`,`join_time`,`leave_time`,`user_mode`) VALUES (3,3,332,'2021-08-13 23:09:39','2021-08-13 23:09:39',0);
INSERT INTO `chat`.`chat_member` (`member_id`,`chat_no`,`user_id`,`join_time`,`leave_time`,`user_mode`) VALUES (4,4,432,'2021-08-13 23:09:49','2021-08-13 23:09:49',1);
INSERT INTO `chat`.`chat_member` (`member_id`,`chat_no`,`user_id`,`join_time`,`leave_time`,`user_mode`) VALUES (5,5,532,'2021-08-13 23:10:00','2021-08-13 23:10:00',0);

INSERT INTO `chat`.`s_message` (`s_message_no`,`user_id`,`c_no`,`message_time`,`message_data`) VALUES (1,1,1,'2021-08-13 23:00:45','椅子');
INSERT INTO `chat`.`s_message` (`s_message_no`,`user_id`,`c_no`,`message_time`,`message_data`) VALUES (2,2,2,'2021-08-13 23:01:38','桌子');
INSERT INTO `chat`.`s_message` (`s_message_no`,`user_id`,`c_no`,`message_time`,`message_data`) VALUES (3,2,2,'2021-08-13 23:01:44','杯子');
INSERT INTO `chat`.`s_message` (`s_message_no`,`user_id`,`c_no`,`message_time`,`message_data`) VALUES (4,3,3,'2021-08-13 23:02:49','起子');
INSERT INTO `chat`.`s_message` (`s_message_no`,`user_id`,`c_no`,`message_time`,`message_data`) VALUES (5,4,4,'2021-08-13 23:03:03','筷子');

INSERT INTO `chat`.`friend` (`friend_list_id`,`friend_id`,`user_id`,`friend_mode`) VALUES (1,5,50434,0);
INSERT INTO `chat`.`friend` (`friend_list_id`,`friend_id`,`user_id`,`friend_mode`) VALUES (2,1,10434,0);
INSERT INTO `chat`.`friend` (`friend_list_id`,`friend_id`,`user_id`,`friend_mode`) VALUES (3,2,20434,1);
INSERT INTO `chat`.`friend` (`friend_list_id`,`friend_id`,`user_id`,`friend_mode`) VALUES (4,3,30434,0);
INSERT INTO `chat`.`friend` (`friend_list_id`,`friend_id`,`user_id`,`friend_mode`) VALUES (5,4,40434,1);

INSERT INTO `chat`.`group_chat` (`chat_no`,`chat_theme_no`,`chat_leader`,`chat_name`,`chat_theme`) VALUES (1,1,1,'JAVA讀書會','程式');
INSERT INTO `chat`.`group_chat` (`chat_no`,`chat_theme_no`,`chat_leader`,`chat_name`,`chat_theme`) VALUES (2,2,2,'桌球','運動');
INSERT INTO `chat`.`group_chat` (`chat_no`,`chat_theme_no`,`chat_leader`,`chat_name`,`chat_theme`) VALUES (3,3,3,'遊戲','暗黑破壞神2');
INSERT INTO `chat`.`group_chat` (`chat_no`,`chat_theme_no`,`chat_leader`,`chat_name`,`chat_theme`) VALUES (4,4,4,'美食','壽喜燒');
INSERT INTO `chat`.`group_chat` (`chat_no`,`chat_theme_no`,`chat_leader`,`chat_name`,`chat_theme`) VALUES (5,4,4,'購物','IPAD PRO 2077');

INSERT INTO `chat`.`group_message` (`message_no`,`user_id`,`message_time`,`message_date`) VALUES (1,10434,'2021-08-13 22:14:08','一二');
INSERT INTO `chat`.`group_message` (`message_no`,`user_id`,`message_time`,`message_date`) VALUES (2,10434,'2021-08-13 23:06:35','一二');
INSERT INTO `chat`.`group_message` (`message_no`,`user_id`,`message_time`,`message_date`) VALUES (3,20434,'2021-08-13 23:06:51','三四');
INSERT INTO `chat`.`group_message` (`message_no`,`user_id`,`message_time`,`message_date`) VALUES (4,30434,'2021-08-13 23:07:00','四五');
INSERT INTO `chat`.`group_message` (`message_no`,`user_id`,`message_time`,`message_date`) VALUES (5,40434,'2021-08-13 23:07:10','五六');

-- Table in Shop
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (1,1,64,'Switch無線手把 任天堂 Nintendo switch PRO 手把 NS 控制器','葉子',8700,8,NULL,2,'二星差評',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (2,1,119,'韓國製造 Milky Dress蠶絲精華小白管','玫瑰金',7200,10,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (3,1,19,'SAS韓版高腰彈性單邊破洞牛仔褲','灰',7800,5,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (4,1,120,'FV富勒烯胎盤素面膜 ','預設',5300,6,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (5,1,88,'香氛蠟燭暖燈/融燭燈/香薰燈','白色',1100,4,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (6,2,125,'康富 康體素乳膏 女用 ','預設',0,7,NULL,5,'五星超棒棒!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (7,2,62,'Wii原裝右手(全新)手柄/把手/手把，內建\"動感強化器\"附掛繩 附果凍套','iphone12pro',6900,5,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (8,3,81,'精油 水氧機 香薰機 香氛機','預設',200,3,NULL,1,'一星差評!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (9,4,89,'MIT 精梳純棉-單人床包枕套兩件組	✦材質：100%純棉','黑色',1500,2,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (10,4,64,'Switch無線手把 任天堂 Nintendo switch PRO 手把 NS 控制器','葉子',1200,3,NULL,1,'一星差評!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (11,4,126,'森女服飾 香妮美人計后脫塑身衣正品產后收腹提臀連體瘦內衣無痕燃脂美體衣','預設',5600,4,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (12,5,33,'加大尺碼吸濕排汗無袖背心','L',8300,3,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (13,5,116,'電動修眉機 修眉神器 自動修眉機','預設',8000,4,NULL,5,'五星超棒棒!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (14,6,74,'贈32G+10米後拉線 10吋屏觸控流媒體電子後視鏡/GPS/行車紀錄器/前後鏡頭1080P/無光夜視','預設',5700,8,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (15,6,119,'韓國製造 Milky Dress蠶絲精華小白管','玫瑰金',200,1,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (16,6,57,'漸層 漸變 iPhone 7/8 Plus 11/12 Pro Max 轉聲防摔殼 透明殼','預設',1200,10,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (17,6,89,'MIT 精梳純棉-單人床包枕套兩件組	✦材質：100%純棉','黑色',1000,6,NULL,4,'四星好評~',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (18,7,78,'四層活性碳口罩拋棄式口罩成人口罩','紫',4500,5,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (19,7,64,'Switch無線手把 任天堂 Nintendo switch PRO 手把 NS 控制器','葉子',8700,1,NULL,1,'一星差評!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (20,7,66,'任天堂 Nintendo Switch NS 大容量收納盒 防撞盒 收納包 ','預設',1100,7,NULL,4,'四星好評~',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (21,8,6,'Celine 毛呢 羊毛 外套 西裝版型	','卡其',1000,3,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (22,8,46,'最新藍芽升級版','8L',6300,4,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (23,8,39,'Adidas 經典爆款 三葉草 T恤','預設',400,3,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (24,9,59,'20D滿版鋼化玻璃貼 	圖片顏色會因為燈光效果略有誤差，以實際商品為主','iphone11',8200,2,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (25,10,83,'日本 Cecile Maia 除毛膏 脫毛膏','預設',4500,4,NULL,1,'一星差評!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (26,10,37,'Adidas 經典三條紋 運動短褲','黑色',9600,6,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (27,10,23,'CPMAX 潮牌寬鬆五分袖短T','雙邊破',5000,10,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (28,10,40,'CS衣舖 3件999元 超低價!高品質!','黑色',3200,1,NULL,3,'三星還可以!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (29,10,79,'防疫我最強國鼎紅敏風錠60粒/瓶','灰色',9500,2,NULL,3,'三星還可以!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (30,11,71,'任天堂NS SWITCH 加強電力版 單機組 台灣公司貨 全新商品','黃',4400,7,NULL,4,'四星好評~',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (31,12,37,'Adidas 經典三條紋 運動短褲','黑色',7200,3,NULL,3,'三星還可以!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (32,12,9,'丹寧男友褲 自信迷人百搭破洞牛仔褲','白色',9300,8,NULL,1,'一星差評!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (33,12,30,'單件189元 4件只要599元 可穿到100公斤	','黑色',6400,2,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (34,13,30,'單件189元 4件只要599元 可穿到100公斤	','黑色',2800,8,NULL,5,'五星超棒棒!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (35,14,125,'康富 康體素乳膏 女用 ','預設',7200,2,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (36,15,86,'3D立體矽膠口罩支架口罩內襯墊口罩支撐架','預設',400,6,NULL,2,'二星差評',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (37,15,57,'漸層 漸變 iPhone 7/8 Plus 11/12 Pro Max 轉聲防摔殼 透明殼','預設',8000,3,NULL,1,'一星差評!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (38,15,93,'3D立體雙車邊可水洗羽絲絨枕','天馬行空',8000,10,NULL,2,'二星差評',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (39,15,102,'除臭大師抗菌防護噴霧(抗抑菌檢測+國泰產物險)500ml','粉點點',5900,9,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (40,15,45,'最新藍芽升級版','7L',1400,7,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (41,16,82,'精油 香薰精油 買5送1 水溶性精油','預設',600,3,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (42,16,53,'Sanrio Hello Kitty 正版授權 iPhone 12 支架保護殼 保護套 手機殼	','黑色',1400,8,NULL,4,'四星好評~',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (43,16,74,'贈32G+10米後拉線 10吋屏觸控流媒體電子後視鏡/GPS/行車紀錄器/前後鏡頭1080P/無光夜視','預設',9400,5,NULL,4,'四星好評~',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (44,16,48,'Tronsmart Force+ IPX7藍芽喇叭','白綠手把',2700,1,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (45,17,1,'法式顯瘦開衩長褲','白色',7200,9,NULL,3,'三星還可以!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (46,17,53,'Sanrio Hello Kitty 正版授權 iPhone 12 支架保護殼 保護套 手機殼	','黑色',6700,1,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (47,17,94,'3D立體雙車邊可水洗羽絲絨枕','維度世界',2000,10,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (48,17,126,'森女服飾 香妮美人計后脫塑身衣正品產后收腹提臀連體瘦內衣無痕燃脂美體衣','預設',4500,4,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (49,17,22,'CPMAX 潮牌寬鬆五分袖短T','單膝破',9500,2,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (50,18,49,'iphone線 Baseus 倍思編織線 蘋果充電線','預設',900,9,NULL,5,'五星超棒棒!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (51,18,118,'韓國製造 Milky Dress蠶絲精華小白管','金',4200,7,NULL,1,'一星差評!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (52,18,54,'Sanrio Hello Kitty 正版授權 iPhone 12 支架保護殼 保護套 手機殼	','白色',8200,4,NULL,3,'三星還可以!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (53,18,69,'NS無線遊戲手把 任天堂 Nintendo switch pro控制器	【良值 第二代/第四代  Switch無線手把】  ','預設',4600,6,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (54,18,124,'最大秤重180KG 體重秤精准玻璃電子人體秤夜視健康體重稱	','預設',3200,8,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (55,19,65,'Switch無線手把 任天堂 Nintendo switch PRO 手把 NS 控制器','貓掌',7500,2,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (56,19,100,'CPMAX 多層超簡易組合鞋架 鞋櫃','紅色',4500,4,NULL,4,'四星好評~',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (57,19,58,'20D滿版鋼化玻璃貼 	圖片顏色會因為燈光效果略有誤差，以實際商品為主','iphoneXR',400,2,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (58,19,85,'小米體重計2 原廠公司貨	NULL台灣賣家｜台灣出貨NULL ','預設',1600,3,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (59,20,10,'亞麻淺灰優雅針織2件套上衣','淺藍',3400,7,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (60,21,43,'立領素色剪裁休閒襯衫','L30',7600,3,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (61,21,23,'CPMAX 潮牌寬鬆五分袖短T','雙邊破',5400,6,NULL,3,'三星還可以!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (62,21,110,'巫咪小舖雅詩蘭黛(今日最便宜)清新淨妍潔顏露30ml特價39元/另售特潤超導修護露特潤超導全方位修護露	','預設',3100,4,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (63,22,19,'SAS韓版高腰彈性單邊破洞牛仔褲','灰',2100,9,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (64,22,67,'高清無線2.4G紅白機 任天堂電視遊樂器	','預設',4500,3,NULL,3,'三星還可以!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (65,22,53,'Sanrio Hello Kitty 正版授權 iPhone 12 支架保護殼 保護套 手機殼	','黑色',2900,4,NULL,3,'三星還可以!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (66,22,7,'牛仔褲 彈力親膚超好穿淺藍修身高腰九分褲','預設',5800,2,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (67,22,73,'HD5 雙USB車用藍牙MP3','預設',6200,5,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (68,23,67,'高清無線2.4G紅白機 任天堂電視遊樂器	','預設',5500,8,NULL,3,'三星還可以!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (69,23,18,'SAS韓版高腰彈性單邊破洞牛仔褲','黑',9300,4,NULL,2,'二星差評',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (70,23,130,'買三送一天山雪蓮 奇蹟素 葡萄籽精華 熟齡保養 (60顆/瓶) 免運	','預設',600,9,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (71,24,109,'巫咪小舖(今日最便宜)雅詩蘭黛特潤超導修護露小棕瓶7m	','預設',6500,5,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (72,24,54,'Sanrio Hello Kitty 正版授權 iPhone 12 支架保護殼 保護套 手機殼	','白色',3200,3,NULL,4,'四星好評~',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (73,24,72,'任天堂NS SWITCH 加強電力版 單機組 台灣公司貨 全新商品','黑',4500,8,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (74,25,100,'CPMAX 多層超簡易組合鞋架 鞋櫃','紅色',4800,10,NULL,3,'三星還可以!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (75,26,52,'迷你鏡面快充行動電源 20000mAh','預設',8100,5,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (76,26,80,'防疫我最強國鼎紅敏風錠60粒/瓶','黑色',6900,5,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (77,26,66,'任天堂 Nintendo Switch NS 大容量收納盒 防撞盒 收納包 ','預設',8900,2,NULL,5,'五星超棒棒!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (78,27,36,'加大尺碼-運動長褲-超彈力/速乾','灰色',8500,3,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (79,27,81,'精油 水氧機 香薰機 香氛機','預設',9900,8,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (80,28,50,'iphone轉hdmi 手機投影  高畫質','預設',6800,6,NULL,3,'三星還可以!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (81,28,114,'NES 水漾雲朵霜 清爽型 35ml	','藍瓶',3100,10,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (82,28,56,'保證 最高規 iPhone 11 X 8 7 6 5 充電器 豆腐頭 for iPhone','預設',2700,7,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (83,28,127,'信東Q彈膠原蛋白粉(30包/盒) ','S',4600,4,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (84,29,6,'Celine 毛呢 羊毛 外套 西裝版型	','卡其',6500,7,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (85,30,110,'巫咪小舖雅詩蘭黛(今日最便宜)清新淨妍潔顏露30ml特價39元/另售特潤超導修護露特潤超導全方位修護露	','預設',9400,5,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (86,30,64,'Switch無線手把 任天堂 Nintendo switch PRO 手把 NS 控制器','葉子',6600,9,NULL,1,'一星差評!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (87,30,120,'FV富勒烯胎盤素面膜 ','預設',8800,4,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (88,31,22,'CPMAX 潮牌寬鬆五分袖短T','單膝破',9200,8,NULL,1,'一星差評!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (89,32,124,'最大秤重180KG 體重秤精准玻璃電子人體秤夜視健康體重稱	','預設',1400,1,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (90,32,38,'Adidas 經典三條紋 運動短褲','灰色',1300,3,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (91,32,63,'NS Switch Lite 搖桿帽 Joy Con 貓掌	','預設',9400,6,NULL,1,'一星差評!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (92,33,122,'一條根精油滾珠5ml 不沾手、攜帶方便、小面積使用	','預設',6300,4,NULL,1,'一星差評!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (93,34,66,'任天堂 Nintendo Switch NS 大容量收納盒 防撞盒 收納包 ','預設',3300,6,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (94,34,96,'美好家居【100x60鋼架電競桌】現品現貨*電腦桌	','預設',3800,5,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (95,34,87,'香氛蠟燭暖燈/融燭燈/香薰燈','黑色',5600,7,NULL,5,'五星超棒棒!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (96,34,74,'贈32G+10米後拉線 10吋屏觸控流媒體電子後視鏡/GPS/行車紀錄器/前後鏡頭1080P/無光夜視','預設',2800,8,NULL,4,'四星好評~',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (97,34,131,'BIONEO百妮 - 粉嫩霜 20ml','預設',1600,2,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (98,35,106,'❤現貨❤俏樂斯CHURACOS沖繩美人の All-In-One Gel 幼美肌超導逆時彈力水凝霜30g	','藍',4200,3,NULL,4,'四星好評~',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (99,35,41,'CS衣舖 3件999元 超低價!高品質!','白色',1200,5,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (100,36,97,'『室內拖鞋』日式條紋亞麻泡沫底情侶鞋家居木地板涼拖鞋	','預設',4200,9,NULL,2,'二星差評',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (101,36,124,'最大秤重180KG 體重秤精准玻璃電子人體秤夜視健康體重稱	','預設',2900,4,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (102,37,48,'Tronsmart Force+ IPX7藍芽喇叭','白綠手把',4700,1,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (103,37,34,'加大尺碼吸濕排汗無袖背心','XL',1200,6,NULL,5,'五星超棒棒!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (104,37,78,'四層活性碳口罩拋棄式口罩成人口罩','紫',100,7,NULL,1,'一星差評!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (105,38,87,'香氛蠟燭暖燈/融燭燈/香薰燈','黑色',7400,1,NULL,1,'一星差評!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (106,38,48,'Tronsmart Force+ IPX7藍芽喇叭','白綠手把',4000,4,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (107,38,95,'自動酒精噴霧機 USB充電噴霧機 ','預設',9600,1,NULL,2,'二星差評',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (108,39,3,'美色恬靜．圓領寬鬆顯瘦無袖中長款連身裙','M',500,3,NULL,4,'四星好評~',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (109,39,17,' V領實穿百搭柔感莫代爾短袖上衣','白色',1600,5,NULL,5,'五星超棒棒!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (110,39,63,'NS Switch Lite 搖桿帽 Joy Con 貓掌	','預設',5200,8,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (111,39,100,'CPMAX 多層超簡易組合鞋架 鞋櫃','紅色',6500,5,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (112,39,77,'四層活性碳口罩拋棄式口罩成人口罩','黑',1800,2,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (113,40,92,'3D立體雙車邊可水洗羽絲絨枕','花語之歌',9200,7,NULL,5,'五星超棒棒!',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (114,40,79,'防疫我最強國鼎紅敏風錠60粒/瓶','灰色',1000,3,NULL,4,'四星好評~',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (115,40,47,'Tronsmart Force+ IPX7藍芽喇叭','黑紅手把',9000,5,NULL,0,'',NULL,NULL,NULL,NULL,NULL);
INSERT INTO `SHOP`.`order_prod` (`ord_prod_id`,`ord_no`,`prod_spec_id`,`hist_prod_name`,`hist_prod_spec`,`hist_prod_price`,`prod_num`,`hist_prod_pic`,`eval_star`,`eval_text`,`re_ex_reason`,`re_ex_detail`,`re_ex_price`,`re_ex_num`,`re_ex_pic`) VALUES (116,40,121,'典安大藥局~俏正美BB蜂王飲10入/3盒免運','預設',900,2,NULL,0,'',NULL,NULL,NULL,NULL,NULL);

INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (1,3,10,'2018-01-22 22:54:16','商品出貨',4900,'全家',60,'東方翰柏,連江縣北竿鄉工業二十路235巷405弄116號,0916231653,clovis.flatley@zieme.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (2,1,20,'2019-07-03 21:52:49','商品出貨',300,'全家',60,'榮軒賢,南投縣仁愛鄉中正東路五段81巷911號,0914029149,lilla.okeefe@yahoo.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (3,5,15,'2019-05-03 01:28:37','訂單成立',400,'郵局包裹',100,'公羊美思,嘉義縣中埔鄉梅亭東路969巷307弄680號,093684264,felix.koelpin@welch.biz');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (4,2,16,'2018-07-04 02:54:01','訂單成立',6100,'郵局包裹',100,'哲詩,基隆市中正區鳳仁街九段451巷402弄998號44樓,0966921191,wellington43@maggio.org');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (5,1,3,'2019-08-14 14:21:31','訂單完成',5300,'全家',60,'鞠穎,澎湖縣馬公市潭工一路55巷896弄238號41樓,0957986452,orville84@yahoo.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (6,2,14,'2015-04-30 17:07:23','訂單成立',2300,'郵局包裹',100,'顏安伶,基隆市暖暖區平等路688巷582弄485號27樓,0925589509,yasmine.mcdermott@osinski.org');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (7,1,14,'2010-03-08 22:26:42','訂單完成',5600,'全家',60,'惠冠偉,屏東縣竹田鄉富農一路106號76樓,0928911429,dameon49@gulgowski.org');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (8,4,4,'2011-02-04 13:09:02','訂單完成',8900,'全家',60,'蓋信,金門縣金寧鄉寶深路268號26樓,0904218993,balistreri.rey@klein.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (9,5,16,'2012-08-17 04:17:09','訂單成立',1400,'7-11',60,'侯詩心,苗栗縣獅潭鄉豐裡二街八段796巷751號,0940829096,hartmann.marcia@gmail.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (10,2,12,'2012-06-26 17:43:24','訂單成立',9600,'7-11',60,'拓跋涵,彰化縣大城鄉和祥七路766巷984弄982號,0923283527,allie.terry@gmail.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (11,1,19,'2016-10-07 14:16:28','商品出貨',200,'郵局包裹',100,'熊彥志,臺東縣太麻里鄉大明街六段676巷103弄288號,0916231653,arvid.thompson@yahoo.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (12,5,2,'2012-07-23 16:18:08','商品出貨',9900,'全家',60,'紅靜君,南投縣仁愛鄉中正東路五段81巷911號,0914029149,lilla.okeefe@yahoo.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (13,3,18,'2012-08-24 19:11:15','商品出貨',1800,'全家',60,'廣彥心,嘉義縣中埔鄉梅亭東路969巷307弄680號,093684264,felix.koelpin@welch.biz');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (14,3,15,'2019-07-10 01:41:17','訂單完成',6100,'7-11',60,'亓官威,基隆市中正區鳳仁街九段451巷402弄998號44樓,0966921191,wellington43@maggio.org');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (15,3,1,'2012-10-01 20:25:18','訂單成立',8500,'郵局包裹',100,'梅萱,澎湖縣馬公市潭工一路55巷896弄238號41樓,0957986452,orville84@yahoo.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (16,1,14,'2011-07-14 06:10:26','訂單取消',5400,'郵局包裹',100,'司徒佩如,基隆市暖暖區平等路688巷582弄485號27樓,0925589509,yasmine.mcdermott@osinski.org');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (17,5,5,'2010-05-23 20:47:55','訂單取消',400,'郵局包裹',100,'卓萱,屏東縣竹田鄉富農一路106號76樓,0928911429,dameon49@gulgowski.org');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (18,3,10,'2014-03-18 00:05:39','商品出貨',6300,'7-11',60,'華雯萍,金門縣金寧鄉寶深路268號26樓,0904218993,balistreri.rey@klein.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (19,1,2,'2015-02-27 21:15:40','訂單完成',7000,'全家',60,'齊承,苗栗縣獅潭鄉豐裡二街八段796巷751號,0940829096,hartmann.marcia@gmail.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (20,3,3,'2014-08-20 11:46:43','訂單完成',9800,'郵局包裹',100,'許傑文,彰化縣大城鄉和祥七路766巷984弄982號,0923283527,allie.terry@gmail.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (21,4,4,'2016-07-18 10:42:54','商品出貨',400,'7-11',60,'東方翰柏,連江縣北竿鄉工業二十路235巷405弄116號,0916231653,clovis.flatley@zieme.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (22,5,5,'2010-09-25 05:13:26','商品出貨',1500,'全家',60,'榮軒賢,南投縣仁愛鄉中正東路五段81巷911號,0914029149,lilla.okeefe@yahoo.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (23,4,16,'2016-09-12 07:44:44','訂單取消',8600,'郵局包裹',100,'公羊美思,嘉義縣中埔鄉梅亭東路969巷307弄680號,093684264,felix.koelpin@welch.biz');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (24,1,6,'2017-09-21 04:32:46','訂單完成',1600,'7-11',60,'哲詩,基隆市中正區鳳仁街九段451巷402弄998號44樓,0966921191,wellington43@maggio.org');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (25,1,14,'2017-06-27 00:05:24','商品出貨',4400,'郵局包裹',100,'鞠穎,澎湖縣馬公市潭工一路55巷896弄238號41樓,0957986452,orville84@yahoo.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (26,4,14,'2010-09-15 21:38:45','訂單完成',5400,'郵局包裹',100,'顏安伶,基隆市暖暖區平等路688巷582弄485號27樓,0925589509,yasmine.mcdermott@osinski.org');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (27,4,11,'2012-03-20 22:36:42','訂單成立',2100,'7-11',60,'惠冠偉,屏東縣竹田鄉富農一路106號76樓,0928911429,dameon49@gulgowski.org');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (28,3,1,'2014-09-30 06:07:57','訂單完成',400,'郵局包裹',100,'蓋信,金門縣金寧鄉寶深路268號26樓,0904218993,balistreri.rey@klein.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (29,3,12,'2013-05-16 20:04:57','訂單取消',1100,'7-11',60,'侯詩心,苗栗縣獅潭鄉豐裡二街八段796巷751號,0940829096,hartmann.marcia@gmail.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (30,1,12,'2011-03-24 02:31:27','訂單取消',3500,'7-11',60,'拓跋涵,彰化縣大城鄉和祥七路766巷984弄982號,0923283527,allie.terry@gmail.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (31,4,13,'2018-08-08 06:18:49','商品出貨',8600,'郵局包裹',100,'熊彥志,臺東縣太麻里鄉大明街六段676巷103弄288號,0916231653,arvid.thompson@yahoo.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (32,3,16,'2018-09-10 18:42:06','商品出貨',5700,'全家',60,'紅靜君,南投縣仁愛鄉中正東路五段81巷911號,0914029149,lilla.okeefe@yahoo.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (33,3,4,'2013-06-03 14:33:44','訂單完成',5700,'全家',60,'廣彥心,嘉義縣中埔鄉梅亭東路969巷307弄680號,093684264,felix.koelpin@welch.biz');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (34,2,9,'2017-02-21 01:39:09','訂單完成',5700,'全家',60,'亓官威,基隆市中正區鳳仁街九段451巷402弄998號44樓,0966921191,wellington43@maggio.org');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (35,3,1,'2018-08-23 22:18:03','訂單取消',3900,'全家',60,'梅萱,澎湖縣馬公市潭工一路55巷896弄238號41樓,0957986452,orville84@yahoo.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (36,4,6,'2013-03-02 07:44:36','訂單成立',9400,'7-11',60,'司徒佩如,基隆市暖暖區平等路688巷582弄485號27樓,0925589509,yasmine.mcdermott@osinski.org');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (37,5,16,'2011-10-03 03:27:40','訂單完成',2600,'7-11',60,'卓萱,屏東縣竹田鄉富農一路106號76樓,0928911429,dameon49@gulgowski.org');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (38,2,9,'2010-05-16 10:27:56','訂單取消',2100,'全家',60,'華雯萍,金門縣金寧鄉寶深路268號26樓,0904218993,balistreri.rey@klein.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (39,4,7,'2012-05-07 15:30:31','商品出貨',8400,'7-11',60,'齊承,苗栗縣獅潭鄉豐裡二街八段796巷751號,0940829096,hartmann.marcia@gmail.com');
INSERT INTO `SHOP`.`order` (`ord_no`,`support_admin_id`,`user_id`,`ord_time`,`ord_status`,`ord_total`,`ship_method`,`ship_fee`,`ship_info`) VALUES (40,4,3,'2012-09-16 09:34:01','訂單成立',800,'全家',60,'許傑文,彰化縣大城鄉和祥七路766巷984弄982號,0923283527,allie.terry@gmail.com');

INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (1,1,18);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (2,1,38);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (3,1,55);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (4,1,23);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (5,1,7);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (6,1,72);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (7,1,14);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (8,2,65);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (9,2,26);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (10,2,15);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (11,3,32);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (12,3,3);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (13,3,6);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (14,3,7);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (15,3,72);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (16,3,9);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (17,3,41);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (18,3,74);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (19,3,42);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (20,3,17);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (21,3,54);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (22,3,57);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (23,3,58);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (24,3,60);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (25,3,29);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (26,3,62);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (27,4,32);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (28,4,50);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (29,4,39);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (30,4,43);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (31,4,44);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (32,4,61);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (33,5,56);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (34,6,16);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (35,6,18);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (36,6,51);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (37,6,5);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (38,6,41);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (39,6,26);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (40,6,59);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (41,6,61);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (42,6,62);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (43,7,5);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (44,7,39);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (45,8,1);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (46,8,66);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (47,8,3);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (48,8,5);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (49,8,7);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (50,8,40);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (51,8,11);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (52,8,13);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (53,8,46);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (54,8,16);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (55,8,17);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (56,8,22);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (57,8,28);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (58,8,63);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (59,9,64);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (60,9,1);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (61,9,34);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (62,9,35);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (63,9,4);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (64,9,68);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (65,9,6);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (66,9,10);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (67,9,11);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (68,9,75);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (69,9,44);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (70,9,14);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (71,9,17);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (72,9,23);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (73,9,24);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (74,9,25);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (75,9,26);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (76,11,33);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (77,11,67);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (78,11,70);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (79,11,71);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (80,11,7);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (81,11,8);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (82,11,43);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (83,11,75);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (84,11,77);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (85,11,46);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (86,11,15);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (87,11,16);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (88,11,21);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (89,11,54);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (90,11,57);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (91,11,26);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (92,11,27);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (93,11,61);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (94,12,33);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (95,12,1);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (96,12,34);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (97,12,2);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (98,12,67);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (99,12,68);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (100,12,4);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (101,12,11);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (102,12,75);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (103,12,12);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (104,12,77);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (105,12,79);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (106,12,17);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (107,12,54);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (108,12,22);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (109,12,25);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (110,12,27);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (111,12,59);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (112,13,17);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (113,13,69);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (114,13,7);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (115,13,39);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (116,13,71);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (117,13,24);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (118,13,44);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (119,13,62);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (120,14,1);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (121,14,71);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (122,14,72);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (123,14,41);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (124,14,42);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (125,14,74);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (126,14,43);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (127,14,75);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (128,14,15);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (129,14,79);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (130,14,16);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (131,14,49);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (132,14,18);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (133,14,57);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (134,14,26);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (135,14,27);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (136,14,62);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (137,15,33);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (138,15,1);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (139,15,67);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (140,15,4);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (141,15,68);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (142,15,36);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (143,15,71);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (144,15,76);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (145,15,47);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (146,15,80);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (147,15,48);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (148,15,18);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (149,15,50);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (150,15,51);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (151,15,60);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (152,16,65);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (153,16,55);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (154,16,41);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (155,16,42);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (156,16,75);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (157,16,77);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (158,16,30);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (159,17,49);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (160,17,50);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (161,17,3);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (162,17,38);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (163,17,58);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (164,17,59);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (165,17,76);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (166,17,60);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (167,17,29);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (168,17,14);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (169,18,33);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (170,18,57);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (171,18,41);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (172,18,61);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (173,19,48);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (174,19,80);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (175,19,16);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (176,19,50);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (177,19,38);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (178,19,7);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (179,19,23);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (180,19,11);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (181,19,59);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (182,19,28);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (183,19,44);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (184,19,60);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (185,20,64);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (186,20,33);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (187,20,2);
INSERT INTO `SHOP`.`fav_prod` (`prod_fav_id`,`user_id`,`prod_id`) VALUES (188,20,30);

INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (1,1,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (2,1,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (3,1,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (4,2,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (5,2,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (6,3,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (7,3,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (8,3,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (9,4,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (10,4,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (11,4,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (12,5,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (13,5,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (14,6,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (15,6,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (16,6,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (17,7,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (18,7,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (19,8,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (20,8,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (21,8,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (22,9,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (23,9,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (24,9,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (25,10,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (26,10,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (27,10,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (28,11,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (29,11,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (30,12,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (31,13,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (32,13,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (33,13,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (34,14,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (35,14,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (36,14,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (37,14,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (38,15,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (39,15,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (40,16,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (41,17,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (42,17,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (43,17,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (44,17,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (45,18,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (46,18,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (47,18,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (48,19,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (49,19,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (50,19,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (51,20,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (52,20,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (53,20,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (54,21,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (55,21,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (56,21,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (57,22,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (58,22,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (59,22,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (60,23,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (61,23,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (62,24,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (63,25,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (64,25,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (65,25,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (66,26,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (67,26,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (68,26,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (69,27,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (70,27,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (71,27,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (72,28,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (73,28,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (74,29,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (75,29,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (76,30,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (77,30,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (78,30,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (79,31,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (80,31,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (81,31,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (82,31,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (83,32,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (84,32,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (85,32,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (86,33,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (87,33,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (88,33,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (89,34,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (90,34,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (91,34,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (92,35,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (93,35,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (94,36,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (95,36,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (96,37,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (97,37,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (98,37,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (99,38,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (100,38,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (101,39,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (102,39,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (103,39,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (104,40,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (105,40,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (106,41,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (107,41,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (108,41,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (109,42,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (110,42,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (111,42,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (112,43,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (113,43,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (114,43,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (115,44,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (116,44,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (117,44,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (118,45,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (119,45,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (120,45,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (121,46,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (122,47,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (123,47,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (124,48,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (125,48,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (126,49,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (127,49,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (128,49,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (129,50,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (130,50,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (131,51,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (132,51,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (133,52,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (134,52,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (135,52,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (136,53,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (137,53,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (138,53,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (139,53,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (140,54,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (141,54,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (142,54,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (143,54,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (144,55,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (145,55,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (146,55,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (147,56,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (148,56,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (149,57,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (150,58,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (151,58,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (152,59,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (153,59,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (154,59,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (155,60,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (156,60,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (157,60,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (158,61,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (159,61,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (160,61,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (161,62,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (162,62,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (163,62,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (164,62,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (165,63,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (166,63,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (167,63,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (168,63,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (169,64,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (170,64,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (171,65,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (172,65,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (173,65,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (174,66,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (175,66,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (176,67,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (177,67,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (178,67,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (179,68,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (180,68,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (181,68,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (182,69,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (183,69,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (184,69,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (185,70,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (186,70,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (187,70,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (188,71,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (189,71,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (190,72,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (191,72,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (192,72,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (193,73,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (194,73,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (195,73,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (196,74,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (197,74,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (198,75,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (199,75,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (200,76,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (201,76,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (202,76,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (203,77,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (204,77,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (205,78,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (206,78,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (207,78,3);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (208,78,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (209,79,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (210,79,2);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (211,79,4);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (212,80,1);
INSERT INTO `SHOP`.`prod_ships` (`prod_ship_id`,`prod_id`,`ship_no`) VALUES (213,80,4);

INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (1,1,'白色',30,9900);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (2,1,'淡紫色',41,2300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (3,2,'M',49,4100);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (4,2,'L',43,3300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (5,3,'黑',43,400);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (6,3,'卡其',21,9400);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (7,4,'預設',36,5900);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (8,5,'淺藍',36,5800);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (9,5,'白色',24,7900);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (10,6,'淺藍',42,100);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (11,6,'深藍',49,9000);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (12,7,'M',31,1100);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (13,7,'L',31,6200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (14,7,'XL',20,2000);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (15,8,'卡其',31,1000);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (16,8,'黑色',45,600);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (17,8,'白色',30,3800);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (18,9,'黑',26,1800);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (19,9,'灰',20,500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (20,9,'粉',22,1900);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (21,9,'白色',49,5900);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (22,10,'單膝破',23,8800);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (23,10,'雙邊破',30,1300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (24,11,'L',46,7200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (25,11,'XL',43,5400);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (26,11,'2XL',20,2100);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (27,12,'27腰',49,6500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (28,12,'28腰',30,1400);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (29,12,'29腰',26,100);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (30,13,'黑色',25,500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (31,13,'白色',26,2700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (32,13,'紅色',48,2300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (33,14,'L',26,100);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (34,14,'XL',38,8500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (35,15,'黑色',42,8300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (36,15,'灰色',46,6200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (37,16,'黑色',22,8100);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (38,16,'灰色',42,2900);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (39,17,'預設',30,700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (40,18,'黑色',47,4900);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (41,18,'白色',21,700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (42,19,'M28',37,8100);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (43,19,'L30',43,1600);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (44,20,'6L',43,3300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (45,20,'7L',39,9600);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (46,20,'8L',48,8800);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (47,21,'黑紅手把',34,9200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (48,21,'白綠手把',33,9600);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (49,22,'預設',45,4800);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (50,23,'預設',27,4700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (51,24,'預設',32,3300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (52,25,'預設',29,9500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (53,26,'黑色',43,3500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (54,26,'白色',46,700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (55,26,'紅色',24,6000);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (56,27,'預設',48,4200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (57,28,'預設',35,3500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (58,29,'iphoneXR',46,200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (59,29,'iphone11',27,8200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (60,29,'iphone12pro',49,7500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (61,30,'iphoneXR',37,7800);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (62,30,'iphone12pro',43,2400);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (63,31,'預設',40,1900);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (64,32,'葉子',28,5700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (65,32,'貓掌',29,4800);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (66,33,'預設',43,5700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (67,34,'預設',29,1100);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (68,35,'預設',25,3100);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (69,36,'預設',29,6700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (70,37,'粉',30,1400);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (71,37,'黃',49,7500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (72,37,'黑',21,9400);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (73,38,'預設',36,4800);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (74,39,'預設',25,7400);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (75,40,'預設',21,9200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (76,41,'粉',23,8000);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (77,41,'黑',46,8800);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (78,41,'紫',23,9100);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (79,42,'灰色',43,2500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (80,42,'黑色',44,6700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (81,43,'預設',21,4500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (82,44,'預設',25,2700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (83,45,'預設',31,400);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (84,46,'預設',28,3700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (85,47,'預設',36,2300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (86,48,'預設',21,3700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (87,49,'黑色',35,3600);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (88,49,'白色',37,6500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (89,50,'黑色',33,4600);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (90,50,'金色',48,200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (91,50,'玫瑰金',31,1300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (92,51,'花語之歌',33,1200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (93,51,'天馬行空',40,1300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (94,51,'維度世界',45,9300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (95,52,'預設',49,4200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (96,53,'預設',33,4700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (97,54,'預設',23,4700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (98,55,'米色',32,200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (99,55,'黑色',22,500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (100,55,'紅色',45,2200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (101,56,'銀灰色',30,9300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (102,56,'粉點點',41,8300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (103,57,'預設',36,3000);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (104,58,'預設',37,7700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (105,59,'預設',48,2000);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (106,60,'藍',28,9000);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (107,60,'粉',48,3200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (108,60,'紫',23,5600);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (109,61,'預設',49,3800);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (110,62,'預設',46,9900);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (111,63,'預設',46,4800);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (112,64,'預設',24,4000);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (113,65,'紅瓶',44,3400);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (114,65,'藍瓶',22,4300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (115,66,'預設',33,9600);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (116,67,'預設',29,5500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (117,68,'黑',26,7900);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (118,68,'金',33,2000);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (119,68,'玫瑰金',32,9500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (120,69,'預設',40,9300);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (121,70,'預設',45,7500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (122,71,'預設',49,3700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (123,72,'預設',28,5500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (124,73,'預設',46,5100);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (125,74,'預設',29,3200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (126,75,'預設',21,9500);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (127,76,'S',38,3200);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (128,76,'M',32,0);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (129,76,'L',33,9900);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (130,77,'預設',32,4400);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (131,78,'預設',38,6700);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (132,79,'預設',32,1000);
INSERT INTO `SHOP`.`prod_spec` (`prod_spec_id`,`prod_id`,`spec_name`,`stock`,`prod_price`) VALUES (133,80,'預設',26,9200);

INSERT INTO `SHOP`.`prod_type` (`prod_type_no`,`type_name`) VALUES (1,'生活休閒');
INSERT INTO `SHOP`.`prod_type` (`prod_type_no`,`type_name`) VALUES (2,'美妝保養');
INSERT INTO `SHOP`.`prod_type` (`prod_type_no`,`type_name`) VALUES (3,'風格穿搭');
INSERT INTO `SHOP`.`prod_type` (`prod_type_no`,`type_name`) VALUES (4,'3C家電');

INSERT INTO `SHOP`.`ship_method` (`ship_no`,`ship_name`,`ship_fee`) VALUES (1,'7-11',60);
INSERT INTO `SHOP`.`ship_method` (`ship_no`,`ship_name`,`ship_fee`) VALUES (2,'全家',60);
INSERT INTO `SHOP`.`ship_method` (`ship_no`,`ship_name`,`ship_fee`) VALUES (3,'黑貓宅急便',150);
INSERT INTO `SHOP`.`ship_method` (`ship_no`,`ship_name`,`ship_fee`) VALUES (4,'郵局包裹',100);

INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (1,3,'法式宮廷雪紡襯衫','小衫秉承著\"極簡主義\"/n飄帶的設計增加靈動和自然舒適的氣質 人人可駕馭 飄帶下隱藏的是V領的巧思 在繫法之上巧露小性感  白色和紫色符合開春的輕快感 兩色都好搭配唷  材質：聚酯纖維 顏色：紫色、白色 尺碼：S、M 版型：修身型 領型：V領  ?尺碼：     衣長     胸圍     腰圍    肩寬     袖長 S    61      110      112      43       61 M    62      114      116      44       62   以上單位為公分 手工測量，請允許1~3公分誤差    【洗滌說明】  ．在手洗衣物前，請務必在洗滌液完成治解於水後，再放入衣物洗滌。  ．請在最初幾次清洗時，把不同顏色衣服分開洗滌，以免染料融入水中。  ．清洗前請把衣服口袋內物品取出。   ．請勿使用合有漂白劑成分的洗漆劑，以免造成衣服色彩的損壞。   ．晾乾時，請勿讓衣物直接曝曬於陽光下。','2016-08-09 06:10:13',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (2,3,'法式顯瘦開衩長褲','材質：氨綸+聚酯纖維  版型：直筒  厚度：適中  彈力：無彈  長度：適中  顏色：黑色   ?尺碼： 腰圍  臀圍  大腿圍  褲腳圍  褲長 M 64      84       50        45       99 L 68      88       54        49      100  以上單位為公分  手工測量，請允許1~3公分誤差  【Model試穿】   試穿者   身高cm/體重kg      三圍cm      推薦尺碼   水水1          155/47            84/64/85           M           水水2          161/50            84/66/90           M             水水3          160/58            90/70/96           L         因個人身材比例及穿衣喜好不同，以上數據僅供參考，請依自身身材選購即可，有問題歡迎直接聊聊詢問。  【洗條方式】  1.深淺色衣物需分開洗滌，第一次洗滌有輕微浮色屬於正常現象。  2.建議手洗，水溫勿超過30°C，機洗容易導致衣服變形。  3.洗滌時不要長時間浸泡，以免造成菌斑和褪色。  4.請使用低溫熨燙。          因個人電腦螢幕顯色不同，色差皆屬合理範圍，一切依實物為準。 包含淺色商品較容易沾染，偶有小污漬皆屬正常現象，小線頭、小勾紗、小汙漬(2公分以內範圍)、小破洞(0.2公分以內)，都是屬於合理正常範圍，不是瑕疵品。  #Charlotte  #直筒長褲  #休閒長褲  #寬鬆長褲 #開衩長褲 #長褲  #夏洛特','2019-04-12 07:39:55',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (3,3,'美色恬靜．圓領寬鬆顯瘦無袖中長款連身裙','上下誤差兩公分為合理範 圍內喔~ 商品皆為平量 單位:公分  以上商品皆為單面平放測量的數據測量單位為公分可能會因為測量方式不同多少有些許的誤差，誤差值在2cm 上下，每批貨品因為製程時間不同.有時會有1-2cm長度改變＆染色色差. 若無法接受的買家請勿下標喔.恕不接受此原因退貨or更換 衣長92／93.5／95手臂寬19／20／21.5材質聚酯纖維 肩寬42／44／46.5下擺46.5／48.5／51彈性／厚度有／一般 胸寬42 ／44／46------尺寸M／L／XL 衣長96／97／98手臂寬22／22.5／23材質聚酯纖維 肩寬48／50／53下擺52.5／54／57彈性／厚度有／一般 胸寬47.5／49／51.5------尺寸2XL／3XL／4XL 賣場裡的衣服大部份是採打版 製作韓版風格並非韓貨，smile會盡力做到最好給各位水水，但對於質料要求過高或色差敏感的水水請先考慮清楚再下標~賣場均為低價美衣~請勿將專櫃或高 檔商品來做比較喔。希望彼此都有愉快的交易！！','2015-07-02 21:36:12',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (4,3,'Celine 毛呢 羊毛 外套 西裝版型	','原版打造，羊毛?➕棉➕錦綸.短款西裝版型設計，開模定制的馬車紐扣. 簡單幹練～沒有複雜的設計，是職場女性的優選?36 38 40','2011-06-20 12:36:53',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (5,3,'牛仔褲 彈力親膚超好穿淺藍修身高腰九分褲','材質：牛仔+彈力  25 褲長85 腰寬31~33 臀寬37~39 (cm公分) 26 褲長86 腰寬33~35 臀寬40~42 (cm公分) 27 褲長87 腰寬35~37 臀寬43~44 (cm公分) 28 褲長88 腰寬37~38 臀寬43~45 (cm公分) 29 褲長89 腰寬38~39 臀寬45~46 (cm公分) 30 褲長90 腰寬40~41 臀寬47~49 (cm公分) 31 褲長91 腰寬41~42 臀寬50~52 (cm公分)     測量說明：以上尺寸標示皆為平放單面測量，測量單位為公分(cm)。由於測量方式與 衣服質料有彈性，因此尺寸誤差2cm上下皆屬於正常範圍。可接受並認同的水水歡迎下標唷！   ＊本店商品採現貨+追加預購，現貨數量有限，下單後系統會自動依訂單成立順序配貨。若現貨已出完就需預購追加，需等待7~20個工作天會到貨，貨到1~3天 會幫您寄出（商品有提早到會幫您提早寄出）。  ＊預購追加商品有時難免會遇到工廠缺貨或斷貨的情形，通常都貨到時才會知道，非故意不提前告知，若遇此情況時，缺貨的商品可換款或直接退款給您。  ＊因拍攝光線角度與每台螢幕調色都不同，每批製程與布料可能會略有不同，顏色可能會略有差異屬正常範圍。  -  ??歡迎光臨【艾爾莎時尚精品】流行女裝服飾??  我們是台灣賣家?商品都是由台灣發貨 合法納稅商家?所有商品出貨都會隨貨附發票?  ??不定期有商品優惠活動、全館活動、滿額免運? 週週新品上架?請記得加入我們的Ｙ拍粉絲通?隨時掌握最新活動資訊！  我們專注於女裝?包包?美鞋?飾品配件? 精挑細選?‍?提供妳最新最快的穿搭美學? 無論是休閒?上班?出遊✈聚會?重要場合?都有妳滿意的款式?  ★提醒您，正確的洗滌方式能保衣物更長的使用期限。洗滌衣物的方式皆以乾洗或冷水手洗清理，浸泡中性洗衣劑輕輕柔洗，若要使用毛刷請使用軟性刷毛，輕輕的少次刷洗，避免用力過度。盡量不要使用洗衣機，若無法避免也一定必需搭配洗衣袋，避免衣物拉扯變型。乾衣方式請以自然晾乾為主， 使用拖水機也請放入細網洗衣袋中以慢速拖水，避免使用烘乾機以免衣物受高溫而變型。  ★有任何問題歡迎於即時通留言溝通，我們會於上班時間依照留言順序回覆您，請您耐心等候。感謝您～  上班時間⏰週一到週五09:00-18:00(午休12:00-13:00)國定例假日休息?即時通無法立即回應請見諒??  -  #艾爾莎 #艾爾莎時尚精品 #ELSA #ELSA FASHION','2016-01-09 09:06:50',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (6,3,'丹寧男友褲 自信迷人百搭破洞牛仔褲','XL號    褲長88　腰寬39~43　臀寬51　(cm) 2XL號    褲長89　腰寬41~44　臀寬53　(cm) 3XL號    褲長90　腰寬44~46　臀寬56　(cm) 4XL號    褲長91　腰寬46~49　臀寬58　(cm) 5XL號    褲長92　腰寬49~51　臀寬61　(cm)  質料    牛仔布 測量說明：以上尺寸標示皆為平放單面測量，測量單位為公分(cm)。由於測量方式與 衣服質料有彈性，因此尺寸誤差2cm上下皆屬於正常範圍。可接受並認同的水水歡迎下標唷！   ＊本店商品採現貨+追加預購，現貨數量有限，下單後系統會自動依訂單成立順序配貨。若現貨已出完就需預購追加，需等待7~20個工作天會到貨，貨到1~3天 會幫您寄出（商品有提早到會幫您提早寄出）。  ＊預購追加商品有時難免會遇到工廠缺貨或斷貨的情形，通常都貨到時才會知道，非故意不提前告知，若遇此情況時，缺貨的商品可換款或直接退款給您。  ＊因拍攝光線角度與每台螢幕調色都不同，每批製程與布料可能會略有不同，顏色可能會略有差異屬正常範圍。  -  ??歡迎光臨【艾爾莎時尚精品】流行女裝服飾??  我們是台灣賣家?商品都是由台灣發貨 合法納稅商家?所有商品出貨都會隨貨附發票?  ??不定期有商品優惠活動、全館活動、滿額免運? 週週新品上架?請記得加入我們的Ｙ拍粉絲通?隨時掌握最新活動資訊！  我們專注於女裝?包包?美鞋?飾品配件? 精挑細選?‍?提供妳最新最快的穿搭美學? 無論是休閒?上班?出遊✈聚會?重要場合?都有妳滿意的款式?  ★提醒您，正確的洗滌方式能保衣物更長的使用期限。洗滌衣物的方式皆以乾洗或冷水手洗清理，浸泡中性洗衣劑輕輕柔洗，若要使用毛刷請使用軟性刷毛，輕輕的少次刷洗，避免用力過度。盡量不要使用洗衣機，若無法避免也一定必需搭配洗衣袋，避免衣物拉扯變型。乾衣方式請以自然晾乾為主， 使用拖水機也請放入細網洗衣袋中以慢速拖水，避免使用烘乾機以免衣物受高溫而變型。  ★有任何問題歡迎於即時通留言溝通，我們會於上班時間依照留言順序回覆您，請您耐心等候。感謝您～  上班時間⏰週一到週五09:00-18:00(午休12:00-13:00)國定例假日休息?即時通無法立即回應請見諒??  -  #艾爾莎 #艾爾莎時尚精品 #ELSA #ELSA FASHION','2017-06-03 22:06:06',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (7,3,'亞麻淺灰優雅針織2件套上衣','小貴婦精緻釘珠亞麻淺灰優雅針織2件套上衣~預購M~3L SIZE   M SIZE: 衣長外罩衫約52背心56 肩寬35-37 CM 罩衫胸圍約:96 CM  L SIZE: 衣長外罩衫52背心56 肩寬35-37 CM 罩衫胸圍約:100 CM  XL SIZE: 衣長外罩衫53背心57 肩寬36-38CM 罩衫胸圍約:104 CM  2L SIZE: 衣長外罩衫53背心57 肩寬37-39 CM 罩衫胸圍約:108 CM  3L SIZE:衣長外罩衫55背心59 肩寬39-41CM 罩衫胸圍約:114 CM   小貴婦精緻釘珠亞麻淺灰優雅針織2件套上衣  V領灰黑細釘珠淺灰罩衫+內搭白色背心  優雅2件套上衣可拆穿   WASHING 洗涤方式  套袋机洗~不可脫水太久  建議48-54KGS~可穿M  建議55-59KGS~可穿L  建議60-64KGS~可穿XL  建議65-69KGS~可穿2L  建議69-74KGS~可穿3L  預購10-15天','2012-07-06 19:21:12',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (8,3,'S-3XL中腰直筒五分褲','衣長65 肩寬40 胸寬40 袖長19 (公分cm) 建議45~52(公斤kg) L   衣長66 肩寬41 胸寬42 袖長20 (公分cm) 建議52~57(公斤kg) XL  衣長67 肩寬43 胸寬44 袖長21 (公分cm) 建議57~65(公斤kg) 2XL 衣長68 肩寬44 胸寬46 袖長22 (公分cm) 建議65~72(公斤kg) 3XL 衣長69 肩寬46 胸寬48 袖長23 (公分cm) 建議72~80(公斤kg) 4XL 衣長70 肩寬47 胸寬50 袖長24 (公分cm) 建議80~85(公斤kg) 5XL 衣長71 肩寬49 胸寬52 袖長25 (公分cm) 建議85~90(公斤kg) 6XL 衣長72 肩寬50 胸寬54 袖長26 (公分cm) 建議90~105(公斤kg)   質料：莫代爾','2013-06-05 18:55:55',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (9,3,' V領實穿百搭柔感莫代爾短袖上衣','衣長65 肩寬40 胸寬40 袖長19 (公分cm) 建議45~52(公斤kg) L   衣長66 肩寬41 胸寬42 袖長20 (公分cm) 建議52~57(公斤kg) XL  衣長67 肩寬43 胸寬44 袖長21 (公分cm) 建議57~65(公斤kg) 2XL 衣長68 肩寬44 胸寬46 袖長22 (公分cm) 建議65~72(公斤kg) 3XL 衣長69 肩寬46 胸寬48 袖長23 (公分cm) 建議72~80(公斤kg) 4XL 衣長70 肩寬47 胸寬50 袖長24 (公分cm) 建議80~85(公斤kg) 5XL 衣長71 肩寬49 胸寬52 袖長25 (公分cm) 建議85~90(公斤kg) 6XL 衣長72 肩寬50 胸寬54 袖長26 (公分cm) 建議90~105(公斤kg)   質料：莫代爾','2017-03-07 05:16:39',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (10,3,'SAS韓版高腰彈性單邊破洞牛仔褲','材質：棉+聚酯纖維 款式：單膝破、雙邊破 尺碼：S、M、L 褲長：九分褲 腰型：高腰 ?褲子有彈性，非常顯瘦!!!  尺碼表  單膝破    腰圍   臀圍   腿圍   褲長   腳圍 S   61     75     45     90    22.5 M   65     79     47     91     24 L   69     83     49     92    25.5  雙邊破    腰圍   臀圍   褲長   腳圍 S   62     77     88     23 M   66     81     89     24 L   70     85     90     25  以上單位均為公分 手工測量，請允許1~3公分誤差  ▼購買注意事項▼  1.拿到商品後請全程錄影開箱商品，如果商品有短缺以影片為佐證才有辦法處理喔！ 2.內衣褲屬個人衛生用品，依《通訊交易解除權合理例外情事適用準則》第2條第6款「已拆封之個人衛生用品」因衛生考量而密封之商品（例如：內衣、內褲或貼身可愛背心等），商品如拆封檢查試穿（用）後再次出售，有影響衛生之虞，故可排除鑑賞期之適用，本產品屬於個人衛生用品，拆封無猶豫期 ，如欲退貨請勿拆封。 3.大多數商品均有現貨，幾乎當天出貨、若遇到缺貨也會聊聊告知或臨時有事會通知！ 4.小線頭等地方可能無法達到百分百完美，如果你是完美主義者請三思是否要購買喔! 5.電腦/手機觀看照片可能會產生色差問題，每一台電子產品所顯示出來的顏色可能也會有不同差異，商品都是親自拍攝，盡量拍到不要有色差問題了，如果十分介意色差問題的請考慮是否下標購買。 6.深色的布料本來在染的過程中就會吃比較重的染劑，在洗滌過程中可能多少都會有染劑的顏色洗出，多洗幾次應該就不會囉!勿過度恐慌！ 7.深色與淺色請分開洗滌，勿長時間浸泡，並參考水洗標籤洗滌。 8.收到商品後若有瑕疵或與購買商品件數種類不符合時，請保持商品完整於取貨1~2天內聊聊反應，拿到商品後一定要檢查是否有破損、汙損、件數是否完整，一旦拆掉吊牌、下水洗滌、試穿造成商品損壞則無法受理退貨退款喔! 9  貼身物品一經拆封、試穿，即不接受個人原因或花色等非產品瑕疵問題退貨，請水水務必確認好自己購買的商品。 10. 因手機或顯示器及拍攝燈光不同，可能會有輕微色差問題無法避免。 11.瑕疵定義: 衣物大面積破損、大面積汙漬...等嚴重影響穿著之情況。 12.非瑕疵定義: 色差、布料染劑味道、極小汙漬、輕微脫線...等不影響穿著之情況','2015-07-11 18:27:09',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (11,3,'CPMAX 潮牌寬鬆五分袖短T','顏色:T504黑、T504白  版型:寬鬆型  【尺寸】  ．160cm-170cm / 55kg-63kg / L  ．170cm-177cm / 63kg-70kg / XL  ．177cm-183cm / 70kg-80kg / 2XL  上述為估計尺碼，每個人身形不同，建議實際測量會更精準。  #CPMAX #CPMAX男上著 #CPMAX男短T  >>下標停看聽<<  1.  我們是台灣賣家，售前、售後都有100分的保障，  賣場提供非常完善的售後服務，絕對不會找不到人，  收到商品如果有任何問題，可以先私訊溝通，  不用急著給負評，請讓我們有好好處理、  服務您的機會。    2.  賣場低消99元限制，不含運費超過99元以上才會出貨。  不然商品太小，物流大哥很容易弄不見  就寄丟啦，也浪費了包裝材料。    3.  賣場的上班時間是週一~週五，國定假日、見紅休，  有時候忙著出貨，或處理其他事情，  會掛在線上但沒有即時回覆私訊，  請您一定要耐心等一下，絕對會回覆您，  不是故意不理的喔，  假日雖然休假但也是會抽空回覆的   4.  商品絕對都現貨，下標後2~3工作天會寄出，  偶爾會遇到追加期、斷貨、缺貨，  才需要多幾個工作天才寄出，請諒解喔','2016-01-03 01:18:11',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (12,3,'歐美大牌 新款 Levi\'s牛仔褲','溫馨提示：此商品目前均有現貨！購買可直接下單喔~下單之後請記得將所需編號用註記留言或即時通方式告知我們喔~方便我們按時為您出貨~謝謝^^  PS：到貨時間通常是下單之後隔天開始算5個工作日左右可以送到 當商品訂單動態顯示“訂單處理中”即代表商品已經出貨運送中 2到3天之後就會更新運送狀態喔~謝謝^^  關於售後：本店售後服務完善！請各位買家收到商品之後有任何問題都可以聊聊跟我們聯絡 我們一定會秉著 熱情 負責 的態度為您提供服務！直至問題解決！感謝^^！本店專注品質與服務！店內所有商品均使用實拍照片！用最直接的方式把商品最真實的狀態展現給大家！讓假貨無所遁形！歡迎各位新老顧客光顧 鑒賞！謝謝^^ ★★★★★ 我們以信用做服務！珍惜每次交易，希望各位也能誠信相待，謝謝各位！','2013-03-03 22:11:06',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (13,3,'全素面短袖大尺碼棉T六色舒適寬鬆好穿','熱賣 黑色全尺寸追加到貨 要買要快 限量 寬鬆版 純棉好穿舒服   商品名稱: 【611250】  商品尺碼:  2XL~4XL  商品描述:全素面短袖大尺碼棉  大尺碼 純棉短T  美式 休閒 潮T‧無LOGO‧加大/特大  商品顏色:黑色/紅色/淺灰/天藍/深藍/白色  注意:此系列為大尺碼   勿依據其他店家尺寸作選擇 4XL胸寬75cm，建議135kg，48腰以上穿著。 3XL胸寬70cm，建議115kg，44腰以上穿著。 2XL胸寬65cm，建議100kg，38腰以上穿著。','2012-06-12 08:23:43',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (14,3,'單件189元 4件只要599元 可穿到100公斤	','此賣場下標1組=4件599元...下標前先告知您要的款式.顏色尺寸..單品請各別賣場下標哦  下標前請先聊聊告知您要的款式.顏色.尺寸.確認有現貨再下標.若缺貨只能請更換別款  所有款式數量均只有幾件.售完不追加.會陸續增加新款式  由於還有其它平台販售.此款數量不多.若有缺貨需請買家更換或取消.以先下標並完成填單資料優先出貨.此款無法追加.售完為止  尺寸數據  L   衣長71cm／肩寬51cm／胸寬53cm／袖長24cm  XL衣長73cm／肩寬53cm／胸寬58cm／袖長24cm    ***缺貨款式: 2130 黑XL','2012-01-21 21:44:08',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (15,3,'加大尺碼吸濕排汗無袖背心',' sun-e加大尺碼吸濕排汗彈性無袖背心、加大尺碼台灣製造素面無袖背心、吊嘎、圓領背心、無挖背背心、炎夏必備背心、運動背心、慢跑背心、健身背心、百搭背心、台灣製造背心、背心T恤、素面背心、吊嘎背心、加大尺碼無袖背心、黑色無袖背心、深灰色無袖背心(310-7492-21)黑色(310-7492-22)深灰色 胸圍:3L 5L 7L(50~60英吋) [實體店面保障]    ▍類似熱銷款連結 Similar Items 加大尺碼吸濕排汗無袖背心 台灣製吊嘎 素面背心 運動健身背心 無挖背 彈性 T恤(310-7492)黑色 灰色sun-e sun-e加大尺碼台灣製造碼吸濕排汗無袖背心經典星星圖樣(310-7639-09)寶藍色(21)黑色     ▍成份 Content        Polyester 100% (聚酯纖維)     ▍商品細部描述 Item detail         台灣製造 加大尺碼 超輕量 有彈性 吸濕排汗無袖背心。       寬鬆、柔軟舒適 炎炎夏日 最涼快的穿搭。    ▍價格 Price        原價:1280元       特價: 290 元       購物滿1000元以上優待免運 ','2015-11-24 08:29:40',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (16,3,'加大尺碼-運動長褲-超彈力/速乾','尺寸 腰圍 大腿圍 臀圍  褲長(CM)  S   35.5  31.0  53.0  51.0  M   40.0  31.5  56.5  52.5  L   43.5  35.5  61.0  52.5  XL  44.0  36.5  64.5  55.0  XXL 51.0  39.5  69.5  56.0   承諾  7天鑑賞， 不喜歡 不滿意都可任意退換 請安心選購！   買家安心選購，小店會給您一次完美的購物體驗！   7天鑒賞自由退換 非質量問題除外，個人喜好原因退換貨來回運費由買家承擔唷 收到商品有問題請買家聯繫客服進行處理，拜託不要用負評來溝通，感謝理解   下單注意事項 本店所有販售的商品皆OUTLET或海外代工廠等正規管道購入，實品如圖，品質保證，出貨前都會確認品質，可以安心入手。 運送方式支援7-11/全家店到店，黑貓宅配 下單後商品從海外直送，到貨週期是6-8天左右，如特殊情況時間加長會另行通知。 代購講求誠信，只要下單我們會立即安排出貨，請評估自身消費能力再做下單動作，請體會代購先代墊的辛苦喔！ 商品購於outlet，或折扣店購入，部分產品可能會有細小瑕疵，但不影響品質和外表美觀。完美主義者請慎慮喔！  如有服務不周的方面請您再多多指教，NANA虛心接受改良，感謝您的惠顧唷^^','2017-04-20 08:18:41',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (17,3,'Adidas 經典三條紋 運動短褲','尺寸 腰圍 大腿圍 臀圍  褲長(CM)  S   35.5  31.0  53.0  51.0  M   40.0  31.5  56.5  52.5  L   43.5  35.5  61.0  52.5  XL  44.0  36.5  64.5  55.0  XXL 51.0  39.5  69.5  56.0   承諾  7天鑑賞， 不喜歡 不滿意都可任意退換 請安心選購！   買家安心選購，小店會給您一次完美的購物體驗！   7天鑒賞自由退換 非質量問題除外，個人喜好原因退換貨來回運費由買家承擔唷 收到商品有問題請買家聯繫客服進行處理，拜託不要用負評來溝通，感謝理解   下單注意事項 本店所有販售的商品皆OUTLET或海外代工廠等正規管道購入，實品如圖，品質保證，出貨前都會確認品質，可以安心入手。 運送方式支援7-11/全家店到店，黑貓宅配 下單後商品從海外直送，到貨週期是6-8天左右，如特殊情況時間加長會另行通知。 代購講求誠信，只要下單我們會立即安排出貨，請評估自身消費能力再做下單動作，請體會代購先代墊的辛苦喔！ 商品購於outlet，或折扣店購入，部分產品可能會有細小瑕疵，但不影響品質和外表美觀。完美主義者請慎慮喔！  如有服務不周的方面請您再多多指教，NANA虛心接受改良，感謝您的惠顧唷^^','2012-04-17 03:56:38',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (18,3,'Adidas 經典爆款 三葉草 T恤','男女同款 尺寸(CM): S   衣長：66  胸圍：96   肩寬：40    袖長;19  （適合50-55kg）  M   衣長：68  胸圍：100  肩寬：41.5  袖長;19.5（適合55-65kg） L   衣長：70  胸圍：104  肩寬：43    袖長;20  （適合65-70kg）  XL  衣長：72  胸圍：108  肩寬：44.5  袖長;20.5（適合75-80kg）  2XL 衣長：74  胸圍：112  肩寬：46    袖長;21  （適合80-90kg）    人氣單品定期更新！搶到賺到！   承諾  7天鑑賞， 不喜歡 不滿意都可任意退換 請安心選購！   買家安心選購，小店會給您一次完美的購物體驗！   7天鑒賞自由退換 非質量問題除外，個人喜好原因退換貨來回運費由買家承擔唷 收到商品有問題請買家聯繫客服進行處理，拜託不要用負評來溝通，感謝理解   下單注意事項 本店所有販售的商品皆OUTLET或海外代工廠等正規管道購入，實品如圖，品質保證，出貨前都會確認品質，可以安心入手。 運送方式支援7-11/全家店到店，黑貓宅配 下單後商品從海外直送，到貨週期是6-8天左右，如特殊情況時間加長會另行通知。 代購講求誠信，只要下單我們會立即安排出貨，請評估自身消費能力再做下單動作，請體會代購先代墊的辛苦喔！ 商品購於outlet，或折扣店購入，部分產品可能會有細小瑕疵，但不影響品質和外表美觀。完美主義者請慎慮喔！  如有服務不周的方面請您再多多指教，NANA虛心接受改良，感謝您的惠顧唷^^','2016-08-19 03:49:34',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (19,3,'CS衣舖 3件999元 超低價!高品質!','多款人氣 工作褲	本賣場無法799免運費唷     嚴選 賣場多款工作褲/休閒褲  批發價促銷優惠!!   任選3件 999元 ！(單件333元)! (原價3件1170元)   〈《 最佳選擇：工作褲專賣，實體店面批發經營逾20年，隨貨附發票 》〉  附註： 1.下標\"1\"等於3件 999元！(運費需另計) 2.注意!!!此款運費另計唷！因促銷優惠價，結帳金額應為999+70=1069超商取貨付款! 3.下標完成後，請至訂單內留言“款式編號＋顏色＋尺寸” 4.實體店面批發經營，品質嚴選，選購安心! 批發價活動促銷，請各位買家把握機會唷! ','2015-04-23 06:41:11',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (20,3,'立領素色剪裁休閒襯衫','材質:棉麻.舒適透氣 顏色:白色.藍色 尺寸: L 肩 48  胸62  袖68  衣長79 XL 肩50 胸65  袖69  衣長80 XXL 肩 53  胸70 袖70  衣長83','2015-05-11 14:04:10',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (21,4,'最新藍芽升級版','原廠正品 送藍芽手把+海量3D資源+獨家影片 小宅Z6 VR眼鏡 3D眼鏡虛擬實境	產品規格：  VR頭盔規格：  版本：小宅6無線藍芽版  ＮＣＣ:CCAJ19LP8130T0  與手機聲音連結方式：藍芽連線輸入 尺寸：140x181x115mm(摺疊後) 重量：約407g 機身工藝：ABS支架+北歐風格蒙布工藝+親膚泡棉 鏡片：日本52mmPMMA專業光學鏡片 近遠視調節：近視約0-400度 &遠視約 0-200度調節 視角：約110度  藍芽耳機續航時間：約6小時   ♛產品特色♛:  1.全新720度環繞音效設計，搭配HIFI包耳式耳罩，提供最佳的私人饗宴  2.鏡片採用日本抗藍光光學鏡片，擁有110度超大視角，在家足不出戶也可以享受大螢幕的饗宴  3.VR眼鏡本體擁有可調節焦距，能調整為每個人適合且舒適的視角  (由於鏡片採用52mm鏡片~無需再調整瞳孔距離，有效減少暈眩發生機率)  4.機身材質採用ABS+PC，重量更輕，更適合長時間配戴  5.貼臉材質採用網狀運動織布，透氣性佳，有髒汙時可拆下做清洗  6.此款VR自帶耳機，可直接於VR本體調整音量，暫停及撥放，可輕鬆享受VR影片  7.藍芽連線，不需要再受到線的束縛，沒有耳機孔的手機再也不需要轉接頭即可  直接連線使用，不使用VR的時候也可以拿來當藍芽耳機，享受高品質音樂饗宴  8.震撼音效優化，效果更佳        VR手把規格:  NCC認證號：CCAJ16LP4350T9(相當重要 沒有認證號皆為沒經過檢驗的商品有對於身體損壞的疑慮，一點保證都沒有！) 尺寸:116x45x13.5mm 重量:40g 連結方式:藍芽連線 電量供應:需使用4號電池兩顆 支援: iOS / Android 功能: 自拍/音樂/視頻/搖控     ☞本賣場提供的資源包含1.VR遊戲 2.VR影片 3.VR\"3D\"迷片(獨家資源) 4.VR電影 絕對不像別家說說的而已 曾經有其他買家跟別人買結果只有一點資源 還跑來跟我買資源Orz(本賣場不販售資源哦！)，何必花冤枉錢呢 ?     ☞本賣場與全台各地區有合作VR推廣科技，並提供產品教學，歡迎各級學校機關團體採購，本公司可開立統一發票(沒發票以免找不到人做保固哦,需要三聯式請先告知)     ☞VR各款有什麼差異?先來說說VR差別在哪裡,差別在開模本身不同,做工也不同,大部分VR沒有內建耳機，手機也容易掉出來等等，散熱差異     ☞哪款手機適用小宅Z6 VR眼鏡?只要4.7~6.5吋手機都可以使用，越高清的影片效果越好(不知道是否可以使用歡迎聊聊諮詢哦！)     ☞請問今天下單 哪時候可以收到商品呢?商品皆有現貨,每天結單至中午,到貨時間都是2~3天(假日不出貨哦！)     ☞戴眼鏡可以使用嗎?當眼鏡的鏡框不超過14x5cm即可直接戴著眼鏡觀看的哦！     ☞藍芽手把可以提供什麼功用呢?不需要將手機從VR眼鏡內拿進拿出,大大增加商品便利性哦！(此款手把有內建遊戲廳可暢玩大量免費遊戲，安卓蘋果皆可玩)     ☞VR3D害羞資源取得方式?當您收到貨後，請評分5星以及商品按讚，私訊我即可提供害羞資源     品質保證，優良的信譽評價，才是您的首選。  (✦資源不定期都在新增與更新✦)  我們保證!  正品-不怕買到山寨版！  現貨-無須漫漫等待！  資源隨貨附贈-收到馬上看不必等！','2015-08-17 18:37:40',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (22,4,'Tronsmart Force+ IPX7藍芽喇叭','NCC字號:CCAJ21LP11A0T8 BSMI:R55984  公司貨一年保固  IPX7防水將Force +帶到海灘或游泳池，而不必擔心灑水甚至浸入水中。 強大的低音最大輸出功率40W，無源輻射器可為任何房間提供純淨的聲音。 語音助手 ² 按住“播放/暫停”按鈕2秒鐘，您現在就可以通過揚聲器激活並與設備的語音助手通話。 真正的無線立體聲配對兩個Force +揚聲器以獲得終極3D立體聲，以增強您的音頻體驗。 三重低音效果可以更改3種均衡器音頻模式以適合任何音樂類型（3D立體聲，超重低音和標準）。 支持NFC通過一觸式NFC技術輕鬆連接和傳輸音樂。 注意：極端溫度會損壞電池。（建議使用溫度為-20°至60°C或-4°至140°F，可充電0°至40°C或32°至104°F。）  ▪ 關於三重低音效果，如何切換音樂效果？ 您可以按EQ按鈕來切換音樂效果。默認效果是超重低音（LED熄滅）。3D效果隨綠色指示燈亮起，而標準音樂則帶白色指示燈亮起。   ▪ 是否可以連接到另一個Element Force +以便通過藍牙同步播放？ 是的，您可以將兩個Element Force +藍牙揚聲器配對以同時播放音樂。 如何連接兩個揚聲器： 1.打開兩個揚聲器，並確認它們已與任何藍牙設備斷開連接。 2.在一個揚聲器上按住EQ按鈕2秒鐘，然後您將聽到語音提示，這表明它已進入兩個揚聲器配對模式，並等待它們自動相互配對。兩個揚聲器成功連接後，您會聽到另一個聲音提示。 3.轉到設備的藍牙設置，掃描“ Tronsmart Element Force +”，然後單擊以與之配對。   ▪ 充電需要多長時間？ 大約3個小時。  ▪ 我怎麼知道它充滿電？ 紅燈亮表示正在充電。紅燈熄滅表示充電完成。  ▪ 電池可持續使用多長時間？ 約15小時。依實際使用時間為主  ▪ SD插槽中可以支持的SD最大尺寸是多少？ 我們建議32GB。  輸出功率 2 x 20W最大 傳輸距離 30m / 100ft（開放區域） 頻率 80Hz-18KHz的 防水 IPX7 電源 直流5V / 2.4A 電池容量 3300mAh x 2 上場時間 長達15小時（中等音量） 充電時間 約3小時 驅動單元 53毫米 失真 ≤1.0％ 連接器 USB-C充電端口，TF / Micro SD卡插槽，3.5毫米輔助輸入端口 尺寸 209 x 64 x 83mm 淨重 667±5克/ 包裝內容 1 x Element Force +藍牙揚聲器，1 x充電電纜，1 x 3.5mm AUX電纜，1 x 60cm掛繩，1   圖片由廠商提供,如有侵權請告知移除，謝謝!  【❝商品實際出貨時間可於客服洽詢 ❞】 如有急用或是型號商品請於下單前詢問出貨時間  【商品皆為「台灣」出貨】 【商品皆為「台灣」出貨】 【商品皆為「台灣」出貨】   本產品皆以實品拍攝商品，但因拍攝時受環境、光線影響，顏色表現可能會與實物有稍許誤差，出貨以實際商品為準。  【送貨時程說明】  ✅現貨商品✅ 下午兩點前下單當日出貨（週一～週五） 其餘時間與急用者請先與客服確認確認出貨日 時間！ 現貨則依照上述時間出貨!  如遇缺貨將進行→自動追加! 如廠商通知停產會在第一時間告知  依商品到貨時間略有不同。 皆以最快速度出貨給各位買家！  【配送時間】 7-11、全家、萊爾富→出貨後兩到三天到達 宅配→採新竹物流＿(出貨後非偏遠地區為隔天到達)','2014-02-27 21:13:31',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (23,4,'iphone線 Baseus 倍思編織線 蘋果充電線','品牌: 倍思 Baseus (大廠品質佳) 適用型號:iPhone5/5s/6/6s/6plus/7/7 plus/touch/ipad (適用Lightning port的設備均可使用)  功能:可傳輸資料、可充電  優點:雙面皆可使用、正反可插、標準USB2.0接頭  長度:120 cm (1.2M)   原廠盒裝出貨，拆封使用、人為操作使得線材受損者一律不退換 如收到商品有問題，請連繫我們幫您處理，並請保持線材及盒裝完整   ✅ 原廠盒裝出貨，拆封使用、人為操作使得線材受損者一律不退換 如收到商品有問題，請連繫我們幫您處理，並請保持線材及盒裝完整  ✅ 保固服務：非人為因素保固ㄧ年，超過7天商品需更換者，請自行負擔來回運費。 ⚠️請注意！保固以原廠出貨盒裝為憑，遺失恕無法享有保固服務⚠️  ❌有以下情況者屬人為因素損傷(請注意!) ❶因泡水、受潮、撞擊、刮傷、拉扯過度所造成之損壞者。  ❷自行拆解或保固標籤毀損不明者。  ❸錯用機型、拉拔方式錯誤等不當使用所造成之故障。    支援iPhone 5, iPhone 5s, iPhone 6, 6 plus, iPhone 6s, 6s plus, iPhone 7, iPhone 7 plus , iphone8 , iphone X','2014-09-06 18:43:22',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (24,4,'iphone轉hdmi 手機投影  高畫質','【iPhone轉HDMI線】 手機螢幕投影到電視~小螢幕變大螢幕!!!  支援最新版iOS 13 iPhone 5~ iPhoneX、iPad支援 iPhone XR、XS、XS Max不支援，請勿下單  LINE TV、小鴨影音、愛奇藝支援  ●2米超長線 ●免安裝，隨插即用 ●支持1080P高畫質 ●小螢幕變大螢幕超EASY ●適合場景:追劇/家庭劇院/好友分享出遊照片/露營/朋友聚會/會議/玩遊戲/婚禮現場播放  另有安卓/蘋果通用款(支援到iOS 12)   「保固說明」 非人為因素造成損傷，保固3個月 線材過保後無法使用可以+50元直接換購一條新的 (買家需自行負擔來回更換運費）  ※ #woori3c 貼心小提醒 1.USB孔是給線材供電的，如果手機電量跳到100%是正常的，不會幫手機充電!! 2.一律要使用2A充電插頭，不然會造成電壓不穩 3.一定要電視出現HDMI線材的畫面後才可以將手機接上 4. 部分有版權或付費的影音內容不支援畫面投影（請參考圖片說明） 5.線材本身有保護機制，過熱會自動中斷投影以免損壞發生，建議投影時將手機亮度調到最低  #hdmi轉接 #hdmi影音傳輸 #手機投影到電視 #同屏器 #同步器 #螢幕分享器 #影音傳輸 #影音同步分享器 #iphone投影#hdtv線 #mhl轉hdmi','2016-01-13 19:45:55',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (25,4,'Iphone 12【128G】6.1吋 蘋果 APPLE i12','我們有9家門市同步銷售 貨量流通快  歡迎撥打欲取貨門市做詢問顏色/貨量狀況比較準確唷！ 若有其他問題也煩請電洽詢問比較清楚唷~謝謝^^  Apple iPhone 12 128GB 支援 5G 行動上網 6.1 吋 OLED 顯示器 Apple iPhone 12 配置 6.1 吋 2,532 x 1,170pixels 解析度超 Retina XDR 顯示器，搭載 OLED 螢幕面板，不僅對比度顯著提升，同時具備 HDR、原彩顯示，讓螢幕表現更上層樓。  超瓷晶盾面板 Apple iPhone 12 採用航太等級鋁金屬邊框設計，結合超瓷晶盾面板與玻璃機背，同時為加強機身防護效果，特別導入奈米級陶瓷晶體，以及雙離子交換製程，提升防刮表現；具備 IP68 防塵防水等級。  A14 仿生晶片 Apple iPhone 12 搭載 A14 仿生晶片，採用新一代神經網路引擎，運行 iOS 14 作業系統，提供 Wi-Fi 6、藍牙 5.0、NFC 等連線功能。支援快速充電功能，具備 15W MagSafe 無線充電、7.5W Qi 無線充電模式。  5G 上網 Apple iPhone 12 具備 5G 上網功能，除了能夠串流播放更高畫質的影片，享受超低延遲的多人連線遊戲體驗外，搭配智慧型數據模式，可在 iPhone 進行背景更新時，自動切換 4G 網路節省電力消耗。  杜比視界錄製 Apple iPhone 12 前置 1,200 萬畫素原深感測相機，提供智慧型 HDR 3 場景偵測功能，擁有人像模式，具備 Face ID 臉部辨識。後置 1,200 萬畫素廣角 + 1,200 萬畫素 120 度超廣角雙鏡頭，內建夜間攝影模式，支援即時杜比視界錄製，享有電影級的畫面表現。  Apple iPhone 12 128GB 功能特色 ◎ iOS 14 作業系統 ◎ 6.1 吋 2,532 x 1,170pixels 解析度超 Retina XDR 顯示器（OLED 螢幕） ◎ A14 仿生晶片 ◎ 128GB ROM ◎ 1,200 萬畫素 + 1,200 萬畫素主鏡頭、1,200 萬畫素前鏡頭 ◎ 5G 上網、Wi-Fi 6、藍牙 5.0、NFC ◎ IP68 防水防塵 ◎ 支援杜比視界錄製、夜間攝影、智慧型 HDR 3 模式 ◎ Face ID 臉部辨識 ◎ 支援有線快速充電、15W MagSafe 無線充電、7.5W Qi 無線充電 ◎ 採用 Lightning 連接埠 法規小提醒 電信法 49 條第 3 項規定，電信管制射頻器材非經型式認證、審驗合格，不得製造、輸入、販賣或公開陳列。 電信法 65 條第 1 項第 10 款及第 2 項規定，擅自製造、輸入、販賣或公開陳列未經型式認證、審驗合格之電信管制射頻器材者，處新臺幣十萬元以上五十萬元以下罰鍰，並得沒入其器材之一部或全部。 電信法 50 條第 2 項授權訂定之電信管制射頻器材審驗辦法第 15 條第 1 項規定，審驗合格標籤及符合性聲明標籤專屬取得型式認證證明者及完成符合性聲明登錄者所有。 刑法第 211 條規定，偽造、變造公文書，足以生損害於公眾或他人者，處一年以上七年以下有期徒刑。 買家可將賣家提供之型式認證編號或標籤利用「型式認證查詢連結」進行查詢商品合法，確保消費權益。','2012-08-27 04:30:47',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (26,4,'迷你鏡面快充行動電源 20000mAh','本商品規格 產品參數： ★適用類型：99%手機及平板電腦 ▲材質：PVC+ABS ▲顏色：黑/白/紅 ▲電芯：聚合物鋰離子電芯 ▲電池容量: 20000mAh ▲輸入: 5V/2.1A（MAX） ▲輸出: 5V/2.1A（MAX）、雙輸出孔 ▲尺寸: 93*65*22.5mm ▲重量：200g ▲充電時間: 8-9小時（5V/2.0A規格）（行動電源蓄電時間依不同規格的充電器而有所不同） ▲工作溫度: 0℃～45℃（千萬不要把它留在車內或主控台上！台灣的天氣太熱，車內的溫度可以高達50度以上，會使主機受損或導致電池膨脹）','2017-04-04 06:30:26',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (27,4,'Sanrio Hello Kitty 正版授權 iPhone 12 支架保護殼 保護套 手機殼	','? Sanrio 三麗鷗 正版授權 支架保護殼。  ☑️ Hello Kitty 全包覆 支架功能，防摔保護殼。  ☑️ 蝴蝶結支架造型，全包覆矽膠軟殼。  ☑️ 一秒變支架，觀看影片超方便。  ☑️ 鏡頭加高設計，有效防止鏡頭刮傷。','2017-06-14 01:36:21',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (28,4,'保證 最高規 iPhone 11 X 8 7 6 5 充電器 豆腐頭 for iPhone','★保證網路最高規，奇摩平均售價350元上下★     奇摩限定，限量900組特惠，售完即調整為門市售價  公司保固一年/享有七日鑑賞期     本公司成立已超過五年，享有公司三大保障  ➤唯一奇摩，評價破萬，成立至今五年以上  ➤唯一開立電子發票，祝中1000萬頭獎  ➤唯一提供七日鑑賞期，保證退換不囉嗦     我們的配件主要批發給各大通訊行及電信門市，保證全系列8pin皆可使用，升到 ios13都不會跑出警語：    適用於：iPhone11 Pro Max、11 Pro、11、XS Max、XS、XR、X、8 plus、iPhone8、7 plus、iPhone7、iPhone6S plus、iPhone6S、iPhone6 plus、iPhone6、iPhoneSE、iPhone5S、iPhone5、iPod touch5...iPhone及iPod全系列、包括其他品牌所有手機    薄利多銷只為了請大家下標幫我們加加分，麻煩請下標取貨後給予評價給我們告知，好貨不多敬請把握，謝謝     保證正常來源，我們一次大量進貨，才有這種優惠的價格回饋給各位，給您拆開檢驗質量都不怕!!!為了您兩三萬的寶貴手機，別再買大陸製的便宜貨讓他心驚膽跳的充電了     市面上有許多賣家、店家，拿劣質品低價網路上賣，卻號稱高品質的促銷，真正高品質有可能那麼便宜嗎？您敢使用大陸製的黑心電蕊嗎？那不只您的手機會燒掉，連您的生命安全都有疑慮！      五大保障，您可：  1.可當場試用，看是否使用上和手機裡附的那顆功能相同！  2.可將線的部份割開一小洞即可看出裡面線材是否如我們所描述！  3.保固內有問題不囉嗦！  4.保證不滿意可退！  5.七日內有問題直接換新！     五大保證：  保證來源正常  保證最低價  保證手機全系列通用  保證安全無顧慮  保證買到賺到     【BSMI認證字號】 1A充電豆腐頭 BSMI:R34945    每一筆交易視同一份買賣合約，購買前請確認是否賣家皆有提供完善的五大保障與五大保證    並確認一下該賣家是否有合法營業登記，是否有提供發票，避免喪失您購買後的寶貴權益     保證只要是手機系列的，全系列皆可用！           ※ 關於充電線與周邊商品，消費者的疑問，我們在這裡統一做個回答※     問：為何我們優惠價可以這麼便宜?    答：我們和廠商簽約的量一次是以萬計量，一條的利潤真的就只有幾十塊，品質好且真正耐用，為了衝評價薄利多銷！     問：這真的是不會有問題嗎？    答：任何電子產品在出貨時也不能保證良率100%，，更何況是3C吃電的產品！但我們的良率絕對有保障，以我們賣3C產品七年以上的經驗，產品1000個裡面絕不超過3~5個瑕疵，瑕疵率非常低，且就算瑕疵，我們七天內保證您不用花一毛錢馬上免費幫您換一條新的！     問：商品如何保固？    答：從您收到產品的那一天起就開始算保固，保固時間一年。我們可以免費幫您代送更換一條全新的，直接告知我們即可     問：那保固範圍為和？    答：只要非人為損壞都保固，常見的人為損壞就是線的外觀有破損，相信跟我們買過線的朋友們、批發過線的店家們，應該很瞭解我們的誠信，我們售出的商品敢說出的保證，一定不會縮水的！！有問題保固內免費換，有疑慮二話不說七天內免費退，想退想換我們說得出、作得到！     其實老實說，產品的部份我們比消費者還要擔心出狀況，經營網路五年以上的信譽與誠信總不能出了狀況被影響，所以每次貨到倉庫，我們檢測的標準與成本非常嚴格，今天任何消費者買了這些商品，我們敢給出的保證，請您絕對不用擔心！','2018-03-26 18:48:20',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (29,4,'漸層 漸變 iPhone 7/8 Plus 11/12 Pro Max 轉聲防摔殼 透明殼','? 四角防摔 漸層 轉聲保護殼。   ☑️ 矽膠邊框漸層，漸變配色，透明防刮背蓋。  ☑️ 轉聲防摔保護殼，喇叭孔防塵設計。  ☑️ 四角防摔保護，高於螢幕，高於鏡頭，有效防護。  ☑️ 矽膠軟邊框，簡易拆裝，不傷機身。  ☑️ 漸變色彩，雙色搭配，超美設計。','2018-07-08 10:23:05',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (30,4,'20D滿版鋼化玻璃貼 	圖片顏色會因為燈光效果略有誤差，以實際商品為主','＊ 下標前可先在問與答詢問唷 ＊ ','2016-04-27 02:38:09',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (31,4,'Wii原裝右手(全新)手柄/把手/手把，內建\"動感強化器\"附掛繩 附果凍套','[全新]原裝右手 內建\"動感強化器\"附果凍套 吊繩!  《黑色另有開單!》  ★為方便測試下單默認同意散裝出貨!   ❰ 相 關 商 品 ❱ 點選名稱可直接進入賣場!  副廠單右手 (內建強化器 / 附套+繩) 原廠單右手 (無內建強化器 / 附套+繩) 原廠單右手 (無內建強化器) 原廠單右手 (黑 / 內建強化器) 原廠單右手 (白 / 內建強化器) 副廠單左手  原廠單左手 原廠單左手 (藍) 原廠左右手 (內建強化器 / 附套+繩) 原廠左右手 (黑 / 內建強化器 附套+繩)  副廠全新加速器 原廠二手加速器   更 多 商 品 。。。點 選 圖 片 可 進 入 賣 場 呦 ☺ ~','2010-03-02 14:09:51',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (32,4,'NS Switch Lite 搖桿帽 Joy Con 貓掌	','','2011-06-04 04:51:27',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (33,4,'Switch無線手把 任天堂 Nintendo switch PRO 手把 NS 控制器','【商品】  良值 新款第二代    NS Switch 手把    商品特色:  * 專業玩家必備，為您帶來前所未有的深度遊戲體驗    * 6軸感應功能精準度，與強力的震動感功能，玩家一致好評    * 搭載連發連射及取消功能，百戰百勝    * 曲線人體工學設計，貼合手部完美舒適握感    * 雙馬達震動，享受臨場力道感    * 快速連接，操作簡易好上手    * 一機多用，一支手把搞定所有需求，電腦也可用CP值很高喔~    * 7~8小時大電量長效續航，讓您玩遊戲通宵不擔心沒電!    *最新款副廠手把，品質良好，非一般低價副廠Switch手把品質    【商品內容】  手把*1、充電線*1、說明書*1    【商品顏色】  非版本NFC: 搖滾黑    【注意事項】  以上產品之規格，如與實際產品有任何不相符之處，應以實際產品為準。    【保固服務】  提供7天非人為故障免費換新，歡迎給五星好評支持，加碼提供非人為故障3個月保固服務。  台灣賣家，給您安心的完善服務（四星以下負評視同放棄保固服務）  NCC：CCAJ19LP0FE0T2','2012-07-01 01:38:49',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (34,4,'任天堂 Nintendo Switch NS 大容量收納盒 防撞盒 收納包 ','☑️ 便攜-標準款 (可收納主機與遊戲卡片)    ? 任天堂 Switch 專用收納盒    ? 硬式材質 可收納20張卡片 提把設計    ? 標準款 底部四腳設計 有效防摔 攜帶方便    ? 標準款 長26.7cm厚5cm寬12.5cm/200g','2014-01-21 07:46:57',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (35,4,'高清無線2.4G紅白機 任天堂電視遊樂器	','','2010-10-09 03:19:05',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (36,4,'贈特典 任天堂 switch 瑪利歐 高爾夫 超級衝衝衝 中文版 ','公司貨	操作簡單，卻能遊玩到正規的高爾夫球。瑪利歐高爾夫系列的最新作品將於Nintendo Switch登場。觀測風向與地形，仔細思考才擊球吧！在大自然豐饒的場地，操作熟知的瑪利歐角色，遊玩正規的高爾夫球。本作充滿了各種各樣對攻略場地有幫助的新要素，例如︰讓球徑彎曲方向一目瞭然的力量計量表、可以調查場地高低起伏點的偵測功能等等。除了按鍵操作外，也可以選擇「揮桿操作」，使用Joy-Con來當球桿。這樣一來，身體的動作會直接反映到遊戲中，輕輕鬆鬆就能夠遊玩高爾夫球。此外，在新的瑪利歐高爾夫中，還有很多讓玩家之間的對戰變得更有趣的新要素！其中一項就是「快速高爾夫」。大家同時擊球後，馬上跑向球的落點，並再次擊球……最快把球打進球洞的人就是勝利者。這項比賽比拚的不只是技術，衝刺跟絕招的使用時機也是影響勝負的關鍵。本作還收錄了「冒險模式」，可以使用自己的Mii當主角，以高爾夫球初學者的身分與瑪利歐的角色們進行交流，獲得成長。使用比賽中獲得的經驗值來升級之後，就可以按喜好分配點數到各項能力，自由地培育角色！也可以使用培育的Mii來進行對戰啊！本作支援鄰近主機通訊及網路通訊，最多可讓4人對戰。不管是一個人仔細品味，還是大家一起熱鬧地遊玩，都隨你喜歡。按照自己的風格來選擇遊玩方式吧。','2019-10-04 09:52:39',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (37,4,'NS無線遊戲手把 任天堂 Nintendo switch pro控制器	【良值 第二代/第四代  Switch無線手把】  ','商品特色:  * 專業玩家必備，為您帶來前所未有的深度遊戲體驗  * 6軸感應功能精準度，與強力的震動感功能，玩家一致好評  * 搭載連發連射及取消功能，百戰百勝  * 曲線人體工學設計，貼合手部完美舒適握感  * 雙馬達震動，享受臨場力道感  * 快速連接，操作簡易好上手  * 一機多用，一支手把搞定所有需求，電腦也可用，CP值很高喔~  * 7~8小時大電量長效續航，讓您玩遊戲通宵不擔心沒電!  *最新款副廠手把，品質良好，非一般低價副廠Switch手把品質      ? 四代NFC喚醒版 比 二代手把 多了什麼??  * 支援NFC功能：可使用amiibo專屬功能，隱藏關卡解鎖、虛寶拿不完 (需搭配支援的遊戲NFC)  * 支援喚醒功能：透過手把一鍵操控即可喚醒switch，隨時輕鬆開戰  * 安靜無擾：手把可搭配上3.5mm耳機，遊戲時聲音不干擾同住家人    【基本規格】  產品名稱: 良值 第二代/第四代  Switch無線手把  產品品牌: 良值  產品材質: ABS  充電電壓: 5V  商品內容: 無線手把*1、充電線*1、說明書*1、原廠外盒*1、品牌小卡*1    【商品顏色】  四代NFC喚醒版:   白(寶可夢劍盾配色)、白(黑白)、皮卡丘黃、胖丁粉、馬力歐紅、搖滾黑  二代(無NFC、無喚醒):  搖滾黑    【注意事項】  以上產品之規格，如與實際產品因原廠更新而有任何差異之處，應以實際產品為準。    NCC：CCAJ19LP0FE0T2    -------------------------------------------------------    ?台灣賣家  ｜監視器｜手機週邊配件｜居家商品｜藍牙耳機｜喇叭 專賣～  歡迎關注、不定期上架新鮮貨❤️      『售後服務及保固』：  1. 商品主體非人為因素保固3個月(不含耗材及配件，像是: 充電線...)  2. 退換貨問題請聯繫客服依指定方式寄回，寄回商品請妥善包裝，以減少商品在運送途中受到碰撞損壞  3. 商品完整性將影響退貨權益，若有不完整情形(含原廠外盒及贈品)，恕無法辦理退貨  4. 7天鑑賞期內（包裝、商品需完整無傷無缺件），因新品不良(經寄回檢測後確認)，提供換貨服務  5. 超過7天鑑賞期～保固期內，商品可更換，買家需自行負擔來回運費  6. 因摔傷、自行拆解、誤用電源、受潮等人為操作失當造成商品主體損壞者不在保固範圍之內      #switch #switch手把 #無線手把 #switchpro手把#NS手把 #NS控制器 #任天堂 #搖桿 #良值 #NFC #Nintendo #寶可夢劍盾 #switch控制器 #手柄 #一鍵喚醒 #良值四代手把','2017-08-12 02:26:50',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (38,4,'任天堂NS SWITCH 加強電力版 單機組 台灣公司貨 全新商品','Nintendo Switch 台灣公司貨主機 X1  「Joy-Con(L)」和「Joy-Con(R)」專用遙控器 X1 「Joy-Con握把」X1 「Joy-Con腕帶」X2 「Nintendo Switch底座」X1 HDMI連接線 X1 專用AC變壓器 X1','2014-09-13 17:27:42',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (39,4,'HD5 雙USB車用藍牙MP3','HD5 可通話 車用MP3 MP3發射器 可通話 雙USB孔 SD卡/隨身碟播放 AUX  3.1A電流輸出 隨身碟/記憶卡/藍芽播放 CP值極高!!!  ◆品名：【Gmate】第五代雙USB車用免持藍牙MP3播放器HD5  ◆品牌/型號：Gmate / HD5  ◆尺寸：約38x45x73 mm (厚度約13mm)  ◆顏色：鋼琴黑  ◆顯示螢幕：LED顯示  ◆輸出電流：3.1A+1A (雙USB智能電流)  ◆藍牙版本：4.0  ◆音頻孔尺寸：3.5mm  ◆輸出電壓：DC/5v  ◆發射距離：＜5米 (無障礙)  ◆頻率：87.5-108MHZ  ◆使用電壓：12V-24V  ◆液晶螢幕尺寸：1.1英吋  ◆信噪比：85db  ◆記憶卡：支援4-32G  ◆支援音樂格式：MP3 / WMA  ◆內容物：商品主機x1 /  保固卡x1 / 說明書x1   ◆保固期限：保固主機3個月 ※附有保固書/操作說明書 ※藍牙可支援iOS系統與Android系統 ※NCC認證字號：CCAH16LP3840T1 BSMI:R3A425 標準配備  保固卡x1 / 說明書x1  保固範圍 3個月保固期  保固方式：非人為因素將可享有免費保固，若經代理商判斷為人為因素將酌收維修費用。  本商品無防水功能 以下狀況恕不在保固內  ◆因泡水、撞擊、刮傷、拉扯過度所造成之損壞者。   ◆自行拆解或保固標籤毀損不明者。   保固資訊詳見商品保固卡 ','2017-04-05 00:32:17',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (40,4,'贈32G+10米後拉線 10吋屏觸控流媒體電子後視鏡/GPS/行車紀錄器/前後鏡頭1080P/無光夜視','全屏10\"屏幕，直覺觸控操作  採用SONY 6玻璃鏡頭、光圈 F1.7，  170度超廣角，可伸縮調整 高規格鏡頭，最低價給您！  拉線分離式後鏡頭，想照哪裡就裝哪裡  螢幕自動關屏，可直接當作後視鏡   支援GPS測速功能，不再有罰單困擾  倒車顯影功能，可調式前後鏡頭，上下滑動螢幕調整視角  倒車不再有死角，新手也能完美停車  重力感應，發生意外，檔案不流失  星光夜視，夜晚依舊清晰可見  怕線不夠長? 自動幫您升級10米線，休旅、小貨車都沒問題！  操作教學影片 /watch?v=CDJ3CueGiyE  商檢字號：R55636 型號：H-600   本產品保固90天   保固範圍為主機,配件不在保固範圍內  如果使用非本產品之配件導致機器損壞,不在保固範圍內。  下標前請參看關於我  下標視同同意關於我中之描述  如不能接受者請勿下標,謝謝!!!','2012-09-07 12:29:01',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (41,1,'CPMAX 髮箍式防護帽 防飛沫帽 透明面罩','顏色:髮箍式-藍色、髮箍式-玫紅、髮箍式-黑色  材質:PC  規格:大人款  適合頭圍:54-58  #CPMAX 居家生活  >>下標停看聽<<  1.  我們是台灣賣家，售前、售後都有100分的保障，  賣場提供非常完善的售後服務，絕對不會找不到人，  收到商品如果有任何問題，可以先私訊溝通，  不用急著給負評，請讓我們有好好處理、  服務您的機會。    2.  賣場低消99元限制，不含運費超過99元以上才會出貨。  不然商品太小，物流大哥很容易弄不見  就寄丟啦，也浪費了包裝材料。    3.  賣場的上班時間是週一~週五，國定假日、見紅休，  有時候忙著出貨，或處理其他事情，  會掛在線上但沒有即時回覆私訊，  請您一定要耐心等一下，絕對會回覆您，  不是故意不理的喔，  假日雖然休假但也是會抽空回覆的   4.  商品絕對都現貨，下標後2~3工作天會寄出，  偶爾會遇到追加期、斷貨、缺貨，  才需要多幾個工作天才寄出，請諒解喔','2013-01-15 15:19:48',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (42,1,'四層活性碳口罩拋棄式口罩成人口罩','品名:單片裝50入盒裝四層活性碳口罩  此商品不具任何療效    ~>其他款口罩專區點我進入<~  離島運費另計，請洽問與答諮詢  數量 價格  可選運送方式 1盒  50片  99元  便利商店、宅配  40盒  3200元  宅配       >>>超取(7-11全家)體積限制最高下標限制18盒<<<  >>>超取(OK萊爾富)體積限制最高下標限制15盒<<<  ★款式與尺寸★  款式：成人平面活性碳-灰色  規格：17.5*9.5cm    款式：成人平面活性碳-黑色  規格：17.5*9.5cm','2016-04-07 20:06:13',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (43,1,'防疫我最強國鼎紅敏風錠60粒/瓶','適合注重養生保健及調節生理機能或病後保養之族群    保存期限  2年    內容物成份  安卓奎諾爾      內容量  500mg       品名  紅敏風     廠商名稱  國鼎生物科技     廠商地址  淡水區   廠商電話號碼  0228086006   每份營養成份          熱量          產地  台灣   製造/有效日期    食品添加物名稱  ','2016-10-17 15:52:38',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (44,1,'精油 水氧機 香薰機 香氛機','SYDNEY法國高級香薰精油  來自植物,花卉或水果,葉,莖,根,萃取植物精華  純靜,溫和,芳香  適用於水氧機,香薰機,加濕器,香薰爐等  賣場中的精油，都經SGS認證 ，請放心使用  優惠活動: 買3瓶20ML香薰精油多送1瓶 買6瓶送~100ML(USB)水氧機或香薰爐 買10瓶送~遙控水氧機1台喔! (3款可選,下單留言您要的款即可)   43種香味可選 下單留言您要的香味編號數量即可 感謝您的訂購^-^  SYDNEY 法國高級精油    各香味皆有現貨  請直接下單後在留言處留下您喜歡的精油味道編號即可    花香:  1.薰衣草       2.玫瑰  3.百合  4.茉莉  5.櫻花  6.薑花  7.梔子花  8.橙花  9.夜來香  10.白玉蘭  11.紫羅蘭  12.風信子  13.洋甘菊    草木:  14.茶樹  15.檀香  16.香茅  17.綠茶  18.薄荷  19.尤加利  20.白麝香  21.迷迭香      果香:  22.檸檬  23.青蘋果  24.水蜜桃  25.葡萄柚  26.佛手柑  27.熱情果     情境:  28.陽光  29.海洋  30.雨中曲  31.東方風韻  32.繽紛夏日  33.雨後花園    酒店香型:  34.香格里拉  35.長隆酒店  36.四季酒店  37.威尼斯人  38.伊麗莎白  39.希爾頓    香水調:  40.古龍  41.邂逅  42.英國梨小蒼蘭  43.藍風鈴    留言處留下您喜歡的精油編號數量即可唷      ~快為您所在的環境添加點香薰氛圍吧~    此為20ML精油賣場,如需10ML精油請至賣場裡參觀選購  ~感謝您~','2018-06-07 20:28:07',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (45,1,'精油 香薰精油 買5送1 水溶性精油','SYDNEY法國高級香薰精油 來自植物,花卉或水果,葉,莖,根,萃取植物精華 純靜,溫和,芳香 適用於水氧機,香薰機,加濕器,香薰爐等 賣場中的精油，都經SGS認證 ，請放心使用  SYDNEY品牌香薰精油特惠活動    10ML~單瓶80 買5送1..(香味都可自選喔) 買10送100ML(USB)水氧機一台 或香薰爐(含燭拖和蠟燭一盒)  43種香味可選  花香:10ML        1.薰衣草      2.玫瑰 3.百合 4.茉莉 5.櫻花 6.薑花 7.梔子花 8.橙花 9.夜來香 10.白玉蘭 11.紫羅蘭 12.風信子 13.洋甘菊  草木: 14.茶樹 15.檀香 16.香茅 17.綠茶 18.薄荷 19.尤加利 20.白麝香 21.迷迭香   果香: 22.檸檬 23.青蘋果A 24.水蜜 25.葡萄柚 26.佛手柑 27.熱情果   情境: 28.陽光 29.海洋 30.雨中曲 31.東方風韻 32.繽紛夏日 33.雨後花園  酒店香型: 34.香格里拉 35.長隆酒店 36.四季酒店 37.威尼斯人 38.伊麗莎白 39.希爾頓  香水調: 40.古龍 41.邂逅 42.英國梨小蒼蘭 43.藍風鈴  下單留言您要的香味編號數量即可 感謝您的訂購^-^  此為10ML的精油賣場,如需20ML的請至賣場裡參觀選購','2014-05-22 00:25:22',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (46,1,'日本 Cecile Maia 除毛膏 脫毛膏','【商品♦名稱】名稱:CECILE MAIA溫和除毛膏 規格：200g【使用方法】️需要脫毛的地方洗幹凈之後，塗上該產品，大概1-3mm厚，盡量全部覆蓋毛發。等1-10分鐘（看毛發粗細）。️拿海綿、濕毛巾、濕巾、化妝棉、紙巾都可以，要逆著毛生長的方向擦。再用清水沖洗殘留物，或者直接用水沖洗也行。','2014-02-01 18:17:34',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (47,1,'日本熱銷? Tsubu night pack脂肪粒','?產品名稱: tsubu night pack 去除脂肪粒眼霜品牌: Chez moi品名: 去除脂肪粒眼霜適合膚質: 任何膚質產地: 日本淨含量：30g----------------------------------------潔面後取適量塗抹在脂肪粒或者小肉粒的地方，稍加按摩，10分鐘後會干成眼膜狀，輕輕撕下來，若有殘餘直接用清水洗去即可。建議每週3次，隔天使用，最好夜間使用。建議在皮膚清潔後用，擠壓塗抹於脂肪粒或者小肉粒上，按摩開來就變成透明的了，接下來就是等待的過程。中間切勿用力揉搓，否則會容易搓泥。','2012-05-21 10:35:39',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (48,1,'小米體重計2 原廠公司貨	?台灣賣家｜台灣出貨? ','監視器｜手機週邊配件｜居家商品｜汽車百貨｜藍牙耳機｜喇叭 專賣～ 歡迎關注Woori、不定期上架新鮮貨  ----------------------------------------------------------------- 小米體重計2  新一代智慧體重計，搭配APP幫您貼心紀錄身體變化 ----------------------------Woori-------------------------------  ▲秤人秤物▲ 不管是要量體重，還是秤物都可以，最大可到150公斤 ▲精準測量▲ 採用高精確度感應器，重量的細微變化，細微到50公克 ▲智慧升級▲ 搭配小米運動app，隨時查看紀錄及身體曲線  ▲家庭共享▲ 一台體重計可記錄16位成員獨立資訊  ▲訪客模式▲ 簡單量測，不留痕跡 ▲質感外觀▲ 強化玻璃及隱藏式LED設計，外型簡約時尚  ▲平衡力測試▲ 底座防滑設計，在量測平衡力時不因重心不穩而傾斜滑倒  ＊Woori文字＆圖片非經授權請勿盜用＊ ------------------------------------------------------- 【基本規格】 品牌： 小米 (陸版平行輸入) 產品名稱：小米體重計2 產品尺寸： 280*280*22 (mm) 秤重範圍： 100g-150kg 秤重單位：公斤/斤/磅 最小刻度： 0.1公斤/斤/磅 外殼材料：強化玻璃+工程塑料 工作溫度： 0-40度 裝置要求：Android 4.4/ iOS 9.0及以上系統(iphone5s及以上) 配件：小米體重計2、說明書、4號電池*3  ※商品需5公斤重量方可開機，開機後可使用秤物模式 ※超商取貨因材積限制，最多只能1台，超過請改選宅配   『保固』： ※商品未使用前因新品瑕疵問題7天內可告知更換，經拆封使用後恕不接受退貨申請。  ※非人為因素保固3個月(買家自行負擔來回寄送運費) ※電池配件不在保固範圍 ※因摔傷、自行拆解、誤用電源、受潮等人為操作失當造成商品主體損壞者不在保固範圍之內','2015-08-24 05:05:55',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (49,1,'3D立體矽膠口罩支架口罩內襯墊口罩支撐架','賣場還有其他各款式個性口罩、印花口罩、熱銷口罩、收藏級口罩，歡迎進賣場選購，感恩   進賣場選購鏈接：https://tw.bid.yahoo.com/booth/Y6098093075   名稱：3D立體口罩支架  材質：特級TPE（柔軟）  尺寸：18cm*8.5cm*5cm  功能：口罩立體支撐，不貼臉，口鼻分離，防異味，乾爽透氣！  可高溫消毒（1分鐘）或酒精消毒重覆使用，減少環境負擔  表面光滑處理 無毛邊，可水洗   更多新款樣式口罩請進賣場進行挑選，感恩','2010-09-23 15:44:33',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (50,1,'香氛蠟燭暖燈/融燭燈/香薰燈','很多人都會在家裡點香氛蠟燭 尤其是知名香芬品牌的蠟燭 味道就是超好聞 而且還可以用跟身上香水一樣的味道 但是香氛蠟燭動輒1800-3000 每次點都有燒錢的心痛 後來發現這款韓國的蠟燭暖燈 真的像開發新大陸  蠟燭可以重複使用 直到表面那層的精油揮發 香味慢慢淡掉 這時只要把表面的0.5左右倒掉 又會恢復開始的香味  不用點火.剪燭芯.沒有熄蠟燭時的煙硝味 (真的很討厭這個味道)  美美的蠟燭杯也不會被火燻的黑黑的  燈泡都會另外換成台灣電壓可以直接用的50W燈泡 插頭會更換成台灣直接可用的插頭 另外目前都改成可調光的設計 香味濃淡可調整 再多送一個燈泡 日後不用煩惱燈泡的問題  所以收到直接就可以用了 免變壓器 免另外買燈泡    110V 50W 暖燈本體+燈泡 附贈配件:備用燈泡 瓦楞紙盒包裝  產地:中國(韓國市面上的暖燈品牌都是大陸製造的 如果會介意 請再多考慮喔)','2016-03-17 02:24:13',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (51,1,'MIT 精梳純棉-單人床包枕套兩件組	✦材質：100%純棉','✦產地國別：台灣製造(MIT) ✦內容物：    單人薄床包(105*186cm)x1 /可包覆床墊厚度：約28公分±5%    信封式枕套(45*75cm±5%)x1','2015-05-23 01:41:26',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (52,1,'3D立體雙車邊可水洗羽絲絨枕','【商品規格】 ◇內容：羽絲絨枕(附不織布收納提袋) ◇表布：100%純棉 ◇填充物：100%聚酯纖維(超細纖維科技羽絲絨)  ◇尺寸：43×73cm±5% ◇清潔保養方式：可水洗(攝氏30度以內)/不可乾洗/不可烘乾//不可漂白/不可熨燙及壓燙/懸掛晾乾  ◆退換貨注意事項，如有有下列情況發生，將視損毀程度折扣退款金額： 1.商品附屬配件、贈品損毀╱不齊全。 2.商品屬個人衛生用品，經使用過及清洗後。 3.請將商品妥善包裝完整，並以廠商寄送時所使用紙箱或破壞袋再原封備妥，若原紙箱或破壞袋已遺失，請於商品外再行包裝，勿直接在商品原廠包裝上粘貼宅配單或書寫文字。','2011-09-17 10:38:25',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (53,1,'自動酒精噴霧機 USB充電噴霧機 ','內建電池，USB充電。 可加入75%酒精使用。 可待機10多天 藍色指示燈>>可以調整關閉， 有3段式，短按按鈕做選擇。 開機機>>>長按按鈕做開關。   充電時間：1-1.2小時 電池類型：鋰電池 顏色:白色 產品材質：ABS+PC 接口類型：Micro 電池容量：1200mAh 輸入電壓：DC5V/1.0A 產品功率：1.5W 噴霧量：40-60ML/H 水箱容量：100ML 產品尺寸：78*78*110mm   注意:出貨沒有附贈酒精液體','2015-01-25 06:22:37',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (54,1,'美好家居【100x60鋼架電競桌】現品現貨*電腦桌	','【貼心提醒】  1.賣場都是跟大榮貨運配合的，  運費都是只收配送到一樓的，貨品皆是送至一樓，感謝您！  2.本店所有家具系列為大型物品，不接受整組換貨，配送難免有磕磕碰碰與摩擦  但所有商品若有缺少或是影響組裝的部分，我們都是免費補寄相對應的配件，請於即時通告知  因為配件太多，拆開後是無法再依序排列回去的.....  這樣來回搬運只是將一組好好的桌子搞到整組作廢，  不能接受者請勿下標，非常感謝您的諒解!!!','2011-06-04 04:10:33',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (55,1,'『室內拖鞋』日式條紋亞麻泡沫底情侶鞋家居木地板涼拖鞋	','','2014-01-14 01:17:24',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (56,1,'CPMAX 多層超簡易組合鞋架 鞋櫃','**超商超才，只能運宅配**  顏色:EZ三層粉色,EZ三層黑色,EZ四層粉色,EZ四層黑色,SK-6銀灰色,SK-6粉點點  材質:金屬  規格: 三層(長64 寬20 高45 CM)  四層(長56 寬20 高62 CM)  六層(長58 寬28 高89 CM)  #CPMAX #CPMAX居家生活   下標停看聽 1. 我們是台灣賣家，售前、售後都有100分的保障， 賣場提供非常完善的售後服務，絕對不會找不到人， 收到商品如果有任何問題，可以先聊聊溝通， 不用急著給一星，請讓我們有好好處理、 服務您的機會。  2. 有提供超商取貨付款、 不用付關稅、 不用給身分證等文件、 再次強調是正港台灣賣，合法登記與開發票， 絕對不是退貨找不到人的大陸賣家， 請安心下標  3. 賣場低消99元限制，不含運費超過99元以上 才會出貨。不然商品太小，物流大哥很容易弄不見 就寄丟啦，也浪費了包裝材料。  4.賣場的上班時間是週一~週五，國定假日、見紅休， 有時候忙著出貨，或處理其他事情， 會掛在線上但沒有即時回覆聊聊， 請您一定要耐心等一下，絕對會回覆您， 不是故意不理的喔， 假日雖然休假但也是會抽空回覆的  5. 商品絕對都現貨，下標後2~3工作天會寄出， 偶爾會遇到追加期、斷貨、缺貨， 才需要多幾個工作天才寄出， 所以賣場的天數設比較長，請諒解','2015-05-15 20:42:26',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (57,1,'除臭大師抗菌防護噴霧(抗抑菌檢測+國泰產物險)500ml','購買除臭大師套組可以優惠價加購其他商品，請參考＂賣方的全部商品＂(請買家都要下標再合併結帳)  賣方的全部商品  https://tw.bid.yahoo.com/tw/booth/Y6401678032        寵物香氛 寵物除臭SPA噴霧 寵物香水加價購258元  https://tw.bid.yahoo.com/item/100024830862    除水垢、尿垢的無水檸檬酸450g加價購110元  https://tw.bid.yahoo.com/item/100024830582      除抽油煙機油汙的好幫手的汙必除500ml加價購258元  https://tw.bid.yahoo.com/item/100024829496        消除香港角頭的泡足粉加購多送一包https://tw.bid.yahoo.com/item/100024834311                  本賣場可以使用信用卡付款，請所有買家注意，請遵守奇摩規定務必使用輕鬆付結帳，對買家有保障','2017-08-31 16:38:32',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (58,1,'攜帶式 露營燈 應急照明燈','	','2010-09-23 16:40:51',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (59,1,'Lecoo 感應節水器 感應水龍頭 自動感應節水器	','?台灣賣家  ｜監視器｜手機週邊配件｜居家商品｜藍牙耳機｜喇叭 專賣～  ❤️歡迎關注Woori、不定期上架新鮮貨❤️  【Lecoo 感應節水器】  小更動【大】改造，感應用水新體驗  ● 零接觸設計，揮手感應，防止交叉感染。  ● 智慧省水，杜絕浪費。  ● 防溢保護，自動止水。  ● 簡易安裝好上手，超長續航力。  -----------------Woori圖片＆文案非經授權請勿盜用-----------------  【基本規格】  產品名稱:感應節水器  產品品牌: Lecoo  電池容量: 500mAh  充電接孔: Micro USB  適用水龍頭: M24外牙水龍頭、M22內牙水龍頭  產品尺寸: 7.9*4.1*4.1 cm (手工量測可能存在些許誤差)  額定功率: 120W   ※商品出貨為平行輸入  -----------------------------------------------------------------------------------  『注意事項』：  1. 產品請勿與即熱式設備、太陽能熱水器等搭配使用，以免出現異常!  2. 產品充電時不可使用  3. 水龍頭的水嘴建議與台面距離保留至少25公分  4. 購買前，請檢查你的水龍頭型號是否符合使用規格  『保固』：   7天鑑賞期內（包裝及商品需完整無刮傷、缺件、無使用痕跡），可聯繫客服換新  因摔傷、自行拆解、誤用電源、受潮等人為操作失當造成商品主體損壞者不在保固範圍之內','2019-04-26 12:03:17',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (60,1,'ecofiber 3M防汙抗菌超細纖維浴巾 ','另運動巾/毛巾/包頭巾/浴袍/兒童浴巾	【買浴巾送毛巾+免運】ecofiber 3M防汙抗菌超細纖維浴巾 另運動巾/毛巾/包頭巾/浴袍/兒童浴巾','2012-08-21 17:38:01',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (61,2,'❤現貨❤俏樂斯CHURACOS沖繩美人の All-In-One Gel 幼美肌超導逆時彈力水凝霜30g	','◎容量:30g ◎製造日期:2019年9月 ◎保存期限:未開封3年 ◎有效期限:2022年9月 ◎產地:日本   ◎一個30公克.  ◎皆為現貨,可直接下標.  ◎運費皆可合併,請自行修改金額,謝謝。  　超商取貨付款：不論數量皆只收一次運費； 　郵寄：1個是35元,2個是50元,3個以上是65元。 ','2012-06-03 03:21:26',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (62,2,'巫咪小舖(今日最便宜)雅詩蘭黛特潤超導修護露小棕瓶7m	','※下標前請先看「關於我」!  您好！請買家於下標前在「問與答」預先告知您要購買的「商品和正確數量」 ，好讓巫咪為您快速備貨～謝謝！  □商品品牌：ESTEE LAUDER 雅詩蘭黛  □商品名稱：特潤超導修護露 ( 小棕瓶 )  □容量：7 ml ( 無盒裝 )  □保存期限 :  2022年1月','2012-01-16 17:36:23',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (63,2,'巫咪小舖雅詩蘭黛(今日最便宜)清新淨妍潔顏露30ml特價39元/另售特潤超導修護露特潤超導全方位修護露	','※下標前請先看「關於我」!  您好！請買家於下標前在「問與答」預先告知您要購買的「商品和正確數量」 ，好讓巫咪為您快速備貨～謝謝！  □商品品牌：ESTEE LAUDER 雅詩蘭黛  □商品名稱：清新淨妍潔顏露  □容量：30ml   □有效期限 : 2023年1月','2013-11-13 01:54:41',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (64,2,'克麗緹娜 EPO+潔容霜	克麗緹娜 潔容霜 ','克緹潔容霜epo潔容霜 萃麗 藻護 護理品 經典 光采 防曬商品齊全歡迎詢問  1.保証公司貨，保證正品  2.為保護經銷商隱私，產品都會刮碼，拍下表示接受，謝謝！  3.下標前請先諮詢是否有現貨及數量。  4.宅配到貨時間約1-2天(正常隔天到)，超取約2-3天。  5.收到貨如有不對的地方請第一時間跟我聯繫謝謝！  ','2010-08-06 16:22:50',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (65,2,'特價3瓶700新版法國 Bioderma 貝德瑪	','新版法國 Bioderma 貝德瑪 舒研 高效卸妝潔膚液 卸妝水500ML        最新到貨，保存日期到2023年1月。        國外直購，下標1代表3瓶.','2011-02-25 18:44:03',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (66,2,'NES 水漾雲朵霜 清爽型 35ml	','微乳霜狀質地，與肌膚接觸瞬間吸收、不黏膩，使肌膚形成一層保護膜。富含高濃度西班牙原廠－3D極化水因子，給予肌膚充足水分，緊密鎖水、維持肌膚健康。結合瑞士原廠－極地雪藻萃取，可活化肌膚、延緩肌膚老化，喚醒年輕活力。可使肌膚透亮光澤、自然光采！','2014-06-14 04:57:13',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (67,2,'去黑頭神器 家用臉部去毛孔機 ','粉刺清潔儀器	','2019-07-11 14:55:11',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (68,2,'電動修眉機 修眉神器 自動修眉機','詳細規格 商品名稱電動修眉機 主要材質ABS+電子零件 商品尺寸 商品重量13 x2.1x 1.8cm 25g 顏色選擇白色、金色、玫瑰色 額定電壓5V USB充電 額定功率5W 電池容量500mAh 續航時間0.5hr 充電時間1hr 包裝方式 包裝內容盒裝 本體x1+清潔小刷子x1+充電線x','2011-10-05 22:36:50',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (69,2,'韓國製造 Milky Dress蠶絲精華小白管','內含豐富的蠶絲精華 改善臉上討人厭的痘痘??  ?針對閉鎖性粉刺，膿包性痘痘 ?塗痘痘藥沒見改善的可以推薦這款 ?改善惱人的痘痘疤!!  使用說明：在有痘痘、痘疤的地方輕抹上去 有效日期：2024年2月25日','2013-03-12 13:53:46',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (70,2,'FV富勒烯胎盤素面膜 ','膠原補水保濕提亮膚色控油拉絲面膜5片入	','2018-08-20 04:11:09',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (71,2,'典安大藥局~俏正美BB蜂王飲10入/3盒免運','	','2010-03-22 22:02:03',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (72,2,'一條根精油滾珠5ml 不沾手、攜帶方便、小面積使用	','【十靈本舖】一條根精油滾珠5ml    不沾手、攜帶方便、小面積使用  小巧設計適合隨身攜帶，使用方便 小鋼珠按摩頭，可配合穴位使用 可局部塗抹於小部位等處 30年GMP大廠,品質有保障 ■使用方法：可局部塗抹於耳下、人中、耳際、手腕等處 ■保存方式：請置於陰涼乾燥處，避免強光直射 ■注意事項：二歲以下兒童之使用，須詢問醫師或藥師。蠶豆症患者請勿使用。皮膚敏感 者使用前先做小部份皮膚敏感測試。請勿接觸到雙眼。 ■包裝規格：5ml/盒','2013-01-03 00:08:04',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (73,2,'三階20CM韻律踏板有氧階梯踏板瑜	','￡圖片色彩因個人螢幕和拍攝燈光會略有不同，請以實際商品顏色為準。 ￡部份商品因運送保護，需請自行組裝，如有問題歡迎向本店詢問協助。 ※ 尺 寸 規 格  規格：長80.5x寬30.5x高10/15/20 cm 重量：3.5 kg 主要材質：PP','2012-10-17 21:31:54',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (74,2,'最大秤重180KG 體重秤精准玻璃電子人體秤夜視健康體重稱	','夜視屏的是上2節7號電池，可顯示室溫，公斤市斤可轉化  產品參數： 秤重：最大180KG 分度值：100G 配有高精度傳感器 高強度鋼化玻璃承載面 超大顯示屏30MM ','2018-05-07 20:47:35',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (75,2,'康富 康體素乳膏 女用 ','容量： 2oz./瓶。  成份： 純水、鱷梨油、野山芋萃取物、蘆薈油、火山膏泥(Bentonite)、迷迭香萃取物、紅蘿蔔油、檸檬草油。  使用方法： 塗於身體較細嫩的皮膚處，臉、頸、胸部、手臂內側、大腿內側任一部位肌膚皆可，部位輪流使用，按摩至吸收。 每日1-2次，每次約2.5～5公分（2.5公分約為小指一半的長度），輕輕按摩至皮膚吸收即可。','2014-01-21 20:42:00',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (76,2,'森女服飾 香妮美人計后脫塑身衣正品產后收腹提臀連體瘦內衣無痕燃脂美體衣','歡迎光臨，賣場大多數商品需要跟廠家拿貨，需要時間一般6到9天（總共包含寄貨時間）為您送達。急用請勿下標，避免影響使用。有時比較忙沒來得及回覆，還請諒解。收到商品有任何問題，請聯絡我們，只要是我們的問題出錯了，我們都會立即解決。如果未及時回覆，必然是因為忙不過來或有其他事情，請不要誤解為我們不處理售後問題，還請諒解。另外週日休假時間，其他時間9:00-18:00正常上班，謝謝。','2019-09-30 02:30:09',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (77,2,'信東Q彈膠原蛋白粉(30包/盒) ','全新未拆，只有一盒隨便賣~','2012-05-13 20:34:21',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (78,2,'買三送一天山雪蓮 奇蹟素 葡萄籽精華 熟齡保養 (60顆/瓶) 免運	','','2014-06-05 12:54:23',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (79,2,'BIONEO百妮 - 粉嫩霜 20ml','【產品成份】 Sodium Acrylates Copolymer(and)Lecithin、Glycerine、Retinol、Phenoxethol、De-ionized Water、Triglyceride、Sweet Almond Oil、Ethyl Ascorbic Acid、Niacinamide、Panthenol、Orange Flower Water, Arbutin、Glycolic Acid、Ceramides/Bisabolol/Phytosterol、Chlorphenesin 【商品規格】      20ml 【保存方式】 保存期限：3 年(係指未開封下且正常條件下之保存天數)。 保存方法：如未開封狀態下，請放置於乾燥涼爽處，避免將產品置放於陽光直射處。 【產 地】  德   國 【注意事項】 1.使用後，如有不適，請立即停用並諮詢專業醫師。 2.過敏性肌膚，使用前請先測試是否刺激過敏。 3.若不慎碰觸眼睛時，請以大量清水沖洗。 4.網頁產品因拍攝或螢幕設定不同,可能與實品略有差異，請以實際商品為準。 5.此為個人消耗性用品，為顧及衛生及安全，一經拆封將影響您的退換權益。','2013-01-05 01:17:33',NULL,1);
INSERT INTO `SHOP`.`prod` (`prod_id`,`prod_type_no`,`prod_name`,`prod_text`,`prod_on_time`,`prod_off_time`,`prod_status`) VALUES (80,2,'典安大藥局~明治系列明倍適營養補充食品125mL','明倍適2箱免運','2018-02-12 10:33:14',NULL,1);

INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (1,123,1,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (2,64,2,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (3,1,2,1);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (4,97,2,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (5,98,2,3);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (6,66,2,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (7,132,2,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (8,75,2,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (9,11,2,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (10,45,2,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (11,111,2,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (12,16,2,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (13,113,2,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (14,114,2,3);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (15,85,2,3);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (16,57,2,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (17,25,2,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (18,28,2,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (19,125,2,1);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (20,30,2,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (21,80,4,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (22,113,4,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (23,83,4,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (24,19,4,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (25,37,4,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (26,7,4,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (27,24,4,1);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (28,9,4,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (29,57,4,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (30,126,4,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (31,111,4,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (32,101,5,3);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (33,120,5,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (34,129,6,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (35,4,6,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (36,72,6,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (37,57,6,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (38,11,6,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (39,52,7,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (40,24,7,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (41,72,7,1);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (42,41,7,1);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (43,93,7,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (44,127,7,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (45,1,8,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (46,70,8,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (47,40,8,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (48,10,8,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (49,58,8,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (50,123,8,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (51,92,8,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (52,1,9,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (53,81,9,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (54,66,9,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (55,2,9,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (56,53,9,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (57,104,9,3);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (58,43,9,1);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (59,28,9,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (60,60,9,1);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (61,12,9,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (62,126,9,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (63,110,9,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (64,116,10,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (65,105,10,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (66,90,10,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (67,44,10,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (68,93,10,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (69,128,11,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (70,34,11,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (71,35,11,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (72,5,11,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (73,69,11,1);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (74,38,11,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (75,44,11,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (76,77,11,3);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (77,17,11,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (78,114,11,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (79,85,11,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (80,53,11,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (81,55,11,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (82,27,11,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (83,30,11,1);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (84,116,13,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (85,85,13,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (86,92,13,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (87,31,13,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (88,128,14,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (89,32,14,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (90,97,14,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (91,2,14,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (92,37,14,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (93,101,14,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (94,39,14,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (95,72,14,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (96,43,14,1);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (97,11,14,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (98,81,14,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (99,18,14,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (100,116,14,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (101,85,14,3);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (102,91,14,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (103,92,14,3);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (104,99,15,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (105,68,15,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (106,4,15,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (107,132,15,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (108,69,15,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (109,40,15,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (110,106,15,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (111,108,15,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (112,44,15,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (113,77,15,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (114,115,15,1);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (115,83,15,1);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (116,52,15,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (117,117,15,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (118,55,15,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (119,87,15,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (120,62,15,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (121,64,16,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (122,34,16,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (123,38,16,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (124,6,16,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (125,124,16,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (126,76,16,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (127,125,16,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (128,96,17,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (129,113,17,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (130,66,17,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (131,51,17,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (132,37,17,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (133,56,17,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (134,106,17,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (135,43,17,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (136,11,17,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (137,27,17,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (138,13,17,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (139,31,17,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (140,40,18,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (141,41,18,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (142,74,18,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (143,107,18,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (144,109,18,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (145,14,18,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (146,81,18,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (147,22,18,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (148,58,18,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (149,122,18,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (150,123,18,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (151,59,18,3);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (152,30,18,3);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (153,63,18,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (154,1,19,3);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (155,97,19,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (156,98,19,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (157,131,19,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (158,37,19,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (159,13,19,1);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (160,78,19,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (161,110,19,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (162,50,19,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (163,83,19,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (164,84,19,7);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (165,23,19,4);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (166,121,19,5);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (167,57,19,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (168,21,20,6);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (169,6,20,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (170,22,20,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (171,121,20,2);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (172,122,20,9);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (173,10,20,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (174,108,20,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (175,77,20,8);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (176,30,20,10);
INSERT INTO `SHOP`.`shop_cart` (`cart_id`,`prod_spec_id`,`user_id`,`prod_num`) VALUES (177,127,20,10);
SET foreign_key_checks = 1;