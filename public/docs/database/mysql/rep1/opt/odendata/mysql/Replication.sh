killall mysqld
sleep 5

echo "removing binlogs"
rm -vf /var/log/mysql/mysql*/binlogs/*
rm -vf /var/log/mysql/mysql*/relay/*

rm -vf /data/mysql/mysql*/data/mysql-bin*
rm -vf /data/mysql/mysql*/data/*relay*

for i in 1 2 3 4 5 6; do
  echo "starting mysql $i"
  echo "mysqld --defaults-file=/data/mysql/mysql$i/my.cnf &"
  mysqld --defaults-file=/data/mysql/mysql$i/my.cnf &
  sleep 5
done

for i in 1 2 3 4 5 6; do
  echo "flushing logs mysql $i"
  mysql -v -u root -e "flush logs" -S /tmp/mysql$i.sock
  mysql -v -u root -e "show master logs" -S /tmp/mysql$i.sock
done

for i in 1 2 3 4 5 6; do
  echo "start slave mysql $i"
  mysql -v -u root -e "stop slave\G" -S /tmp/mysql$i.sock
done

sql_slave1="
change master to MASTER_HOST='127.0.0.1',
  MASTER_USER='rep',
  MASTER_PASSWORD='rep',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=375,
  master_port=3301;
"

sql_slave2="
change master to MASTER_HOST='127.0.0.1',
  MASTER_USER='rep',
  MASTER_PASSWORD='rep',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=375,
  master_port=3302;
"

sql_delay="CHANGE MASTER TO MASTER_DELAY = 10;"
#SHOW VARIABLES LIKE 'rpl_semi_sync%';

# m-m
mysql -v -u root -e "$sql_slave2" -S /tmp/mysql1.sock
mysql -v -u root -e "$sql_slave1" -S /tmp/mysql2.sock

# slaves off first master
mysql -v -u root -e "$sql_slave1" -S /tmp/mysql3.sock
mysql -v -u root -e "$sql_slave1" -S /tmp/mysql5.sock
# slave off 2nd master

mysql -v -u root -e "$sql_slave2" -S /tmp/mysql4.sock
mysql -v -u root -e "$sql_slave2" -S /tmp/mysql6.sock

# 10 second dlay slaves
mysql -v -u root -e "$sql_delay" -S /tmp/mysql5.sock
mysql -v -u root -e "$sql_delay" -S /tmp/mysql6.sock

for i in 1 2 3 4 5 6; do
  echo "show slave mysql $i"
  mysql -v -u root -e "show slave status\G" -S /tmp/mysql$i.sock \
  | egrep -i 'running|master_host|master_port';
done


for i in 1 2 3 4 5 6; do
  echo "start slave mysql $i"
  mysql -v -u root -e "start slave\G" -S /tmp/mysql$i.sock
  sleep 1
done

sleep 10

for i in 1 2 3 4 5 6; do
  echo "show slave mysql $i"
  mysql -v -u root -e "show slave status\G" -S /tmp/mysql$i.sock \
	| egrep -i 'running|master_host|master_port';
done


# mysql -v -u root -e "show slave status\G" -S /tmp/mysql1.sock



