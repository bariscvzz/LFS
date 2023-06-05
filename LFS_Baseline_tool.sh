#!/bin/bash
server_name=$(hostname)

#Print start message to screen and log file.
echo "
 ▄█          ▄████████    ▄████████ 
███         ███    ███   ███    ███ 
███         ███    █▀    ███    █▀  
███        ▄███▄▄▄       ███        
███       ▀▀███▀▀▀     ▀███████████ 
███         ███                 ███ 
███▌    ▄   ███           ▄█    ███ 
█████▄▄██   ███         ▄████████▀  
▀                                              
            Baseline Forensic Tool" | tee -a $DEST/$baseline_collection_log
function check_root() {
    echo ""
        echo "Checking for root/sudo priviliges: "
        echo ""
if whoami | grep "root"; then
     echo " "
     echo " "
     echo "Congratulations! You have root/sudo privileges..." 
else
     echo "!!! YOU ARE NOT ROOT !!!  PLEASE RE-RUN THIS SCRIPT WITH ROOT PRIVILIGES!" && exit
fi
    echo ""
}

function server_baseline_collection_tool() {
    echo ""
        echo "Create Baseline Information for ${server_name}: "
        echo ""
mkdir -p "$(pwd)/LFS_Baseline_Tool"
DEST="$(pwd)/LFS_Baseline_Tool"

#Create the file name of collection file(s).

day=$(date +"%m-%d-%Y")
hostname=$(hostname -s)
collection="$hostname.$day"

#Create a log file of the collection process.

echo "Creating Log File..."
baseline_collection_log="$collection.baseline_collection.log"
touch $DEST/$baseline_collection_log

#Create the file name of MD5
md5_collection_log="$collection.md5_collection.log"
touch $DEST/$md5_collection_log

#Collection Linux System Infermation
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "STARTING COLLECTION LINUX SYSTEM INFORMATIN..." | tee -a $DEST/$baseline_collection_log
echo "**************************************************************************************" >> $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
echo "COLLECTION SYSTEM INFORMATION..." | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List the host name of machine" >> $DEST/$baseline_collection_log
echo "1- hostnamectl" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
hostnamectl > "$DEST/1-hostnamectl.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "Linux version and kernel information" >> $DEST/$baseline_collection_log
echo "2- uname -a" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
uname -a > "$DEST/2-uname.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List of data/time/timezone" >> $DEST/$baseline_collection_log
echo "3- timedatectl" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
timedatectl > "$DEST/3-timedatectl.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List uptime of machine" >> $DEST/$baseline_collection_log
echo "4- uptime" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
uptime > "$DEST/4-uptime.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List of system memory information" >> $DEST/$baseline_collection_log
echo "5- free" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
free > "$DEST/5-free.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List of system memory information" >> $DEST/$baseline_collection_log
echo "6- cat /proc/meminfo:" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
cat /proc/meminfo > "$DEST/6-cat_proc_meminfo.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List last reboot time of machine" >> $DEST/$baseline_collection_log
echo "7- last reboot:" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
last reboot > "$DEST/7-reboot.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List of users currently logged on" >> $DEST/$baseline_collection_log
echo "8- who -H:" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
who -H > "$DEST/8-who-H.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List last system boot time" >> $DEST/$baseline_collection_log
echo "9- who -b:" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
who -b  > "$DEST/9-who-b.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List of ALL accounts on the machine:" >> $DEST/$baseline_collection_log
echo "10- cat /etc/passwd" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
cat /etc/passwd > "$DEST/10-cat_etc_passwd.log"
md5sum "$DEST/10-cat_etc_passwd.log "| tee -a $DEST/$md5_collection_log
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List of ALL groups used by the user:" >> $DEST/$baseline_collection_log
echo "11- cat /etc/group" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
cat /etc/group > "$DEST/11-cat_etc_group.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "Sudoers config file and a list of users with sude access:" >> $DEST/$baseline_collection_log
echo "12- cat /etc/sudoers" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
cat /etc/sudoers > "$DEST/12-cat_etc_sudoers.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List of ALL scheduled jobs:" >> $DEST/$baseline_collection_log
echo "13- cat /etc/crontab" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
cat /etc/crontab > "$DEST/13-cat_etc_crontab.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List of ALL systemd timers:" >> $DEST/$baseline_collection_log
echo "14- systemctl status *timer" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
systemctl status *timer > "$DEST/14-systemctl_status_timer.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List of ALL scheduled jobs:" >> $DEST/$baseline_collection_log
echo "15- cat /etc/*.d" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
cat /etc/*.d 2>/dev/null > "$DEST/15-cat_etc_d.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List of CPU's properties and arcgitecture as reported by OS:" >> $DEST/$baseline_collection_log
echo "16- lscpu" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
lscpu > "$DEST/16-lscpu.log"
echo " " >> $DEST/$baseline_collection_log
echo "================================================================================" >> $DEST/$baseline_collection_log
echo "List of hard drives and properties:" >> $DEST/$baseline_collection_log
echo "17- fdisk -l" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
fdisk -l > "$DEST/17-fdisk-l_.log"
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "COLLECTING SYSTEM INFORMATION... DONE!" | tee -a $DEST/$baseline_collection_log
echo "**************************************************************************************" >> $DEST/$baseline_collection_log

#Collect MySQL Information

echo " " >> $DEST/$baseline_collection_log
echo "**************************************************************************************" >> $DEST/$baseline_collection_log
echo "COLLECTING MYSQL INFORMATION..." | tee -a $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "Copy mysql.confd" >> $DEST/$baseline_collection_log
echo "18- cp -r /etc/mysql/mysql.confd $DEST/" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
cp -r /etc/mysql/mysql.confd "$(pwd)"/LFS_Baseline_Tool/
echo " " >> $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "COLLECTING MYSQL INFORMATION... DONE!" | tee -a $DEST/$baseline_collection_log
echo "**************************************************************************************" >> $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List of startup services at boot:"
echo "19- systemctl list-unit-files --type=service" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
systemctl list-unit-files --type=service > "$(pwd)"/LFS_Baseline_Tool/19_systemctl_list_unit_files.log
python3 convert_to_html.py "$(pwd)"/LFS_Baseline_Tool/19_systemctl_list_unit_files.log 19_systemctl_list_unit_files.html $DEST/$baseline_collection_log
rm "$(pwd)"/LFS_Baseline_Tool/19_systemctl_list_unit_files.log
mv 19_systemctl_list_unit_files.html "$(pwd)"/LFS_Baseline_Tool/
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List of services and their status:" >> $DEST/$baseline_collection_log
echo "20- service --status-all:" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
service --status-all > "$DEST/20-service_status_all.log"
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log

#Collect Network Information

echo " " >> $DEST/$baseline_collection_log
echo "**************************************************************************************" >> $DEST/$baseline_collection_log
echo "COLLECTING NETWORK INFORMATION..." | tee -a $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List of network devices:" >> $DEST/$baseline_collection_log
echo "21- ifconfig -a " | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
ifconfig -a > "$DEST/21-ifconfig-a.log"
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List of iptables :" >> $DEST/$baseline_collection_log
echo "22- iptables -L " | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
iptables -L > "$DEST/22-iptables.log"
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List of open files on the system and the process ID that opened them:" >> $DEST/$baseline_collection_log
echo "23- lsof " | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
lsof 2>/dev/null > "$(pwd)"/LFS_Baseline_Tool/23_lsof.log
python3 convert_to_html.py "$(pwd)"/LFS_Baseline_Tool/23_lsof.log 23_lsof.html >> $DEST/$baseline_collection_log
rm "$(pwd)"/LFS_Baseline_Tool/23_lsof.log
mv 23_lsof.html "$(pwd)"/LFS_Baseline_Tool/
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List of network connections:" >> $DEST/$baseline_collection_log
echo "24- netstat -a " | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
netstat -a > "$(pwd)"/LFS_Baseline_Tool/24_netstat_a.log
python3 convert_to_html.py "$(pwd)"/LFS_Baseline_Tool/24_netstat_a.log 24_netstat_a.html >> $DEST/$baseline_collection_log
rm "$(pwd)"/LFS_Baseline_Tool/24_netstat_a.log
mv 24_netstat_a.html "$(pwd)"/LFS_Baseline_Tool/
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List of network interfaces:" >> $DEST/$baseline_collection_log
echo "25- netstat -i " | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
netstat -i > "$(pwd)"/LFS_Baseline_Tool/25_netstat_i.log
python3 convert_to_html.py "$(pwd)"/LFS_Baseline_Tool/25_netstat_i.log 25_netstat_i.html >> $DEST/$baseline_collection_log
rm "$(pwd)"/LFS_Baseline_Tool/25_netstat_i.log
mv 25_netstat_i.html "$(pwd)"/LFS_Baseline_Tool/
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List of kernel network routing table:" >> $DEST/$baseline_collection_log
echo "26- netstat -r " | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
netstat -r > "$(pwd)"/LFS_Baseline_Tool/26_netstat_r.log
python3 convert_to_html.py "$(pwd)"/LFS_Baseline_Tool/26_netstat_r.log 26_netstat_r.html >> $DEST/$baseline_collection_log
rm "$(pwd)"/LFS_Baseline_Tool/26_netstat_r.log
mv 26_netstat_r.html "$(pwd)"/LFS_Baseline_Tool/
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List of network connections:" >> $DEST/$baseline_collection_log
echo "27- netstat -nalp " | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
netstat -nalp > "$(pwd)"/LFS_Baseline_Tool/27_netstat_nalp.log
python3 convert_to_html.py "$(pwd)"/LFS_Baseline_Tool/27_netstat_nalp.log 27_netstat_nalp.html >> $DEST/$baseline_collection_log
rm "$(pwd)"/LFS_Baseline_Tool/27_netstat_nalp.log
mv 27_netstat_nalp.html "$(pwd)"/LFS_Baseline_Tool/
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List of Network Connections:" >> $DEST/$baseline_collection_log
echo "28- netstat -plant " | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
netstat -plant > "$(pwd)"/LFS_Baseline_Tool/28_netstat_plant.log
python3 convert_to_html.py "$(pwd)"/LFS_Baseline_Tool/28_netstat_plant.log 28_netstat_plant.html >> $DEST/$baseline_collection_log
rm "$(pwd)"/LFS_Baseline_Tool/28_netstat_plant.log
mv 28_netstat_plant.html "$(pwd)"/LFS_Baseline_Tool/
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List of the ARP table cache (Address Resolution Protocol):" >> $DEST/$baseline_collection_log
echo "29- arp -a " | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
arp -a > "$DEST/29-arp-a.log"
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List of all connection and interface:" >> $DEST/$baseline_collection_log
echo "30- ss -a -e -i " | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
ss -a -e -i > "$DEST/30-ss-a-e-i.log"
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "COLLECTING NETWORK INFORMATION DONE..." | tee -a $DEST/$baseline_collection_log
echo "**************************************************************************************" >> $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log

#Create a directory listing of ALL files:

echo " " >> $DEST/$baseline_collection_log
echo "**************************************************************************************" >> $DEST/$baseline_collection_log
echo "CREATING DIRECTORY LISTING OF FILES..." | tee -a $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List ALL hidden directories:" >> $DEST/$baseline_collection_log
echo "31- find / -type d -name '\.*'" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
find / -type d -name "\.*" 2>/dev/null > "$DEST/31-find_hidden_directories"
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List of files/directories with no user/group name:" >> $DEST/$baseline_collection_log
echo "32- find / \( -nouser -o -nogroup \) -exec ls -l {} \; 2>/dev/null" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
find / \( -nouser -o -nogroup \) -exec ls -l {} \; 2>/dev/null > "$DEST/32-find_no_user_name.log"
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List of MD5 hash for all executable files:" >> $DEST/$baseline_collection_log
echo "33- find /usr/bin -type f -exec file "{}" \; | grep -i "elf" | cut -f1 -d: | xargs -I "{}" -n 1 md5sum {} " | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
find /usr/bin -type f -exec file "{}" \; | grep -i "elf" | cut -f1 -d: | xargs -I "{}" -n 1 md5sum {} > "$DEST/33-find_executable_file.log"
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "List ALL log files that contain binary code inside:" >> $DEST/$baseline_collection_log
echo "34- grep [[:cntrl:]] /var/log/*.log" | tee -a $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
grep [[:cntrl:]] /var/log/*.log > "$DEST/34-grep_contain_binary_code.log"
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "CREATING DIRECTORY LISTING OF FILES... DONE!" | tee -a $DEST/$baseline_collection_log
echo "**************************************************************************************" >> $DEST/$baseline_collection_log
echo " " >> $DEST/$baseline_collection_log
echo "======================================================================================" >> $DEST/$baseline_collection_log
echo "Adding to Zip File" | tee -a $DEST/$baseline_collection_log
cd "$DEST" && cd .. && zip -r LFS_Baseline_Tool.zip ./LFS_Baseline_Tool -i "*"
echo "======================================================================================" | tee -a $DEST/$baseline_collection_log
echo "Baseline Tool COMPLETED Forensic and DELETE forensic files" | tee -a $DEST/$baseline_collection_log
echo "**************************************************************************************" | tee -a $DEST/$baseline_collection_log
rm -rf "$(pwd)"/LFS_Baseline_Tool
}

check_root
server_baseline_collection_tool
