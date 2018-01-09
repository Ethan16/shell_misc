#!/bin/bash
#Author:zyc;
#name:dice.sh;
#function:random exercise.

PIPS=6
MAX=1000
throw=1   #calculate

one=0
two=0
three=0
four=0
five=0
six=0

#refresh calculate times.
count(){
case "$1" in
0) let "one+=1";;
1) let "two+=1";;
2) let "three+=1";;
3) let "four+=1";;
4) let "five+=1";;
5) let "six+=1";;
esac
}

#count times.
while [ "$throw" -le "$MAX" ]
do
  let "dice=RANDOM % $PIPS"
  count $dice
  let "throw+=1"
done

#print result.
echo "The statistics results are as follows: "
echo "one=$one"
echo "two=$two"
echo "three=$three"
echo "four=$four"
echo "five=$five"
echo "six=$six"
