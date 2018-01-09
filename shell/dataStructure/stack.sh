#!/bin/bash

#----------------------------------------
#Purpose：实现栈操作
#Author:zyc
#Time:20160121
#Usage:
#----------------------------------------

MAXTOP=500

TOP=$MAXTOP

TEMP=
declare -a STACK

push(){

if [ -z "$1" ]
then
  return
fi

until [ $# -eq 0 ]
do
  let TOP=TOP-1
  STACK[$TOP]=$1
  shift
done

return

}

pop(){

TEMP=

if [ "$TOP" -eq "$MAXTOP" ]
then
  return
fi

TEMP=${STACK[$TOP]}
unset STACK[$TOP]
let TOP+=1

return
}

status(){
echo "==============================="
echo "           stack               "

for i in ${STACK[@]}
do
  echo $i
done

echo
echo "Stack pointer=$TOP"
echo "Just pop \""$TEMP"\" off the stack."
echo "==============================="
echo

}

#test code.
push lalamm
status
push song lai zhou
status

pop
pop
status
push Knuth
push Ullman Yanchun
status

