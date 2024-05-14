#!/bin/bash

create_swap_file() {
    local disk_path="$1"
    local swap_file_path="$disk_path/swapfile"
    local swap_size_gb=$2

    # Create swap file
    sudo fallocate -l "${swap_size_gb}G" "$swap_file_path"
    sudo chmod 600 "$swap_file_path"
    sudo mkswap "$swap_file_path"
    sudo swapon "$swap_file_path"

    echo "Swap file created successfully on $disk_path with size ${swap_size_gb}GB"
}

read -p "Enter disk number (1 or 2): " disk_number
read -p "Enter swap size in GB: " swap_size_gb

if [[ $disk_number != "1" && $disk_number != "2" ]]; then
    echo "Invalid disk number. Please enter 1 or 2."
elif ! [[ "$swap_size_gb" =~ ^[0-9]+$ ]] || (( swap_size_gb <= 0 )); then
    echo "Invalid swap size. Please enter a positive integer value for swap size in GB."
else
    if [[ $disk_number == "1" ]]; then
        create_swap_file "/media/fiddle/Data" "$swap_size_gb"
    elif [[ $disk_number == "2" ]]; then
        create_swap_file "/media/fiddle/FiddleDrive" "$swap_size_gb"
    fi
fi