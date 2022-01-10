

mkdir -p /backups/mysql/mysql1

d=`date +%y%m%d_%H%M%S`
f=/backups/mysql/mysql1/mysql1_$d

mysqldump -u root --all-databases -S /tmp/mysql1.sock | gzip  > $f.gz

