

for i in 1 2 3 4 5 6; do
    echo "starting mysql $i"   
    mysqld --defaults-file=/data/mysql/mysql$i/my.cnf &
    sleep 5
done    

ps auxww | grep mysqld
