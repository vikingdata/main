
# If we need to install percona
#wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
#dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb
#percona-release enable-only tools release
#apt-get update
#apt-get -y install percona-xtrabackup-24
#apt-get -y install percona-xtrabackup-80
#apt-get -y install qpress


# This is mariabdb, so we have to use mariadb-backup

apt-get install mariadb-backup

# We can use xtrrabackup or innobackupex
# If xtrabackup, you should also backup the mysql database.

mkdir -p /backups/mysql/mysql1

d=`date +%y%m%d_%H%M%S`

mariabackup --defaults-file=/data/mysql/mysql1/my.cnf \
           --datadir=/data/mysql/mysql1/data \
	   --user=root --compress --backup \
	   --slave-info \
	   --target-dir=/backups/mysql/mysql1/mysql1_$d \
	   --socket=/tmp/mysql1.sock

exclude="--exclude=gtid*,innodb*,transaction*"
S=/data/mysql/mysql1/data/mysql
D=/backups/mysql/mysql1/mysql1_$d/MYSQL_copy

mkdir -p /backups/mysql/mysql1/mysql1_$d/MYSQL_copy
rsync -av $exlude $S $D

