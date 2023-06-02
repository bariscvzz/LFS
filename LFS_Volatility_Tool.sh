#!/bin/bash

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
check_root

DEST="$(pwd)"
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
"
echo "*************************************************************************"
echo "***              1) Volatility Installation                           ***"
echo "***              2) Create a Linux Profile for Volatility             ***"
echo "***              3) Linux Memory Dump Analysis                        ***"
echo "***              4) Exit                                              ***"
echo "*************************************************************************"

read -p "Choice: " choice

case $choice in
    "1")
        echo "Installing Volatility"
        echo "Please Wait..."
        sudo apt install -y python2.7 python-setuptools python2.7-dev curl > /dev/null 2>&1
        curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py > /dev/null 2>&1
        sudo python2.7 get-pip.py > /dev/null 2>&1
        sudo python2.7 -m pip install -U setuptools wheel > /dev/null 2>&1
        python2.7 -m pip install distorm3==3.4.4 > /dev/null 2>&1
        python2.7 -m pip install pycrypto > /dev/null 2>&1
        sudo apt install yara -y > /dev/null 2>&1
        rm get-pip.py > /dev/null 2>&1
        git clone https://github.com/volatilityfoundation/volatility.git > /dev/null 2>&1
        chmod +x volatility/vol.py > /dev/null 2>&1
        cd volatility
        python2.7 setup.py build > /dev/null 2>&1
        python2.7 setup.py install > /dev/null 2>&1
        echo "Your volatility path: $DEST/volatility"
        cd $DEST

        ;;
    "2")
        echo "Creating Linux Profile for Volatility..."
        echo "Please enter the full path of the memory dump file (e.g. /home/user/memory.dmp): "
        read -p "Memory Dump Location: " memdump_path
        if [ ! -f "$memdump_path" ]; then
            echo "File not found!"
            exit 1
        fi
        kernel_info=$(sudo strings $memdump_path | grep "Linux version 4.*\|Linux version 5.*" | head -n 1 | cut -d ' ' -f 3)
        sudo apt-get install linux-image-"$kernel_info" -y > /dev/null 2>&1
        sudo apt-get install linux-headers-"$kernel_info" -y > /dev/null 2>&1
        sudo apt-get install dwarfdump -y > /dev/null 2>&1
        sudo apt-get install zip -y > /dev/null 2>&1
        cd $DEST/volatility/tools/linux
        echo 'MODULE_LICENSE("GPL");' >> module.c > /dev/null 2>&1
        sudo make -C /lib/modules/"$kernel_info"/build CONFIG_DEBUG_INFO=y M="$PWD" modules > /dev/null 2>&1
        dwarfdump -di ./module.o > module.dwarf > /dev/null 2>&1
        sudo zip "$(lsb_release -i -s)"_"$kernel_info"_profile.zip module.dwarf /boot/System.map-"$kernel_info" > /dev/null 2>&1
        mv "$(lsb_release -i -s)"_"$kernel_info"_profile.zip $DEST/volatility/volatility/plugins/overlays/linux/ > /dev/null 2>&1
        cd $DEST/volatility
        echo " "
        echo "Profile Checking..."
        echo " "
        python2.7 vol.py --info | grep -i "$kernel_info"

        ;;
    "3")
        echo "Started Linux Memory Dump Analysis..."
        echo "Please enter the full path of the memory dump file (e.g. /home/user/memory.dmp): "
        read -p "Memory Dump Location: " mem_location

        if [ ! -f "$mem_location" ]; then
            echo "File not found!"
            exit 1
        fi

        echo "Please enter the profile name (e.g. LinuxUbuntu_4_15_0-118-generic_profilex64): "
        read -p "Profile: " profile

        plugins=(
            "linux_arp"
            "linux_bash"
            "linux_bash_env"
            "linux_bash_hash"
            "linux_check_afinfo"
            "linux_check_creds"    
            "linux_check_fop"
            "linux_check_idt"
            "linux_check_modules"
            "linux_check_syscall"
            "linux_check_tty"
            "linux_cpuinfo"
            "linux_dynamic_env"
            "linux_elfs"
            "linux_getcwd"
            "linux_hidden_modules"
            "linux_ifconfig"
            "linux_iomem"
            "linux_kernel_opened_files"
            "linux_keyboard_notifiers"
            "linux_library_list"
            "linux_lsmod"
            "linux_lsof"
            "linux_malfind"
            "linux_netstat"
            "linux_pidhashtable"
            "linux_proc_maps"
            "linux_proc_maps_rb"
            "linux_psaux"
            "linux_psenv"
            "linux_pslist"
            "linux_psscan"
            "linux_pstree"
        )
        mkdir $DEST/volatility_results
        for plugin in "${plugins[@]}"
        do
            output_file="$DEST/volatility_results/${plugin}.html"
            cd $DEST/volatility
            command="python2.7 vol.py -f ${mem_location} --profile=${profile} ${plugin} --output=html > ${output_file}"
            eval "${command}"
        done

        echo "Finished Analysis. Outputs are stored under $DEST/volatility_results directory."

        ;;
    "4")
        echo "Exiting Program"
        exit 1
        ;;
    *)
        echo "You have entered incorrectly. Please try again."
        exit 1
        ;;
esac
