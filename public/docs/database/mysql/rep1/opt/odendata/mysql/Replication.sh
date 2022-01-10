

sql_slave1="
change master to MASTER_HOST='127.0.0.1',
  MASTER_USER='rep',
  MASTER_PASSWORD='rep',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=365,
  master_port=3301;
"

sql_slave2="
change master to MASTER_HOST='127.0.0.1',
  MASTER_USER='rep',
  MASTER_PASSWORD='rep',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=365,
  master_port=3302;
"

sql_delay="CHANGE MASTER TO MASTER_DELAY = 10;"

#SHOW VARIABLES LIKE 'rpl_semi_sync%';

mysql -v -u root -e "$sql_slave2" -S /tmp/mysql1.sock
mysql -v -u root -e "$sql_slave2" -S /tmp/mysql4.sock
mysql -v -u root -e "$sql_slave2" -S /tmp/mysql6.sock

mysql -v -u root -e "$sql_slave1" -S /tmp/mysql2.sock
mysql -v -u root -e "$sql_slave1" -S /tmp/mysql3.sock
mysql -v -u root -e "$sql_slave1" -S /tmp/mysql5.sock
