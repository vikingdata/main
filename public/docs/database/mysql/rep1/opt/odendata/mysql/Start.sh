
# For this version of MariaDB, you must remove aria_control default file.
# It will atempt to use that, but if it is not there, it will use the one
# defined in my.cnf.
# When I look at the buglist, it might have already been addressed.

# Theser are the files appearing in /var/lib/mysql when they shouldn't be. 
#ib_buffer_pool  ibdata1
#aria_log.00000001   ib_logfile0     multi-master.info  tc.log
#aria_log_control    ib_logfile1     

rm -f /var/lib/mysql/*

# If this doesn't start, you may have to restart the host.
# In windoze, I ran it under Docker, and could only
# get it to work after a restart probably because I used up to
# much memory doing other stuff and I think the Docker service needed
# an upgrade --- I had to manually start the service. 

for i in 1 2 3 4 5 6; do
    echo "starting mysql $i"   
    mysqld --defaults-file=/data/mysql/mysql$i/my.cnf &
    sleep 5
done    

ps auxww | grep mysqld
