
#rm -f /var/log/mysql/mysql*/*.log

#export web=http://odendata.com/docs/database/mysql/rep1/data/mysql

#for i in 1 2 3 4 5 6; do
# dest=/data/mysql/mysql$i/my.cnf
# webcnf=$web/mysql$i/my.cnf
# echo " wget -vo $dest $webcnf"
# wget -O $dest $webcnf
#done

for i in 1 2 3 4 5 6; do
  echo "starting mysql $i"
  echo "mysqld --defaults-file=/data/mysql/mysql$i/my.cnf &"
  mysqld --defaults-file=/data/mysql/mysql$i/my.cnf &
  sleep 5
done

#cat /var/log/mysql/mysql1/error.log

ps auxww | grep mysqld
#ls -al /var/lib/mysql/


