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
        Memory Dump Tool" | tee -a $DEST/$memory_log

echo " " >> $DEST/$memory_log

function check_root() {
    echo ""
    echo "Checking for root/sudo priviliges: "
    echo ""

    if [ "$EUID" -ne 0 ]
        then echo "!!! YOU ARE NOT ROOT !!!  PLEASE RE-RUN THIS SCRIPT WITH ROOT PRIVILIGES!" && exit
    else
        echo "Congratulations! You have root/sudo privileges..."                                                                                                                                                            
    fi                                                                                                                                                                                                                      
                                                                                                                                                                                                                            
    echo ""                                                                                                                                                                                                                 
}                                                                                                                                                                                                                           
                                                                                                                                                                                                                            
function server_memory_tool() {                                                                                                                                                                                             
    echo ""                                                                                                                                                                                                                 
    echo "Create Memory Information for ${server_name}: "                                                                                                                                                                   
    echo ""                                                                                                                                                                                                                 
    
    mkdir -p "$(pwd)/LFS_Memory_Dump"
    DEST="$(pwd)/LFS_Memory_Dump"

    # Create the file name of collection file(s).                                                                                                                                                                           
    day=$(date +"%m-%d-%Y")                                                                                                                                                                                                 
    hostname=$(hostname -s)                                                                                                                                                                                                 
    collection="$hostname.$day"                                                                                                                                                                                             
                                                                                                                                                                                                                            
    # Create a log file of the collection process.                                                                                                                                                                          
    memory_log="$collection.memory.log"                                                                                                                                                                                     
    memory_dump="$collection.memory.lime"                                                                                                                                                                                   
    touch $DEST/$memory_log                                                                                                                                                                                                 
                                                                                                                                                                                                                            
    echo "======================================================================================" >> $DEST/$memory_log
    echo "STARTING MEMORY DUMP..." | tee -a $DEST/$memory_log
    echo "**************************************************************************************" >> $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "======================================================================================" >> $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "Install Git:" >> $DEST/$memory_log
    echo "sudo apt install git -y" >> $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    sudo apt install git -y | tee -a $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "======================================================================================" >> $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "Install build-essential:" >> $DEST/$memory_log
    echo "sudo apt install build-essential -y" >> $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    sudo apt install build-essential -y | tee -a $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "======================================================================================" >> $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "Install Linux Image matching uname -r:"
    echo "sudo apt install linux-image-$(uname -r) -y"
    echo " " >> $DEST/$memory_log
    sudo apt install linux-image-$(uname -r) -y | tee -a $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "======================================================================================" >> $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "sudo apt install linux-headers-$(uname -r) -y" | tee -a $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    sudo apt install linux-headers-$(uname -r) -y 2>&1 | tee -a $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "======================================================================================" >> $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "Install zip -y" | tee -a $DEST/$memory_log
    sudo apt install zip -y | tee -a $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "======================================================================================" >> $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "Install Lime "$(pwd)"" >> $DEST/$memory_log
    echo "git clone https://github.com/504ensicsLabs/LiME.git" | tee -a $DEST/$memory_log
    git clone https://github.com/504ensicsLabs/LiME.git 2>&1 | tee -a $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "======================================================================================" >> $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "Lime/src make" >> $DEST/$memory_log
    echo "cd Lime/src make" | tee -a $DEST/$memory_log
    cd "$(pwd)"/LiME/src && make 2>&1 | tee -a $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "======================================================================================" >> $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "Memory Dump" >> $DEST/$memory_log
    echo "$DEST/memory.lime" >> $DEST/$memory_log
    sudo /sbin/insmod "$(pwd)"/lime-$(uname -r).ko path=$DEST/$memory_dump format=lime 2>&1 | tee -a $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "======================================================================================" >> $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "Memory Checking" >> $DEST/$memory_log
    if [ -e "$DEST/$memory_dump" ]; then
        echo "The $memory_dump FILE EXISTS." | tee -a $DEST/$memory_log
    else
        echo "The $memory_dump FILE DOES NOT EXIST!!!..." | tee -a $DEST/$memory_log
    fi
    echo " " >> $DEST/$memory_log
    echo "======================================================================================" >> $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "Adding to Zip File" >> $DEST/$memory_log
    cd $DEST && cd .. && zip -r LFS_Memory_Dump.zip ./LFS_Memory_Dump -i "*"
    echo " " >> $DEST/$memory_log
    echo "======================================================================================" >> $DEST/$memory_log
    echo " " >> $DEST/$memory_log
    echo "======================================================================================" >> $DEST/$memory_log
    echo "MEMORY DUMP COMPLETED and DELETE LiME and other download files" | tee -a $DEST/$memory_log
    echo "**************************************************************************************" >> $DEST/$memory_log
    cd $DEST && cd .. && rm -rf LFS_Memory_Dump/ LiME/
}

check_root
server_memory_tool
