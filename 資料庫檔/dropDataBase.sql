-- alter table `group` drop constraint FK_user_id
-- ALTER TABLE group RENAME TO new_table_name;

SET foreign_key_checks = 0;

drop schema center;
drop schema back;
drop schema shop;
drop schema forum;
drop schema chat;
drop schema group1;

SET foreign_key_checks = 1;

-- 刪除所有資料並並重置AI
delete from tablename;
alter table tablename AUTO_INCREMENT=0; 