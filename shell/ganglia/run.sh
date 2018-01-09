#!/bin/bash

#----------------------------------------
#Purpose：提取监控数据并存入test数据库的resource表中
#Author:zyc
#Time:20160121
#Usage:
#----------------------------------------


echo "Starting running Gmond."

/usr/sbin/gmond

echo "Refresh performance data of servers."

#获取Ganglia收集的监控数据，重定向到gmond_msg.txt文件
telnet localhost 8649 > /home/james/lib/shell/ganglia/gmond_msg.txt

/home/james/lib/shell/ganglia/monitor.sh

