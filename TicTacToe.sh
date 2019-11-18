#!/bin/bash -x
ROW=3
COLUMN=3
playPosition=0
computerSymbol=""
playerSymbol=""
randNum=0
arrLen=$(( $ROW * $COLUMN ))
toss=$(( RANDOM%2 ))
randNum=$(( RANDOM % 2 ))
count=0
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

	for (( k=0; k<arrLen; k++ ))
	do
		displayBoard
      read -p " enter player choice " playerChoice
		for (( i=0; i<$ROW; i++ ))
		do
			for (( j=0; j<$COLUMN; j++ ))
			do
				while [  $((${board[$i,$j]})) -eq $(($playerSymbol)) ]
            do
						echo "Invalid move"
						displayBoard
      				read -p " enter playerSymbol choice " playerChoice
				done
				if [ $((${board[$i,$j]})) -eq $playerChoice ] 
				then
				 	board[$i,$j]=$playerSymbol 
				fi
			done
      done
	done
}
resetBoard
symbolAssign
playTicTacToe
displayBoard
