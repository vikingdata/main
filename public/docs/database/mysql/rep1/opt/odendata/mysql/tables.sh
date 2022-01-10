

sql="create database if not exists test_od;"

sql2="
use test_od;
drop table if exists hosts;
 create table if not exists hosts (
host varchar(64),
date_insert timestamp,
index ( host, date_insert )
);
"

for i in 1 2 3 4 5 6; do
    echo "setup schema in mysql $i"
    mysql -v -u root -e "$sql" -S /tmp/mysql$i.sock
    mysql -vv -u root -e "$sql2" -S /tmp/mysql$i.sock
done


