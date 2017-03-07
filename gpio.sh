#!/bin/bash
while true;
do 
	if [raspi-gpio get 4 | awk '{print $3}' | cut -d "=" -f 2 >0]; then 
		echo "ok"; 
	fi
	sleep 1; 
done
