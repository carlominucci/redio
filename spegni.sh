#!/bin/bash
raspi-gpio set 18 op; 
while true; 
	do 
		if [[ $(raspi-gpio get 4 | awk '{print $3}' | cut -d "=" -f 2) == "0" ]]; then 
				wall "shutdown...";
				raspi-gpio set 11 dh;
				/home/pi/lcd.py "spegnimento in" "corso..."
			sudo poweroff; 
		fi; 
	sleep 1; 
done 

