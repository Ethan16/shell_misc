#!/bin/bash

#----------------------------------------
#Purpose：批量周期性打快照
#Author:zyc
#Time:20170618
#Usage:1.手动构造需要操作的虚拟机列表文件
#----------------------------------------

log="/sf/log/today/LOG_batch_snapshot_vm.log"
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
  #qm stop $vmid
  
  snapname="zycAutoSnap--$(date  +"%Y-%m-%d_%H-%M-%S")"
  
  #vtpsh get /cluster/vm/6978842027402/snapshot
  #vtpsh delete /cluster/vm/6978842027402/snapshot/a2d2bc71b-1809-41d8-94b0-a7a461fb57d4a
  
  #vtpsh create /cluster/vm/7798080040624/snapshot -snapname "zyc"
  vtpsh create /cluster/vm/${vmid}/snapshot -snapname $snapname
  
  #加一层判断，如果快照已打满(22个)，就将所有快照删除才继续重新打快照
  if [ $? -ne 0 ]
  then
    #获取虚拟机的所有快照snapid
	vtpsh get /cluster/vm/${vmid}/snapshot | grep snapid|awk -F"\"" '{print $4}'>/sf/data/local/${vmid}.txt
	#删除虚拟机的所有快照
	for snapid in `cat ${vmid}.txt`
	do
	  vtpsh delete /cluster/vm/${vmid}/snapshot/${snapid}
	  echo "$(date  +"%Y-%m-%d %H:%M:%S")----虚拟机$vmid已删除快照${snapid}！" >> "$log"
	  sleep 5;
	done
	#删除完毕后重新打快照
	vtpsh create /cluster/vm/${vmid}/snapshot -snapname $snapname
	echo "$(date  +"%Y-%m-%d %H:%M:%S")----虚拟机$vmid已打快照！" >> "$log"
	
	#删除临时文件
	rm -f /sf/data/local/${vmid}.txt
  else
    #快照打成功，打印日志
    echo "$(date  +"%Y-%m-%d %H:%M:%S")----虚拟机$vmid已打快照！" >> "$log"	
  fi  
done
sleep 60;

done
