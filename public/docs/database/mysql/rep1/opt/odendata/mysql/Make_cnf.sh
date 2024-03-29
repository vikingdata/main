#!/bin/bash


for i in 1 2 3 4 5 6; do

    mkdir -p ../../../data/mysql/mysql$i/binlogs  
    echo $f  
    f=../../../data/mysql/mysql$i/my.cnf
    cp -f my_template.cnf $f  
    sed -i "s/__NO__/$i/g" $f
    
    
    if [[  $i = 1 || $i = 2 ]] ; then
       sed -i "s/# rpl_semi_sync_master_enabled=ON/ rpl_semi_sync_master_enabled=ON/g" $f
       echo "master semi $i"]
    elif  [[  $i = 3 || $i = 4  ]] ; then
	sed -i "s/# rpl_semi_sync_slave_enabled=ON/ rpl_semi_sync_slave_enabled=ON/g" $f
	echo "slave semi $i "
    fi

done
