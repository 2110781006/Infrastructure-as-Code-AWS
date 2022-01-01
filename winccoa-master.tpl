#!/bin/bash
sudo yum update -y
#install git
sudo yum install git
sudo mkdir /opt/winccoa/
cd /opt/winccoa/
#download wincc oa 3.15
sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=13uyFBieqKVAeTh0RonqjOZSDfI7IjRxA' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=13uyFBieqKVAeTh0RonqjOZSDfI7IjRxA" -O WinCC_OA_3.15-base-rhel-0-37.x86_64.rpm && rm -rf /tmp/cookies.txt
#install wincc oa 3.15
sudo yum -y install WinCC_OA_3.15-base-rhel-0-37.x86_64.rpm
#clone git repo
sudo git clone https://github.com/2110781006/Infrastructure-as-Code-AWS.git
sudo git pull
#create wincc oa project
sudo /opt/WinCC_OA/3.15/bin/WCCOActrl -proj 3.15 -n -log +stderr /opt/winccoa/Infrastructure-as-Code-AWS/winccoa/createWinccOaProj.ctl
#switch progs
sudo cp /opt/winccoa/Infrastructure-as-Code-AWS/winccoa/progs_master /opt/winccoa/proj/config/progs
#copy webserver script
sudo cp /opt/winccoa/Infrastructure-as-Code-AWS/winccoa/webserver.ctl /opt/winccoa/zzz/scripts/webserver.ctl
#start wincc oa project
sudo /opt/WinCC_OA/3.15/bin/WCCILpmon -proj zzz -log +stderr
