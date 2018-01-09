#!/bin/bash

#----------------------------------------
#Purpose：提取监控数据并存入test数据库的resource表中
#Author:zyc
#Time:20160121
#Usage:
#----------------------------------------


sed '1,/<CLUSTER/d' gmond_msg.txt > machine_record

MYSQL=`which mysql`
record="recording each line."

#while循环为脚本的主体部分。利用read命令逐行读取machine_record的每一行处理
while [ -n "$record" ]
do

read record
first_field=`echo $record | cut -d" " -f1`

if [ "$first_field" = "<HOST" ]
then
  echo "Processing HOST and IP."
  index=0
  VAR[$index]=`echo $record | cut -d" " -f2 | sed -e 's/^.*=\"//' -e 's/\"//'`    #用替换来处理删除，习惯不好，符号都要配对打出来！！！
  let "index+=1"
  
  VAR[$index]=`echo $record | cut -d" " -f3 | sed -e 's/^.*=\"//' -e 's/\"//'`
  echo ${VAR[$index]}
  
  let "index+=1"
  
elif [ "$first_field" = "<METRIC" ]
then
  VAR[$index]=`echo $record | cut -d" " -f3 | sed -e 's/^.*=\"//' -e 's/\"//'`
  let "index+=1"
  
elif [ "$first_field" = "</HOST>" ]
then
  echo "Writing into database."
  statement="insert into resource values ("
  
  for j in ${VAR[@]}
  do
    statement=$statement\'$j\',  
  done
  
  statement=${statement%,}\)\;
  echo $statement
  
  $MYSQL test -u root -padmin123. <<EOF
  $statement
EOF
fi

done < machine_record
