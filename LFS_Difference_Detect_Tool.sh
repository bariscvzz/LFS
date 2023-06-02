#!/bin/bash

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
        Difference Detect Tool" | tee -a $DEST/log_Difference.txt
                                           
echo " " | tee -a $DEST/log_Difference.txt
                                                    
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

# Extract Baseline_Tool.zip and Forensic_tool.zip to separate directories

unzip -q LFS_Baseline_Tool.zip
unzip -q LFS_Forensic_Tool.zip

mkdir -p "$(pwd)/LFS-Difference-Results"
DEST="$(pwd)/LFS-Difference-Results/"

touch $DEST/log_Difference.txt

for file in LFS_Baseline_Tool/*; do
    if [[ -f "${file}" ]]; then
        filename=$(basename -- "${file}")
        if [ -f "LFS_Forensic_Tool/${filename}" ]; then
            outputfile="Jotform-Difference-Results/diff_${filename}.txt"
            echo "Comparing ${filename} and LFS_Forensic_Tool/${filename}. Output file: ${outputfile}" >> $DEST/log_Difference.txt
            diff "${file}" "LFS_Forensic_Tool/${filename}" > "${outputfile}"
            echo "************************************************" >> $DEST/log_Difference.txt
        fi
    fi
done

rm -rf LFS_Baseline_Tool LFS_Forensic_Tool

echo ""
echo "FINISHED"
}

check_root
server_command_tool
