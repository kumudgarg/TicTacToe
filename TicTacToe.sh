#!/bin/bash -x
#<------Constants------------------->
ROW=3
COLUMN=3
ARRAYLEN=$(( $ROW * $COLUMN ))
#<---------Variables----------------->
playerChoice=0
computerSymbol=""
playerSymbol=""
randNum=0
toss=$(( RANDOM%2 ))
randNum=$(( RANDOM % 2 ))
playerWinning=false
computerWinning=false
counter=0
valid=false
isCornerEmpty=false
checkCondition=false
turn=0
declare -A board
function resetBoard()
{
	for (( row=0; row<$ROW; row++ ))
	do
		for (( col=0; col<$COLUMN; col++ ))
		do
			count=$(( $count + 1 ))
			board[$row,$col]=$count
		done
	done
}
function whoPlayFirst()
{
	if [ $toss -eq 0 ]
	then		
		echo "computerSymbol will play first"
		computerSymbol="0"
		playerSymbol="x"
		turn=0
	else
		echo "playerSymbol will play first"
		computerSymbol="x"
      		playerSymbol="0"
		turn=1

	fi
}
function displayBoard()
{
	
	for (( row=0; row<$ROW; row++ ))
   	do
      		for (( col=0; col<$COLUMN; col++ ))
      		do 
			echo -n "|   ${board[$row,$col]}    | "
		done
			printf "\n"
			echo  -n " ------   ------   ------ "
			printf "\n"
	done
}
function playTicTacToe()
{
	whoPlayFirst 
 	local row=0
 	local column=0
 	for (( count=0; count<$ARRAYLEN; count++ ))
 	do
		if [ $turn == 0 ]
		then
			ischeckWinAndLooseResult $computerSymbol
			if [ $valid == true ]
			then
				displayBoard
				echo "you are loose"
				exit
			fi
			checkWinAndLooseComputerMove $computerSymbol
			if [ $isCellBlocked == true ]
	                then
				isCellBlocked=false
			else
				 checkCornerOrCenterOrAnywhere
			fi
			turn=1
			ischeckWinAndLooseResult $computerSymbol
                        if [ $valid == true ]
                        then
				displayBoard
				echo "you are loose"
                                exit
                        fi

		else
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
			if [ $((${board[$row,$column]})) -eq $(($playerSymbol)) ] && [ ${board[$row,$column]} == $computerSymbol ]
			then
				echo "Invalid move"
				(( count-- ))
				continue
			fi
			board[$row,$column]=$playerSymbol
			turn=0
			ischeckWinAndLooseResult $playerSymbol
 			if [ $valid == true ]
 			then
         			echo "you are loose"
         			exit
 			fi
		fi
	done
	displayBoard
	echo "game Tie"
}
function ischeckWinAndLooseResult()
{
	symbol=$1
	if [ ${board[0,0]} == $symbol ]  && [ ${board[0,1]} == $symbol ] && [ ${board[0,2]} == $symbol ]
	then
		valid=true
	 elif [ ${board[1,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[1,2]} == $symbol ]
    	 then
		valid=true
	 elif [ ${board[2,0]} == $symbol ] && [ ${board[2,1]} == $symbol ] && [ ${board[2,2]} == $symbol ]
    	 then
		valid=true
	 elif [ ${board[0,0]} == $symbol ] && [ ${board[1,0]} == $symbol ] && [ ${board[2,0]} == $symbol ]
	 then
		valid=true       
 	elif [ ${board[0,1]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,1]} == $symbol ]
    	then
      		valid=true
 	elif [ ${board[0,2]} == $symbol ] && [ ${board[1,2]} == $symbol ] && [ ${board[2,2]} == $symbol ]
	then
 		valid=true
    	elif [ ${board[0,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,2]} == $symbol ]
    	then
		valid=true
	elif [ ${board[0,2]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,0]} == $symbol ]
    	then
    		
		valid=true
	else
		valid=false
	fi
}
function checkWinAndLooseComputerMove()
{
	local row=0
	local col=0
	#<----------------row wise checkWinAndLoose------------------------------------------------------------->  
	for (( row=0; row<$ROW; row++ ))
	do
	if [ ${board[$row,$col]} == $playerSymbol ] && [ ${board[$row,$(( $col + 1 ))]} == $playerSymbol ]
	then
		board[$row,$(( $col + 2 ))]=$computerSymbol
		isCellBlocked=true
	elif [ ${board[$row,$(( $col + 1 ))]} == $playerSymbol ] && [ ${board[$row,$(( $col + 2 ))]} == $playerSymbol ]
	then
		board[$row,$col]=$computerSymbol
		isCellBlocked=true
	elif [ ${board[$row,$col]} == $playerSymbol ] && [ ${board[$row,$(( $col + 2 ))]} == $playerSymbol ]
	then
		board[$row,$(( $col + 1 ))]=$computerSymbol
		isCellBlocked=true
	fi
	done
	#<--------------------column wise checkWinAndLoose--------------------------------------------------------->
	row=0
	for (( col=0; col<$ROW; col++ ))
   	do
      		if [ ${board[$row,$col]} == $playerSymbol ] && [ ${board[$(( $row+1 )),$col]} == $playerSymbol ]
      		then
			board[$(( $row+2 )),$col]=$computerSymbol
			isCellBlocked=true
      		elif [ ${board[$row,$col]} == $playerSymbol ] && [ ${board[$(($row+2)),$col]} == $playerSymbol ]
      		then
			board[$(($row+1)),$col]=$computerSymbol
			isCellBlocked=true
		elif [ ${board[$(($row+1)),$col]} == $playerSymbol ] && [ ${board[$(($row+2)),$col]} == $playerSymbol ]
	      	then
			board[$row,$col]=$computerSymbol
			isCellBlocked=true
     		fi
   	done
	#<-----------------------------Diagonally checkWinAndLoose------------------------------------------------------>
	col=0
	if [ ${board[$row,$col]} == $playerSymbol ] && [ ${board[$(( $row+1 )),$(( $col+1 ))]} == $playerSymbol ]
	then
		board[$(( $row+2 )),$(( $col+2 ))]=$computerSymbol
		isCellBlocked=true
	elif [ ${board[$row,$col]} == $playerSymbol ] && [ ${board[$(($row+2)),$(($col+2))]} == $playerSymbol ]
	then
		board[$(($row+1)),$(($col+1))]=$computerSymbol
		isCellBlocked=true
	elif [ ${board[$(($row+1)),$(($col+1))]} == $playerSymbol ] && [ ${board[$(($row+2)),$(($col+2))]} ==  $playerSymbol ]
	then
		board[$row,$col]=$computerSymbol
		isCellBlocked=true
	elif [ ${board[$row,$(($col+2))]} == $playerSymbol ] && [ ${board[$(($row+1)),$(($col+1))]} == $playerSymbol ]
	then
		board[$(($row+2)),$col]=$computerSymbol
		isCellBlocked=true
	elif [ ${board[$row,$(($col+2))]} == $playerSymbol ] && [ ${board[$(($row+2)),$col]} == $playerSymbol ]
	then
		board[$(($row+1)),$(($col+1))]=$computerSymbol
		isCellBlocked=true
	elif [ ${board[$(($row+2)),$col]} == $playerSymbol ] && [ ${board[$(($row+1)),$(($col+1))]} == $playerSymbol ]
	then
		board[$row,$(($col+2))]=$computerSymbol
		isCellBlocked=true
	else
		isCellBlocked=false

	fi
}
function checkCornerOrCenterOrAnywhere()
{
	if [[ ${board[0,0]} != $playerSymbol ]] && [[ ${board[0,0]} != $computerSymbol ]]
	then
		board[0,0]=$computerSymbol
		isCornerEmpty=true
	elif [ ${board[0,2]} != $playerSymbol ] && [ ${board[0,2]} != $computerSymbol ]
	then
		board[0,2]=$computerSymbol
		isCornerEmpty=true
	elif [ ${board[2,0]} != $playerSymbol ] && [ ${board[2,0]} != $computerSymbol ]
	then
		board[2,0]=$computerSymbol
		isCornerEmpty=true
	elif [ ${board[2,2]} != $playerSymbol ] && [ ${board[2,2]} != $computerSymbol ]
	then
		board[2,2]=$computerSymbol
		isCornerEmpty=true
	elif [ ${board[1,1]} != $playerSymbol ] && [ ${board[1,1]} != $computerSymbol ]
	then
		board[2,2]=$computerSymbol
		isCornerEmpty=true
	elif [ ${board[0,1]} != $playerSymbol ] && [ ${board[0,1]} != $computerSymbol ]
	then
		board[0,1]=$computerSymbol
		isCornerEmpty=true
	elif [ ${board[2,0]} != $playerSymbol ] && [ ${board[2,0]} != $computerSymbol ]
	then
		board[2,0]=$computerSymbol
		isCornerEmpty=true
	elif [ ${board[2,2]} != $playerSymbol ] && [ ${board[2,2]} != $computerSymbol ]
	then
		board[2,2]=$computerSymbol
		isCornerEmpty=true
	elif [ ${board[3,1]} != $playerSymbol ] && [ ${board[3,1]} != $computerSymbol ]
	then
		board[3,1]=$computerSymbol
		isCornerEmpty=true
	fi
}
resetBoard
playTicTacToe
