SET foreign_key_checks = 0;

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