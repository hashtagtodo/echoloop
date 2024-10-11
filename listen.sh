#!/bin/bash

echo -e "\e[31m         _       _             "
sleep 0.3
echo -e " ___ ___| |_ ___| |___ ___ ___ "
sleep 0.3
echo -e "| -_|  _|   | . | | . | . | . |"
sleep 0.3
echo -e "|___|___|_|_|___|_|___|___|  _|"
sleep 0.3
echo -e " by @hashtagtodo          |_|  "
sleep 0.3
echo -e "\e[0m"

#sudo check
check_root_permissions() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "\e[31mThis script must be run with root permissions.\e[0m"
        exit 1
    fi
}


listen_shell() {
    local port=$1
    while true; do
        echo -e "\e[33mStarting Netcat service on port $port...\e[0m"
        nc -lvnp "$port" 2>&1 | while IFS= read -r line; do
            if [[ "$line" == *"connect to"* ]]; then
                echo -e "\e[32mConnection received!\e[0m"
            fi
            echo -e "\e[34m$line\e[0m"
        done
        echo -e "\e[31mConnection terminated, restarting service on port $port...\e[0m"
    done
}


check_root_permissions
read -p "Enter the port to use (default 4444): " port
port=${port:-4444}
listen_shell "$port"