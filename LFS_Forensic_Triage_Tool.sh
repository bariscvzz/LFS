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
    Forensic Triage Tool" | tee -a $DEST/$command_log
                                           
echo " " | tee -a $DEST/$command_log
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

function server_command_tool() {
    echo ""
        echo "Create command Information for ${server_name}: "
        echo ""
mkdir -p "$(pwd)/LFS_Forensic_Tool"
DEST="$(pwd)/LFS_Forensic_Tool/"

#Create the file name of collection file(s).

day=$(date +"%m-%d-%Y")
hostname=$(hostname -s)
collection="$hostname.$day"

#Create a log file of the collection process.

echo "Creating Log File..."
command_log="$collection.COMMAND.log"
touch $DEST/$command_log

#Collection Linux System Infermation

echo "======================================================================================" >> $DEST/$command_log
echo "STARTING COLLECTION LINUX SYSTEM INFORMATIN..." | tee -a $DEST/$command_log
echo "**************************************************************************************" >> $DEST/$command_log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List the host name of machine" >> $DEST/$command_log
echo "1- hostnamectl" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
hostnamectl > "$(pwd)"/LFS_Forensic_Tool/1-hostnamectl.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "Linux version and kernel information" >> $DEST/$command_log
echo "2- uname -a" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
uname -a > "$(pwd)"/LFS_Forensic_Tool/2-uname.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List of data/time/timezone" >> $DEST/$command_log
echo "3- timedatectl" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
timedatectl > "$(pwd)"/LFS_Forensic_Tool/3-timedatectl.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List uptime of machine" >> $DEST/$command_log
echo "4- uptime" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
uptime > "$(pwd)"/LFS_Forensic_Tool/4-uptime.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List of system memory information" >> $DEST/$command_log
echo "5- free" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
free > "$(pwd)"/LFS_Forensic_Tool/5-free.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List of system memory information" >> $DEST/$command_log
echo "6- cat /proc/meminfo:" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
cat /proc/meminfo > "$(pwd)"/LFS_Forensic_Tool/6-cat_proc_meminfo.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List last reboot time of machine" >> $DEST/$command_log
echo "7- last reboot:" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
last reboot > "$(pwd)"/LFS_Forensic_Tool/7-reboot.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List of users currently logged on" >> $DEST/$command_log
echo "8- who -H:" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
who -H > "$(pwd)"/LFS_Forensic_Tool/8-who-H.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List last system boot time" >> $DEST/$command_log
echo "9- who -b:" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
who -b  > "$(pwd)"/LFS_Forensic_Tool/9-who-b.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List of ALL accounts on the machine:" >> $DEST/$command_log
echo "10- cat /etc/passwd" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
cat /etc/passwd > "$(pwd)"/LFS_Forensic_Tool/10-cat_etc_passwd.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List of ALL groups used by the user:" >> $DEST/$command_log
echo "11- cat /etc/group" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
cat /etc/group > "$(pwd)"/LFS_Forensic_Tool/11-cat_etc_group.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "Sudoers config file and a list of users with sude access:" >> $DEST/$command_log
echo "12- cat /etc/sudoers" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
cat /etc/sudoers > "$(pwd)"/LFS_Forensic_Tool/12-cat_etc_sudoers.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List of ALL scheduled jobs:" >> $DEST/$command_log
echo "13- cat /etc/crontab" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
cat /etc/crontab > "$(pwd)"/LFS_Forensic_Tool/13-cat_etc_crontab.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List of ALL systemd timers:" >> $DEST/$command_log
echo "14- systemctl status *timer" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
systemctl status *timer > "$(pwd)"/LFS_Forensic_Tool/14-systemctl_status_timer.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List of ALL scheduled jobs:" >> $DEST/$command_log
echo "15- cat /etc/*.d" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
cat /etc/*.d 2>/dev/null > "$(pwd)"/LFS_Forensic_Tool/15-cat_etc_d.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List of CPU's properties and arcgitecture as reported by OS:" >> $DEST/$command_log
echo "16- lscpu" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
lscpu > "$(pwd)"/LFS_Forensic_Tool/16-lscpu.log
echo " " >> $DEST/$command_log
echo "================================================================================" >> $DEST/$command_log
echo "List of hard drives and properties:" >> $DEST/$command_log
echo "17- fdisk -l" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
fdisk -l > "$(pwd)"/LFS_Forensic_Tool/17-fdisk-l_.log
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "COLLECTING SYSTEM INFORMATION... DONE!" | tee -a $DEST/$command_log
echo "**************************************************************************************" >> $DEST/$command_log

#Collect Running Processes

echo " " >> $DEST/$command_log
echo "**************************************************************************************" >> $DEST/$command_log
echo "COLLECTING LIST OF PROCESSES..." >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List running processes with PID and numerically sorted:" >> $DEST/$command_log
echo "18- pstree -p -n" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
pstree -p -n > "$(pwd)"/LFS_Forensic_Tool/18-pstree-p-n.log
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List running processes in tree format w/ command line arguments:" >> $DEST/$command_log
echo "19- pstree -a" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
pstree -a > "$(pwd)"/LFS_Forensic_Tool/19-pstree-a.log
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List running processes:" >> $DEST/$command_log
echo "20- ps -axu" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
ps -axu > "$(pwd)"/LFS_Forensic_Tool/20_ps_axu.log
python3 convert_to_html.py "$(pwd)"/LFS_Forensic_Tool/20_ps_axu.log 20_ps_axu.html >> $DEST/$command_log
rm "$(pwd)"/LFS_Forensic_Tool/20_ps_axu.log
mv 20_ps_axu.html "$(pwd)"/LFS_Forensic_Tool/
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List all processes running from /tmp or /dev directory:" >> $DEST/$command_log
echo "21- ls -alR /proc/-/cwd 2> /dev/null | grep -E 'tmp|dev' " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
ls -alR /proc/*/cwd 2> /dev/null | grep -E "tmp|dev" > "$(pwd)"/LFS_Forensic_Tool/21-ls-alR_proc_cwd.log
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of binaries still running:" >> $DEST/$command_log
echo "22- ls -alR /proc/*/exe " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
ls -alR /proc/*/exe 2>/dev/null > "$(pwd)"/LFS_Forensic_Tool/22_ls_alR_proc_exe.log
python3 convert_to_html.py "$(pwd)"/LFS_Forensic_Tool/22_ls_alR_proc_exe.log 22_ls_alR_proc_exe.html >> $DEST/$command_log
rm "$(pwd)"/LFS_Forensic_Tool/22_ls_alR_proc_exe.log
mv 22_ls_alR_proc_exe.html "$(pwd)"/LFS_Forensic_Tool/
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of deleted binaries still running:" >> $DEST/$command_log
echo "23- ls -alR /proc/*/exe 2> /dev/null | grep deleted " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
ls -alR /proc/*/exe 2> /dev/null | grep deleted > "$(pwd)"/LFS_Forensic_Tool/23-ls-alR_proc_exe_deleted.log
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of deleted binaries recover:" >> $DEST/$command_log
echo "24- cp /proc/*/exe "$(pwd)"/recovereden_bin " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
cp /proc/*/exe "$(pwd)"/recovereden_bin 2>/dev/null > "$(pwd)"/LFS_Forensic_Tool/24-recovered_bin.log
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of startup services at boot:"
echo "25- systemctl list-unit-files --type=service" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
systemctl list-unit-files --type=service > "$(pwd)"/LFS_Forensic_Tool/25_systemctl_list_unit_files.log
python3 convert_to_html.py "$(pwd)"/LFS_Forensic_Tool/25_systemctl_list_unit_files.log 25_systemctl_list_unit_files.html >> $DEST/$command_log 
rm "$(pwd)"/LFS_Forensic_Tool/25_systemctl_list_unit_files.log
mv 25_systemctl_list_unit_files.html "$(pwd)"/LFS_Forensic_Tool/
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of services and their status:" >> $DEST/$command_log
echo "26- service --status-all:" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
service --status-all > "$(pwd)"/LFS_Forensic_Tool/26-service_status_all.log
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "COLLECTING LIST OF PROCESSES... DONE!" >> $DEST/$command_log
echo "**************************************************************************************" >> $DEST/$command_log
echo " " >> $DEST/$command_log

#Collect Network Information

echo " " >> $DEST/$command_log
echo "**************************************************************************************" >> $DEST/$command_log
echo "COLLECTING NETWORK INFORMATION..." | tee -a $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of network devices:" >> $DEST/$command_log
echo "27- ifconfig -a " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
ifconfig -a > "$(pwd)"/LFS_Forensic_Tool/27-ifconfig-a.log
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of iptables :" >> $DEST/$command_log
echo "28- iptables -L " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
iptables -L > "$(pwd)"/LFS_Forensic_Tool/28-iptables.log
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of open files on the system and the process ID that opened them:" >> $DEST/$command_log
echo "29- lsof " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
lsof 2>/dev/null > "$(pwd)"/LFS_Forensic_Tool/29_lsof.log
python3 convert_to_html.py "$(pwd)"/LFS_Forensic_Tool/29_lsof.log 29_lsof.html >> $DEST/$command_log
rm "$(pwd)"/LFS_Forensic_Tool/29_lsof.log
mv 29_lsof.html "$(pwd)"/LFS_Forensic_Tool/
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of network connections:" >> $DEST/$command_log
echo "30- netstat -a " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
netstat -a > "$(pwd)"/LFS_Forensic_Tool/30_netstat_a.log
python3 convert_to_html.py "$(pwd)"/LFS_Forensic_Tool/30_netstat_a.log 30_netstat_a.html >> $DEST/$command_log
rm "$(pwd)"/LFS_Forensic_Tool/30_netstat_a.log
mv 30_netstat_a.html "$(pwd)"/LFS_Forensic_Tool/
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of network interfaces:" >> $DEST/$command_log
echo "31- netstat -i " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
netstat -i > "$(pwd)"/LFS_Forensic_Tool/31_netstat_i.log
python3 convert_to_html.py "$(pwd)"/LFS_Forensic_Tool/31_netstat_i.log 31_netstat_i.html >> $DEST/$command_log
rm "$(pwd)"/LFS_Forensic_Tool/31_netstat_i.log
mv 31_netstat_i.html "$(pwd)"/LFS_Forensic_Tool/
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of kernel network routing table:" >> $DEST/$command_log
echo "32- netstat -r " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
netstat -r > "$(pwd)"/LFS_Forensic_Tool/32_netstat_r.log
python3 convert_to_html.py "$(pwd)"/LFS_Forensic_Tool/32_netstat_r.log 32_netstat_r.html >> $DEST/$command_log
rm "$(pwd)"/LFS_Forensic_Tool/32_netstat_r.log
mv 32_netstat_r.html "$(pwd)"/LFS_Forensic_Tool/
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of network connections:" >> $DEST/$command_log
echo "33- netstat -nalp " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
netstat -nalp > "$(pwd)"/LFS_Forensic_Tool/33_netstat_nalp.log
python3 convert_to_html.py "$(pwd)"/LFS_Forensic_Tool/33_netstat_nalp.log 33_netstat_nalp.html >> $DEST/$command_log
rm "$(pwd)"/LFS_Forensic_Tool/33_netstat_nalp.log
mv 33_netstat_nalp.html "$(pwd)"/LFS_Forensic_Tool/
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of Network Connections:" >> $DEST/$command_log
echo "34- netstat -plant " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
netstat -plant > "$(pwd)"/LFS_Forensic_Tool/34_netstat_plant.log
python3 convert_to_html.py "$(pwd)"/LFS_Forensic_Tool/34_netstat_plant.log 34_netstat_plant.html >> $DEST/$command_log
rm "$(pwd)"/LFS_Forensic_Tool/34_netstat_plant.log
mv 34_netstat_plant.html "$(pwd)"/LFS_Forensic_Tool/
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of the ARP table cache (Address Resolution Protocol):" >> $DEST/$command_log
echo "35- arp -a " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
arp -a > "$(pwd)"/LFS_Forensic_Tool/35-arp-a.log
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of all connection and interface:" >> $DEST/$command_log
echo "36- ss -a -e -i " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
ss -a -e -i > "$(pwd)"/LFS_Forensic_Tool/36_ss_a_e_i.log
python3 convert_to_html.py "$(pwd)"/LFS_Forensic_Tool/36_ss_a_e_i.log 36_ss_a_e_i.html >> $DEST/$command_log
rm "$(pwd)"/LFS_Forensic_Tool/36_ss_a_e_i.log
mv 36_ss_a_e_i.html "$(pwd)"/LFS_Forensic_Tool/
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "COLLECTING NETWORK INFORMATION DONE..." | tee -a $DEST/$command_log
echo "**************************************************************************************" >> $DEST/$command_log
echo " " >> $DEST/$command_log

#Create a directory listing of ALL files:

echo " " >> $DEST/$command_log
echo "**************************************************************************************" >> $DEST/$command_log
echo "CREATING DIRECTORY LISTING OF FILES..." | tee -a $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of MD5 hash for all executable files:" >> $DEST/$command_log
echo "37- find /usr/bin -type f -exec file "{}" \; | grep -i "elf" | cut -f1 -d: | xargs -I "{}" -n 1 md5sum {} " | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
find /usr/bin -type f -exec file "{}" \; | grep -i "elf" | cut -f1 -d: | xargs -I "{}" -n 1 md5sum {} 2>/dev/null > "$(pwd)"/LFS_Forensic_Tool/37-find_executable_file.log
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List ALL log files that contain binary code inside:" >> $DEST/$command_log
echo "38- grep [[:cntrl:]] /var/log/*.log" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
grep [[:cntrl:]] /var/log/*.log > "$(pwd)"/LFS_Forensic_Tool/38-grep_contain_binary_code.log
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "CREATING DIRECTORY LISTING OF FILES... DONE!" | tee -a $DEST/$command_log
echo "**************************************************************************************" >> $DEST/$command_log
echo " " >> $DEST/$command_log

#Collect MySQL Information

echo " " >> $DEST/$command_log
echo "**************************************************************************************" >> $DEST/$command_log
echo "COLLECTING MYSQL INFORMATION..." | tee -a $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "Copy of ALL mysql logs" >> $DEST/$command_log
echo "39- cp -r /var/log/mysql "$(pwd)"/LFS_Forensic_Tool/" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
cd "$(pwd)"/LFS_Forensic_Tool && mkdir var_log_mysql 2>/dev/null
cp -r /var/log/mysql "$(pwd)"/LFS_Forensic_Tool/var_log_mysql 2>/dev/null
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "Copy mysql.confd" >> $DEST/$command_log
echo "40- cp -r /etc/mysql/mysql.confd "$(pwd)"/LFS_Forensic_Tool/" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
cp -r /etc/mysql/mysql.confd "$(pwd)"/LFS_Forensic_Tool/ 2>/dev/null
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "Copy mysql log files" >> $DEST/$command_log
echo "41- cp -r /var/lib/mysql "$(pwd)"/LFS_Forensic_Tool/" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
cd "$(pwd)"/LFS_Forensic_Tool && mkdir var_lib_mysql 2>/dev/null
cp -r /var/lib/mysql "$(pwd)"/LFS_Forensic_Tool/var_lib_mysql/ 2>/dev/null
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "MySQL Version Information" >> $DEST/$command_log
echo "42- mysql --version" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
mysql --version 2>/dev/null > "$DEST/42-mysql_version.log"      
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "Copy of ALL users mysql.history file" >> $DEST/$command_log
echo "43- /home/<user_name>/mysql.history" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
user_home_dir="/home/"
mkdir "$DEST/43-users_mysql_history"
date=$(date +%Y-%m-%d)

for user_dir in $(ls $user_home_dir); do
  mysql_history_file="$user_home_dir$user_dir/mysql.history"
  if [ -f "$mysql_history_file" ]; then
    cp "$mysql_history_file" "$user_dir-mysql-history-$date"
  fi
done
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "COLLECTING MYSQL INFORMATION... DONE!" | tee -a $DEST/$command_log
echo "**************************************************************************************" >> $DEST/$command_log
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of ALL users crontab" >> $DEST/$command_log
echo "44- ALL Users crontab processes" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
USERS=$(getent passwd | cut -d: -f1)
for user in $USERS
do
    if crontab -u "$user" -l >> "$DEST/44-crontab_all_users.log" 2>&1; then
        "" 2>/dev/null >> 44-crontab_all_users.log
    else
        if ! grep -q "no crontab for $user" 44-crontab_all_users.log; then
            "no crontab for $user" >> "$DEST/44-crontab_all_users.log"
        fi
    fi
done
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "List of Users who have received SSH Keys in the last month " >> $DEST/$command_log
echo "45- All Users received SSH Keys" >> $DEST/$command_log
echo " " >> $DEST/$command_log
output_file="$DEST/45-ssh_authorized_keys.log"

if [ -f "$output_file" ]
then
    > "$output_file"
else
    touch "$output_file"
fi

users=$(awk -F: '{print $1}' /etc/passwd)

for user in $users
do
    ssh_dir="/home/$user/.ssh"
    auth_keys="$ssh_dir/authorized_keys"
    if [ -d "$ssh_dir" ] && [ -f "$auth_keys" ]
    then
        last_mod=$(find $auth_keys -mtime -30)
        if [ "$last_mod" != "" ]
        then
            grep "ssh-rsa" $auth_keys | awk '{print $NF}' | while read key; do
                echo "$user - $key" >> "$output_file"
            done
        fi
    fi
done
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo " " >> $DEST/$command_log
echo "List of sshd.config information" >> $DEST/$command_log
echo "46- SSH Port Number, RSAAuthentication, PubkeyAuthentication, PermitRootLogin, LogLevel, Banner" | tee -a $DEST/$command_log
echo " " >> $DEST/$command_log
cat /etc/ssh/sshd_config 2>/dev/null > "$DEST/46-sshd.config.log"
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo " " >> $DEST/$command_log
echo "47- List of All Users /var/spool/cron/crontabs/" | tee -a $DEST/$command_log
USERS=$(cut -d: -f1 /etc/passwd)

for USER in $USERS; do
    if [ -f "/var/spool/cron/crontabs/$USER" ]; then
        cd "/var/spool/cron/crontabs/"
        cp $USER "$DEST/$USER.crontab"
    fi
done
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo " " >> $DEST/$command_log
echo "48- at command forensic" >> $DEST/$command_log
echo "at -l && at -c <job_id>" >> $DEST/$command_log
at_output=$(at -l)
echo "at processes create time and IDs" >> "$(pwd)"/LFS_Forensic_Tool
echo "${at_output}" | awk '{print "id: " $1 ", time: " $2}' >> "$(pwd)"/LFS_Forensic_Tool
echo "at process details:" >> $DEST/$command_log
cd $DEST
while read -r line; do
    job_id="${line%% *}"
    at -c "${job_id}" >> "$DEST/48-at_command.log"
    echo "id: ${job_id}"  >> "$DEST/48-at_command.log"
    echo "----------" >> "$DEST/48-at_command.log"
done <<< "${at_output}"

echo "at processes saved: 48-at_command.log" >> $DEST/$command_log
echo " " >> $DEST/$command_log
echo "======================================================================================" | tee -a $DEST/$command_log
echo "49- Lists the names of compressed files created in the last 1 month under all directories." >> $DEST/$command_log
echo "" | tee -a $DEST/$command_log
find / -type f \( -iname '*.tar*' -o -iname '*.zip*' -o -iname '*.gz*' -o -iname '*.rar*' -o -iname '*.7z*' \) -mtime -30 > "$DEST/49-Last30days_zipfiles_list.log"
echo " " >> $DEST/$command_log
echo "======================================================================================" >> $DEST/$command_log
echo "Adding to Zip File" | tee -a $DEST/$command_log
cd "$DEST" && cd .. && zip -r LFS_Forensic_Tool.zip ./LFS_Forensic_Tool -i "*" >> $DEST/$command_log
echo "======================================================================================" | tee -a $DEST/$command_log
echo "Forensic Triaga Tool COMPLETED Forensic and DELETE forensic files" | tee -a $DEST/$command_log
echo "**************************************************************************************" | tee -a $DEST/$command_log
rm -rf "$(pwd)"/LFS_Forensic_Tool 
}

check_root
server_command_tool