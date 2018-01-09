#!/bin/bash

#----------------------------------------
#Purpose：批量升级VMP
#Author:zyc
#Time:20160808
#Version:1.0
#Usage:1.手动构造需要升级的设备列表文件 2.在一台服务器设备上执行:bash -x /sf/data/local/batch_update_device_server.sh
#----------------------------------------

LOG_FILE_SERVER="/sf/log/today/LOG_batch_update_device.log"
devicelist="/sf/data/local/device_list.txt"
#要升级的设备都统一使用这个密码:admin123.
device_pwd="sangfor123sangfornetwork"
#server=`cat /cfs/.members |grep `uname -a | awk '{print $2}'`|grep -v nodename |awk -F":" '{print $5}'|sed -e 's/"//g' -e 's/,//g' -e 's/}//g' -e 's/[[:space:]]//g'`

#cluster_if=`cat /sf/cfg/if.d/clusterif.ini |grep ifname|awk -F"=" '{print $2}'`
#server=`cat /sf/cfg/if.d/$cluster_if | grep  address | awk '{print $2}'`
server=`uname -a|awk '{print $2}'`

zyc_log_server()
{
  LOG_MSG="$1"
  echo "[`date +'%Y-%m-%d %H:%M:%S'`]--${LOG_MSG}" >> ${LOG_FILE_SERVER}
}

#是否存在日志文件
if [ ! -e "$LOG_FILE_SERVER" ]
then
  #mkdir /sf/data/local/zyc
  touch "$LOG_FILE_SERVER"
fi

zyc_log_server "[server]server name is :$server ."

prepare_devicelist()
{
  dos2unix $devicelist
  sed -i -e 's/^[ \t]*//g' -e 's/[ \t]*$//g' $devicelist
}

prepare_devicelist

for device in `cat $devicelist|grep -v "#"`
do
  #连通性测试
  ping -c 4 $device
    if [ $? -eq 0 ]
  then
    zyc_log_server "[success]Connect $device good!"
  else
    zyc_log_server "[failed]Connect $device bad!"
    zyc_log_server "we will not update $device ."
    exit 1
  fi
  
  #ssh连接设备，清理环境
  zyc_log_server "[sshpass]Start to ssh $device."
  zyc_log_server "[clearEnv]Start to clean up environment!(remove batch_update_device_client.sh)"
  sshpass -p $device_pwd ssh -n -o ConnectTimeout=100 -o StrictHostKeyChecking=no -t -t root@$device "rm -f  /sf/data/local/batch_update_device_client.sh"
  
  #调试用代码
  #sshpass -p admin123.sangfornetwork scp /sf/data/local/batch_update_device_client.sh root@200.201.136.111:/sf/data/local/;sshpass -p admin123.sangfornetwork scp /sf/data/local/batch_update_device_client.sh root@200.201.136.112:/sf/data/local/;sshpass -p admin123.sangfornetwork scp /sf/data/local/batch_update_device_client.sh root@200.201.136.101:/sf/data/local/;sshpass -p admin123.sangfornetwork scp /sf/data/local/batch_update_device_client.sh root@200.201.136.102:/sf/data/local/;sshpass -p admin123.sangfornetwork scp /sf/data/local/batch_update_device_client.sh root@200.201.188.101:/sf/data/local/;sshpass -p admin123.sangfornetwork scp /sf/data/local/batch_update_device_client.sh root@200.201.188.102:/sf/data/local/
  zyc_log_server "[clearEnv]remove batch_update_device_client.sh finish."
  
  #准备客户端环境
  zyc_log_server "[prepareEnv]Start to send batch_update_device_client.sh to the client."
  sshpass -p $device_pwd scp /sf/data/local/batch_update_device_client.sh root@$device:/sf/data/local/
  zyc_log_server "[prepareEnv]send script finish."
  
  zyc_log_server "[update]ssh the client,execute batch_update_device_client.sh"
  sshpass -p $device_pwd ssh -n -o ConnectTimeout=10000 -o StrictHostKeyChecking=no -t -t root@$device "source /root/.bashrc;/sf/data/local/batch_update_device_client.sh"
  #sshpass -p admin123.sangfornetwork ssh -n -o ConnectTimeout=100 -o StrictHostKeyChecking=no -t -t root@200.201.136.102 "chmod 777 /sf/data/local/batch_update_device_client.sh &&  /sf/data/local/batch_update_device_client.sh"
  
  #sshpass_pid=$(ps aux | grep "sshpass" |awk '{print $2}'|sort -n |head -n 1)
  #sleep 3 && kill ${sshpass_pid} && zyc_log_server "[TermSSH]sleep 3 seconds,kill sshpass progress."

  zyc_log_server "[sshpass]ssh $device finish."
done