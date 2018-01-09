#!/bin/bash

#Purpose：一键下载ISO文件到当前位置
#Author:zyc
#Time:20161012
#Version:2.0
#Design:主要解决2个问题：1.从办公网上传ISO太慢了(2MB/s的均速) 2.得一个个手动上传
#Usage:1.vmp前台添加存储  2.后台cd到存储所在的iso目录  3.执行该脚本
#Change log:
#2016-10-11 17:15:05  以函数形式重构代码，分离出资源路径，便于拓展；整理常用的Windows、Linux资源，便于VMP和HCI使用
#Bequeath Questions:
#1.只支持http、ftp等类型路径，暂不支持samba共享(使用smbclient应该可以处理，暂无需求，不再扩充)。

LOG_FILE_Client="/sf/log/today/LOG_batch_upload_iso.log"
ISO_Address="${PWD}/iso_address.txt"

#定义日志函数
zyc_log()
{
	LOG_MSG="$1"
	echo "[`date +'%Y-%m-%d %H:%M:%S'`]--${LOG_MSG}" >> ${LOG_FILE_Client}
}

#资源文件处理:1、将文件由Windows转换为unix；2、删掉文件行首和行尾的空格。
prepare_iso_address()
{
  dos2unix $ISO_Address
  sed -i -e 's/^[ \t]*//g' -e 's/[ \t]*$//g' $ISO_Address
}

#上传ISO镜像函数
upload_iso()
{
  #提示上传ISO。ISO主要为中文版
  zyc_log "Now,we will upload ISO."
  
  #循环处理每个资源
  for address in `cat ${ISO_Address}|grep -v "#"`
  do
    	
	#提取出路径中的iso的名字
	echo $address > ${PWD}/iso_name.tmp
	
	#iso_name=`awk -F"\/" '{print $7}' ${PWD}/iso_name.tmp`
	iso_name=`awk -F"\/" '{print $NF}' ${PWD}/iso_name.tmp`
    
	#判断是否存在该ISO文件，不存在就下载
	if [ ! -f "${iso_name}" ]
	then
	  wget -c --ftp-user=vtt --ftp-password=123 $address
	  zyc_log "[success]Upload iso success: $iso_name "
	else
	  zyc_log "[fail]ISO already exsit: $iso_name "
	fi
	
	#清理临时文件
	rm -f ${PWD}/iso_name.tmp
	
  done
}

prepare_iso_address
upload_iso

zyc_log "[finish]Upload ISO finished."