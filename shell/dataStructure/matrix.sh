#!/bin/bash

#----------------------------------------
#Purpose：实现二维数组操作
#Author:zyc
#Time:20160130
#Usage:
#----------------------------------------

ROW=5
COL=5
declare -a MATRIX

load_alpha(){
local rc=0
local index

for i in A B C D E F G H I J K L M N O P Q R S T U V W X Y
do
  local row=`expr $rc / $COL`
  local colum=`expr $rc % $ROW`
  let "index=$row * $ROW + $colum"
  alpha[$index]=$i
  let "rc+=1"
done
}

print_alpha(){
local row=0
local index

echo

while [ "$row" -lt "$ROW" ]
do
  local colum=0
  echo -n "      "
  
  while [ "$colum" -lt "$COL" ]
  do
    let "index=$row * $ROW + $colum"
	echo -n "${alpha[index]}"
	let "colum+=1"
  done
  
  let "row+=1"
  echo
done

echo
}

