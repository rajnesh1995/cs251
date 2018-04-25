#!/bin/bash

read number

printDigit()
{
	case $1 in
	0)	;;
	1)	echo -n "one " ;;
	2)	echo -n "two " ;;
	3)	echo -n "three " ;;
	4)	echo -n "four ";;
	5)	echo -n "five " ;;
	6)	echo -n "six " ;;
	7)	echo -n "seven " ;;
	8)	echo -n "eight " ;;
	9)	echo -n "nine " ;;
	
}

findDigit()		#$1 for number $2 for i
{
	temp=$1
	ii=$2
	if [ii -gt 4]
	then
		((ii%=3))
	fi
	
	if [ii -gt 2]
	then
		digit=((temp%(10^ii)))
		printDigit() $digit
	fi
	
	
}

i=0;
tempNumber=$number
while [tempNumber -gt 0]
do
	((i++))
	((tempNumber/=10))
done

tempNumber=$number
while [tempNumber -gt 0]
do
	if [i -gt 2]
	then
		findDigit() tempNumber i
		findSuffix() i
	else
		
	fi
	
	
	((tempNumber=tempNumber-(tempNumber/10^i)*(10^i)))
	((i--))

done
