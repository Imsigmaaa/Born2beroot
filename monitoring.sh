
#!/bin/bash

#arch
arch=$(uname -a)
#cpu physical
cpu_physical=$(grep "physical id" /proc/cpuinfo | wc -l)
#cpu virtual	
vcpu=$(grep "^processor" /proc/cpuinfo |wc -l)
#memory usage
mem=$(free -m | awk '/Mem:/ {printf "%d/%dMB (%.2f%%)\n", $3, $2, $3*100/$2}')
#disk usage
disk=$(df -BG --total | awk '/total/ {printf "%d/%dGB (%d%%)", $3, $2, $5}')
#cpu load
cpu_load=$(vmstat 1 2 | tail -1 | awk '{printf "%.2f%%", 100 - $15}')
#last boot
last_boot=$(who -b | awk '{print $3 " " $4}')
#lvm used
lvm=$(lsblk | grep -q "lvm" && echo yes || echo no)
#tcp connections
tcp=$(ss -ta | grep ESTAB | wc -l)
#logged in users		
log=$(who | wc -l)
#network ip
ip=$(hostname -I | awk '{print $1}')
#network mac
mac=$(ip link show | awk '/ether/ {print $2}')
#sudo 
sudo_cmnd=$(journalctl _COMM=sudo | grep "COMMAND" | wc -l)			
wall "	#Architecture: $arch
	#CPU physical: $cpu_physical
	#vCPU: $vcpu
	#Memory Usage: $mem
	#Disk Usage: $disk
	#CPU Load: $cpu_load
	#Last boot: $last_boot
	#LVM use: $lvm
	#Connections TCP: $tcp ESTABLISHED
	#Users LOG: $log
	#Network: IP $ip ($mac)
	#Sudo commands: $sudo_cmad cmd"