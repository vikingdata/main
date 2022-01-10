
sql="insert into test_od.hosts values ('1',now())"
mysql -v -u root -e "$sql" -S /tmp/mysql1.sock

sql="select @@server_id, host, date_insert from test_od.hosts where host = '1'             
       order by date_insert desc limit 1"
  
for i in 1 2 3 4 5 6 7 8 9 10 11; do

  sleep 2  
  for j in 1 2 3 4 5 6; do
    echo "try $i, server $j'", `mysql -v -u root -e "$sql" -S /tmp/mysql$j.sock`
  done
done
	 
