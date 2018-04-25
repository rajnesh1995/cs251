#!/bin/bash

chmod 0777 ./prog
chmod 0777 common.h
chmod 0777 thread_function.c
chmod 0777 prog.c
read -a threads < threads.txt
read -a params < params.txt

threadcount=${#threads[@]}

paramcount=${#params[@]}
i=0
j=0
while [ $j -lt $paramcount ]
do
i=0
	while [ $i -lt $threadcount ]
	do
	k=0
		while [ $k -lt 100 ]
		do
		printf "%d %d " ${threads[i]} ${params[j]} >> output.txt
		./prog ${params[$j]} ${threads[$i]} | awk '{print $4}' >> output.txt
		((k++))
		done 
	((i++))
	done
((j++))
done





