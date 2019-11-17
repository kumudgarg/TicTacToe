#!/bin/bash -x
row=3
column=3
playPosition=0
for (( i=0; i<$row; i++ ))
do
	for (( j=0; j<$column; j++ ))
	do
		playPosition=$(( playPosition + 1 ))
		board[$i,$j]=$playPosition
	done
done
