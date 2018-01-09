#!/bin/bash

#----------------------------------------
#Purpose：批量开机、关机、重启
#Author:zyc
#Time:20160316
#Usage:1.手动构造需要操作的虚拟机列表文件
#----------------------------------------

log="/sf/log/today/LOG_batch_operate_vm.log"
vmlist="/sf/data/local/vmlist.txt"

#是否存在日志文件
#if [ ! -e "$log" ]
#then
#  mkdir /sf/data/local/zyc
#  touch "$log"
#fi

#是否存在vmlist文件
if [ ! -e "$vmlist" ]
then
  echo "vmlist.txt doesn't exist.Please create it."
  echo "After create vmlist.txt,try again."
  echo "vmlist.txt path:$vmlist"
  exit 0
fi

#核心处理流程
while :

do
#关掉所有vm，清理环境
for vmid in `cat $vmlist|grep -v "#"`
do 
  qm stop $vmid
  echo "$(date  +"%Y-%m-%d %H:%M:%S")----虚拟机$vmid关机！" >> "$log"
done
sleep 60;

#将所有vm拉起来，构造运行的vm
for vmid in `cat $vmlist|grep -v "#"`
do 
  qm start $vmid
  echo "$(date  +"%Y-%m-%d %H:%M:%S")----虚拟机$vmid开机！" >> "$log"
done
sleep 300;

#for vmid in `cat $vmlist`
#do 
#  #qm reset $vmid
#  kill -9 `ps aux | grep $vmid|grep kvm|awk '{print $2}'`
#  echo "$(date  +"%Y-%m-%d %H:%M:%S")----虚拟机$vmid重启！" >> "$log"
#done
#sleep 30;

done
