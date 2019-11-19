#!/bin/bash -x
#<------Constants------------------->
ROW=3
COLUMN=3
ARRAYLEN=$(( $ROW * $COLUMN ))
#<---------Variables----------------->
playPosition=0
computerSymbol=""
playerSymbol=""
randNum=0
toss=$(( RANDOM%2 ))
randNum=$(( RANDOM % 2 ))
row=0
column=0
declare -A board
function resetBoard()
{
	for (( i=0; i<$ROW; i++ ))
	do
		for (( j=0; j<$COLUMN; j++ ))
		do
			count=$(( $count + 1 ))
			board[$i,$j]=$count
		done
	done
}
function symbolAssign()
{
	if [ $randNum -eq 0 ]
	then
		computerSymbol="0"
		playerSymbol="x"
		echo $computerSymbol $playerSymbol
	else 
		computerSymbol="x"
		playerSymbol="0"
		 echo $computerSymbol $playerSymbol
	fi
}
function whoPlayFirst()
{
	if [ $toss -eq 0 ]
	then
			echo "computerSymbol will play first"
			computerSymbol="0"
      	playerSymbol="x"
	else
			echo "playerSymbol will play first"
			computerSymbol="x"
      	playerSymbol="0"

	fi
}
function displayBoard()
{
	count=0
	for (( i=0; i<$ROW; i++ ))
   do
      for (( j=0; j<$COLUMN; j++ ))
      do 
				echo -n "|   ${board[$i,$j]}    | "
		done
			printf "\n"
			echo  -n " ------   ------   ------ "
			printf "\n"
	done
}
function playTicTacToe()
{
 whoPlayFirst
 for (( k=0; k<$ARRAYLEN; k++ ))
 do
	displayBoard
	read -p " enter player choice " playerChoice
	row=$(( $playerChoice / $ROW ))
	if [ $(( $playerChoice % $ROW )) -eq 0 ]
	then
		row=$(( $row - 1 ))
	fi 
	column=$(( $playerChoice %  $COLUMN ))
	if [ $column -eq 0 ]
	then
	column=$(( $column + 2 ))
	else
		column=$(( $column - 1 ))
	fi
	if [ ${board[$row,$column]} -eq $playerSymbol ]
	then
		echo "Invalid move"
		(( k-- ))
	fi
	board[$row,$column]=$playerSymbol
 done
}
 
resetBoard
symbolAssign
playTicTacToe
