#!/bin/bash

#Purpose：一键上传ISO文件到指定存储
#Author:zyc
#Time:20160922
#Version:1.0
#Design:主要解决2个问题：1.从办公网上传ISO太慢了(2MB/s的均速) 2.得一个个手动上传
#Usage:1.vmp前台添加存储  2.后台cd到存储所在的iso目录  3.执行该脚本

LOG_FILE_Client="/sf/log/today/LOG_batch_upload_iso.log"

#定义日志函数
zyc_log()
{
	LOG_MSG="$1"
	echo "[`date +'%Y-%m-%d %H:%M:%S'`]--${LOG_MSG}" >> ${LOG_FILE_Client}
}

#上传Windows desktop类的ISO。主要为中文版
zyc_log "Now,we will upload Windows desktop ISO."

if [ ! -f "${PWD}/winxp_x86_cn_pro_sp2_BX6HT-MDJKW-H2J4X-BX67W-TVVFG.iso" ]
then
  wget -c --ftp-user=vtt --ftp-password=123 ftp://200.200.164.111/01-ISO/Windows/01-winXP/winxp_x86_cn_pro_sp2_BX6HT-MDJKW-H2J4X-BX67W-TVVFG.iso
  zyc_log "[iso]Upload winXP iso success."
fi

if [ ! -f "${PWD}/en_win_xp_pro_x64_with_sp2__B66VY-4D94T-TPPD4-43F72-8X4FY.iso" ]
then
  wget -c --ftp-user=vtt --ftp-password=123 ftp://200.200.164.111/01-ISO/Windows/01-winXP/en_win_xp_pro_x64_with_sp2__B66VY-4D94T-TPPD4-43F72-8X4FY.iso
  zyc_log "[iso]Upload winXP-x64 iso success."
fi

if [ ! -f "${PWD}/cn_windows_7_ultimate_x86_dvd_x15-65907.iso" ]
then
  wget -c --ftp-user=vtt --ftp-password=123 ftp://200.200.164.111/01-ISO/Windows/02-win7/cn_windows_7_ultimate_x86_dvd_x15-65907.iso
  zyc_log "[iso]Upload win7-x86 iso success."
fi

if [ ! -f "${PWD}/cn_windows_7_ultimate_x64_dvd_x15-66043.iso" ]
then
  wget -c --ftp-user=vtt --ftp-password=123 ftp://200.200.164.111/01-ISO/Windows/02-win7/cn_windows_7_ultimate_x64_dvd_x15-66043.iso
  zyc_log "[iso]Upload win7-x64 iso success."
fi

#if [ ! -f "${PWD}/cn_windows_8_1_enterprise_x86_dvd_2972257.iso" ]
#then
#  wget -c --ftp-user=vtt --ftp-password=123 ftp://200.200.164.111/01-ISO/Windows/03-win8/cn_windows_8_1_enterprise_x86_dvd_2972257.iso
#  zyc_log "[iso]Upload win8.1-x86 iso success."
#fi
#
#if [ ! -f "${PWD}/cn_windows_8_1_enterprise_x64_dvd_2971863.iso" ]
#then
#  wget -c --ftp-user=vtt --ftp-password=123 ftp://200.200.164.111/01-ISO/Windows/03-win8/cn_windows_8_1_enterprise_x64_dvd_2971863.iso
#  zyc_log "[iso]Upload win8.1-x64 iso success."
#fi

if [ ! -f "${PWD}/Windows10_x86_ch.iso" ]
then
  wget -c --ftp-user=vtt --ftp-password=123 ftp://200.200.164.111/01-ISO/Windows/04-win10/Windows10_x86_ch.iso
  zyc_log "[iso]Upload win10-x86 iso success."
fi

if [ ! -f "${PWD}/cn_windows_10_multiple_editions_x64_dvd_6848463.iso" ]
then
  wget -c --ftp-user=vtt --ftp-password=123 ftp://200.200.164.111/01-ISO/Windows/04-win10/cn_windows_10_multiple_editions_x64_dvd_6848463.iso
  zyc_log "[iso]Upload win10-x64 iso success."
fi

zyc_log "Upload Windows desktop ISO finish.Next,upload Windows server ISO."

#上传Windows Server类的ISO。主要为中文版
if [ ! -f "${PWD}/win_2003_SP2_Enterprise_CN.iso" ]
then
  wget -c --ftp-user=vtt --ftp-password=123 ftp://200.200.164.111/01-ISO/Windows/04-win2003/win_2003_SP2_Enterprise_CN.iso
  zyc_log "[iso]Upload win2003-x86 iso success."
fi

if [ ! -f "${PWD}/cn_win_srv_2003_r2_standard_x64_with_sp2_vl_cd1_X13-47363.iso" ]
then
  wget -c --ftp-user=vtt --ftp-password=123 ftp://200.200.164.111/01-ISO/Windows/04-win2003/cn_win_srv_2003_r2_standard_x64_with_sp2_vl_cd1_X13-47363.iso
  zyc_log "[iso]Upload win2003-x64 CD1 iso success."
fi

if [ ! -f "${PWD}/cn_win_srv_2003_r2_standard_x64_with_sp2_vl_cd2_X13-28819.iso" ]
then
  wget -c --ftp-user=vtt --ftp-password=123 ftp://200.200.164.111/01-ISO/Windows/04-win2003/cn_win_srv_2003_r2_standard_x64_with_sp2_vl_cd2_X13-28819.iso
  zyc_log "[iso]Upload win2003-x64 CD2 iso success."
fi

if [ ! -f "${PWD}/WindowsServer2008_x86.iso" ]
then
  wget -c --ftp-user=vtt --ftp-password=123 ftp://200.200.164.111/01-ISO/Windows/06-win2008/WindowsServer2008_x86.iso
  zyc_log "[iso]Upload win2008-x86 iso success."
fi

if [ ! -f "${PWD}/cn_windows_server_2008_r2_enterprise_sp1_x64.iso" ]
then
  wget -c --ftp-user=vtt --ftp-password=123 ftp://200.200.164.111/01-ISO/Windows/06-win2008/cn_windows_server_2008_r2_enterprise_sp1_x64.iso
  zyc_log "[iso]Upload win2008-x64 iso success."
fi
if [ ! -f "${PWD}/cn_windows_2012_r2_x64__NB4WH-BBBYV-3MPPC-9RCMV-46XCB.iso" ]
then
  wget -c --ftp-user=vtt --ftp-password=123 ftp://200.200.164.111/01-ISO/Windows/07-win2012/cn_windows_2012_r2_x64__NB4WH-BBBYV-3MPPC-9RCMV-46XCB.iso
  zyc_log "[iso]Upload win2012 iso success."
fi

zyc_log "Upload Windows server ISO finish."

exit 0