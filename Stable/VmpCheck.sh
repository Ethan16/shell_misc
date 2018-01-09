#!/bin/bash

# 检查是否有core
echo "# 检查是否有core" >> check.log
/sf/debug/sfd_clu_hosts_do.sh "source /.PATH; test -d /sf/data/local/dump && ls -lt /sf/data/local/dump || echo 'no cores'" >> check.log
sleep 1
/sf/debug/sfd_clu_hosts_do.sh 1 >> check.log 
# 看堆栈
echo "# 看堆栈" >> check.log
/sf/debug/sfd_clu_hosts_do.sh "test -d /sf/log/bugreport  && ls -lt /sf/log/bugreport || echo 'no bugreport'" >> check.log

# 判断是否有宕机
echo "# 判断是否有宕机" >> check.log
/sf/debug/sfd_clu_hosts_do.sh "test -d /sf/data/local/kdump && ls -lt /sf/data/local/kdump || echo 'no crash kdump'" >> check.log

# 判断是否有异常状态的进程
echo "# 判断是否有异常状态的进程" >> check.log
/sf/debug/sfd_clu_hosts_do.sh "ps aux|awk '{if(\$8==\"X\"||\$8==\"T\"||\$8==\"Z\"||\$8==\"D\") {flag=1;print}}END{if(flag==0)print \"Process is running normally\"}'"  >> check.log 

# 判断是否Sdog下是否有异常日志
echo "# 判断是否Sdog下是否有异常日志" >> check.log
/sf/debug/sfd_clu_hosts_do.sh "test -d /sf/log/today/sdog && cat /sf/log/today/sdog/rlog.txt || echo 'no rlog.txt'" >> check.log
