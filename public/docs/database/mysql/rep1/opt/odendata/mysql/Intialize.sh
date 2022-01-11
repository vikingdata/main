
chown -R mysql.mysql /var/log/mysql
chown -R mysql.mysql /data/mysql

mysql_install_db --user=mysql --datadir=/data/mysql/mysql1/data \
 --defaults-file=/data/mysql/mysql1/my.cnf


mysql_install_db --user=mysql --datadir=/data/mysql/mysql2/data \
		 --defaults-file=/data/mysql/mysql2/my.cnf

mysql_install_db --user=mysql --datadir=/data/mysql/mysql3/data \
		 --defaults-file=/data/mysql/mysql3/my.cnf

mysql_install_db --user=mysql --datadir=/data/mysql/mysql4/data \
		 --defaults-file=/data/mysql/mysql4/my.cnf

mysql_install_db --user=mysql --datadir=/data/mysql/mysql5/data \
		 --defaults-file=/data/mysql/mysql5/my.cnf

mysql_install_db --user=mysql --datadir=/data/mysql/mysql6/data \
		 --defaults-file=/data/mysql/mysql6/my.cnf


