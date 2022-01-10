

sql=" CREATE USER 'rep'@'localhost' IDENTIFIED BY 'rep'; FLUSH PRIVILEGES;"

sql2="GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.*
TO 'rep'@'localhost'"

# We assume root's password is set in ~/.mysql.my.cnf or its blank.
# If not do it.

for i in 1 2 3 4 5 6; do

    echo "Setting up rep in mysql $i"
    mysql -v -u root -e "$sql" -S /tmp/mysql$i.sock
    mysql -vv -u root -e "$sql2" -S /tmp/mysql$i.sock
    mysql -v -u root -e "show grants for rep@localhost" -S /tmp/mysql$i.sock
done


