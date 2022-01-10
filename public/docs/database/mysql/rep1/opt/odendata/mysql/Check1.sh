
sql="insert into test_od.hosts values ('1',now())"
mysql -v -u root -e "$sql" -S /tmp/mysql1.sock

sql="select @@server_id, host, date_insert from test_od.hosts where host = '1'             
       order by date_insert desc limit 1"

for i in 1 2 3 5; do
     echo "server $j", `mysql -u root -e "$sql" -S /tmp/mysql$1.sock`
done
echo "The above lines should all be the same."
echo ""

for i in 1 2 3 4 5 6 7 8 9 10 11 12; do

  sleep 1
  for j in 1 5 6; do
      echo "second $i, server $j'", `mysql -u root -e "$sql" -S /tmp/mysql$j.sock`
  done
done
echo "You should have seen a time change after 10 seconds on server 5 and 6."
	 
