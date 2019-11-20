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
valid=false
counter=0
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
	then		row=$(( RANDOM%$ROW ))
                	col=$(( RANDOM%$COLUMN ))
			echo "computerSymbol will play first"
			counter=4
			computerSymbol="0"
			board[$row,$col]=$computerSymbol
			playerSymbol="x"
	else
			echo "playerSymbol will play first"
			counter=4
			computerSymbol="x"
      			playerSymbol="0"

	fi
}
function displayBoard()
{
	count=0
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
 for (( turn=0; turn<$counter; turn++ ))
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
	if [ $((${board[$row,$column]})) -eq $(($playerSymbol)) ]
	then
		echo "Invalid move"
		(( turn-- ))
	fi
	board[$row,$column]=$playerSymbol
	checkComputerMove
	isCheckResult
	if [ $valid == true ]
        then
		displayBoard
                echo "you are won"
                return 0
         fi 
 done
	  displayBoard
	 echo "game Tie"
}
function isCheckResult()
{
	if [ ${board[0,0]} == $playerSymbol ] && [ ${board[0,1]} == $playerSymbol ] && [ ${board[0,2]} == $playerSymbol ]
	then
		valid=true
	elif [ ${board[1,0]} == $playerSymbol ] && [ ${board[1,1]} == $playerSymbol ] && [ ${board[1,2]} == $playerSymbol ]
        then
                valid=true
	elif [ ${board[2,0]} == $playerSymbol ] && [ ${board[2,1]} == $playerSymbol ] && [ ${board[2,2]} == $playerSymbol ]
        then
		  valid=true
	elif [ ${board[0,0]} == $playerSymbol ] && [ ${board[1,0]} == $playerSymbol ] && [ ${board[2,0]} == $playerSymbol ]
        then
                 valid=true
	elif [ ${board[0,1]} == $playerSymbol ] && [ ${board[1,1]} == $playerSymbol ] && [ ${board[2,1]} == $playerSymbol ]
        then
                 valid=true
	elif [ ${board[0,2]} == $playerSymbol ] && [ ${board[1,2]} == $playerSymbol ] && [ ${board[2,2]} == $playerSymbol ]
        then
		 valid=true
        elif [ ${board[0,0]} == $playerSymbol ] && [ ${board[1,1]} == $playerSymbol ] && [ ${board[2,2]} == $playerSymbol ]
        then
              valid=true
	elif [ ${board[0,2]} == $playerSymbol ] && [ ${board[1,1]} == $playerSymbol ] && [ ${board[2,0]} == $playerSymbol ]
        then
                valid=true
	fi
}
function checkComputerMove()
{
   local row=0
   local col=0
	#<----------------row wise check------------------------------------------------------------->
   for (( row=0; row<$ROW; row++ ))
   do
      if [ ${board[$row,$col]} == $playerSymbol ] && [ ${board[$row,$(( $col + 1 ))]} == $playerSymbol ]
      then
         board[$row,$(( $col + 2 ))]=$computerSymbol
      elif [ ${board[$row,$(( $col + 1 ))]} == $playerSymbol ] && [ ${board[$row,$(( $col + 2 ))]} == $playerSymbol ]
      then
         board[$row,$col]=$computerSymbol
      elif [ ${board[$row,$col]} == $playerSymbol ] && [ ${board[$row,$(( $col + 2 ))]} == $playerSymbol ]
      then
         board[$row,$(( $col + 1 ))]=$computerSymbol
      fi
   done
	#<--------------------column wise check--------------------------------------------------------->
	row=0
   for (( col=0; col<$COLUMN; col++ ))
   do
      if [ ${board[$row,$col]} == $playerSymbol ] && [ ${board[$(( $row+1 )),$col]} == $playerSymbol ]
      then
         board[$(( $row+2 )),$col]=$computerSymbol
      elif [ ${board[$row,$col]} == $playerSymbol ] && [ ${board[$(($row+2)),$col]} == $playerSymbol ]
      then
         board[$(($row+1)),$col]=$computerSymbol
      elif [ ${board[$(($row+1)),$col]} == $playerSymbol ] && [ ${board[$(($row+2)),$col]} == $playerSymbol ]
      then
         board[$row,$col]=$computerSymbol
      fi
   done
	#<-----------------------------Diagonally check------------------------------------------------------>
   col=0
   if [ ${board[$row,$col]} == $playerSymbol ] && [ ${board[$(( $row+1 )),$(( $col+1 ))]} == $playerSymbol ]
   then
      board[$(( $row+2 )),$(( $col+2 ))]=$computerSymbol
   elif [ ${board[$row,$col]} == $playerSymbol ] && [ ${board[$(($row+2)),$(($col+2))]} == $playerSymbol ]
   then
      board[$(($row+1)),$(($col+1))]=$computerSymbol
   elif [ ${board[$(($row+1)),$(($col+1))]} == $playerSymbol ] && [ ${board[$(($row+2)),$(($col+2))]} == $playerSymbol ]
	then
      board[$row,$col]=$computerSymbol
   elif [ ${board[$row,$(($col+2))]} == $playerSymbol ] && [ ${board[$(($row+1)),$(($col+1))]} == $playerSymbol ]
   then
      board[$(($row+2)),$col]=$computerSymbol
   elif [ ${board[$row,$(($col+2))]} == $playerSymbol ] && [ ${board[$(($row+2)),$col]} == $playerSymbol ]
   then
      board[$(($row+1)),$(($col+1))]=$computerSymbol
   elif [ ${board[$(($row+2)),$col]} == $playerSymbol ] && [ ${board[$(($row+1)),$(($col+1))]} == $playerSymbol ]
   then
      board[$row,$(($col+2))]=$computerSymbol
   else
	while [ true ]
	do
		row=$(( RANDOM%$ROW ))
		col=$(( RANDOM%$COLUMN ))
		if [ ${board[$row,$col]} == $playerSymbol ] || [ ${board[$row,$col]} == $computerSymbol ]
		then
			echo "cell occupied"
			continue
		else
			board[$row,$col]=$computerSymbol
			break
		fi
		 if [ isFilledCell ]
                then
                        echo "check"
                        break
                fi

	done		
   fi
}
function isFilledCell()
{
	num=0
	for (( i=0; i<$ROW; i++ ))
	do
		for (( j=0; j<$COLUMN; j++ ))
		do
			 if [ ${board[$i,$j]} == $playerSymbol ] || [ ${board[$i,$j]} == $computerSymbol ]
                	 then
				num=$(( $num+1 ))
			 fi
		done
	done
	if [ $num == 9 ]
	then
		echo true
	else
		echo false
	fi
}

resetBoard
symbolAssign
playTicTacToe
