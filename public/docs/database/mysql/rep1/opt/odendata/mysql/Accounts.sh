

echo sql=" CREATE USER 'rep'@'127.0.0.1' IDENTIFIED WITH mysql_native_password BY 'rep';  FLUSH PRIVILEGES;"


# We assume root's password is set in ~/.mysql.my.cnf or its blank.
# If not do it.

for i in 1 2 3 4 5 6; do
    echo "Setting up rep in mysql $i" 
    mysql -v -u root -e "$sql" -S /tmp/mysql$i.sock
done
