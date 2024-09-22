#!/bin/bash

# Define variables
PLAYBOOK_PATH="/home/ec2-user/ansible-project/nginx_monitoring_setup.yml"
INVENTORY_PATH="/home/ec2-user/ansible-project/inventory.ini"
LOG_FILE="/var/log/ansible_playbook_output.log"



# Check if Ansible is installed
if ! command -v ansible-playbook &> /dev/null
then
    echo "Error: ansible-playbook command not found. Please install Ansible." | tee -a $LOG_FILE
    exit 1
fi

# Check if playbook file exists
if [ ! -f "$PLAYBOOK_PATH" ]; then
    echo "Error: Playbook file not found at $PLAYBOOK_PATH" | tee -a $LOG_FILE
    exit 1
fi

# Check if inventory file exists
if [ ! -f "$INVENTORY_PATH" ]; then
    echo "Error: Inventory file not found at $INVENTORY_PATH" | tee -a $LOG_FILE
    exit 1
fi

# Run the Ansible playbook and capture output
{
    echo "Running Ansible playbook..."
    ansible-playbook -i "$INVENTORY_PATH" "$PLAYBOOK_PATH" 2>&1
    if [ $? -eq 0 ]; then
        echo "Playbook executed successfully."
    else
        echo "Error: Playbook execution failed."
        exit 1
    fi
} | tee -a $LOG_FILE
