#!/bin/bash -x
row=3
column=3
playPosition=0
computer=''
player=''
randNum=0
function resetBoard()
{
	for (( i=0; i<$row; i++ ))
	do
		for (( j=0; j<$column; j++ ))
		do
			playPosition=$(( playPosition + 1 ))
			board[$i,$j]=$playPosition
		done
	done
}
function symbolAssign
{
	randNum=$(( Random % 2 ))
	if [ $randNum -eq 0 ]
	then
		computer='0'
		player='x'
		echo $computer $player
	else 
		computer='x'
		player='0'
		 echo $computer $player
	fi
}
resetBoard
symbolAssign
