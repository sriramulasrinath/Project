#!/bin/bash
env > /tmp/env_info.log
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
git clone https://github.com/sriramulasrinath/Project.git &>>$LOGFILE
dnf install ansible -y 




# Clone the repository and log output
if git clone https://github.com/sriramulasrinath/Project.git >> $LOGFILE 2>&1; then
    echo "Git clone succeeded." >> $LOGFILE
else
    echo "Git clone failed." >> $LOGFILE
fi