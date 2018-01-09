#!/bin/bash

#----------------------------------------
#Purpose：批量升级VMP的客户端执行脚本
#Author:zyc
#Time:20160808
#Version:1.0
#Usage:1.会被batch_update_device_server.sh所调用执行
#----------------------------------------

source /root/.bashrc
package_version="HCI5.8.5"
package_url="http://200.200.166.1:8080/job/Compile/job/${package_version}_Compile/lastSuccessfulBuild/artifact/"
#            http://200.200.166.1:8080/job/Compile/job/HCI5.4.1_Compile/lastSuccessfulBuild/artifact/build.dev

#新连接中定义日志使用
LOG_FILE_Client="/sf/log/today/LOG_batch_update_device.log"
zyc_log_client()
{
  LOG_MSG="$1"
  echo "[`date +'%Y-%m-%d %H:%M:%S'`]--${LOG_MSG}" >> ${LOG_FILE_Client}
}
 
#清理环境
zyc_log_client "[clearEnv]Start to clean up environment!(remove build.*)"
rm -f /sf/data/local/build.*

#下载升级包
zyc_log_client "[download]Start to download build.dev!"
cd /sf/data/local
wget -c ${package_url}build.dev

#计算build.dev的md5值，并与Jenkins上的包的MD5值做比较
wget -c ${package_url}build.md5sums

standard_md5=`cat /sf/data/local/build.md5sums | grep dev |awk '{print $1}'`
current_md5=`md5sum /sf/data/local/build.dev|awk '{print $1}'`

package_name=`cat /sf/data/local/build.md5sums |awk '{print $2}'|awk -F"/" '{print $3}'|grep dev`

if [ "$current_md5" = "$standard_md5" ]
then
  zyc_log_client "[packageMD5]standard_md5: $standard_md5 .current_md5: $current_md5 "
  zyc_log_client "[success]Congratulations,you get the right package: $package_name ."
else
  zyc_log_client "[packageMD5]standard_md5: $standard_md5 .current_md5: $current_md5 "
  zyc_log_client "[failed]Sorry,you get the false package( $package_name ).Pls try again."
  zyc_log_client "[clear]Clear download files ."
  rm -f /sf/data/local/build.* /sf/data/local/batch_update_device_client.sh
  exit 1
fi
  
#开始升级设备
#device=`ifconfig |grep 200.201.136|awk '{print $2}'|awk -F":" '{print $2}'`
#device=`cat /cfs/.members |grep `uname -a | awk '{print $2}'`|grep -v nodename |awk -F":" '{print $5}'|sed -e 's/"//g' -e 's/,//g' -e 's/}//g' -e 's/[[:space:]]//g'`
cluster_if=`cat /sf/cfg/if.d/clusterif.ini |grep ifname|awk -F"=" '{print $2}'`
device=`cat /sf/cfg/if.d/$cluster_if | grep  address | awk '{print $2}'`

zyc_log_client "[update]Start to update $device."
chmod 755 /sf/data/local/build.dev

#做一次权限检查
auth_check=`whoami`
zyc_log_client "[auth_check]current user: $auth_check ."

/sf/data/local/build.dev -cip sangfor.vt@201314 >> ${LOG_FILE_Client} 2>&1

  #升级客户端
  #升级过程中有一个问题很难啃，记录下:batch_update_device_client.sh直接在客户端手动执行是没问题的，但是通过
  #batch_update_device_server.sh去调用执行，升级过程会失败。
  #平滑配置失败! exit^[[01;31m(1)^[[00m!
  #   rm -rf /boot/firmware/update/laststage.outcfg
  #   rm -rf /var/vs/utmp
  #  [[01;31m/sf/data/local/build.dev can not replacefiles, error(1)^[[00m, exit 9
  #[解决办法]1.仿照gwl写sfd_clu_hosts_do.sh的方式，在ssh执行命名最后加 & 符合，在后台执行命令。→ 没用！还是失败
  #2.经slq指导，需要在client中执行: source /root/.bashrc  命令，保证本地没问题。问题已解决！

#判断是否升级成功
if [ $? -eq 0 ]
then
  zyc_log_client "[update]update successful!"
  
  #升级完毕，重启设备
  zyc_log_client "[clear]Now ,we will clear download files and reboot to make device update successful."
  zyc_log_client "[clear]Clear download files ."
  rm -f /sf/data/local/build.* /sf/data/local/batch_update_device_client.sh
  
  #关闭维护模式后重启
  #vtpsh create /cluster/update/close_protect
  reboot
  exit 0
else
  zyc_log_client "[update]update failed!Pls try again."
  zyc_log_client "[clear]Clear download files ."
  rm -f /sf/data/local/build.* /sf/data/local/batch_update_device_client.sh
  
  #关闭维护模式
  #vtpsh create /cluster/update/close_protect
  exit 1
fi