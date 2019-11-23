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
			counter=3
			computerSymbol="0"
         checkCornerOrCenterOrAnywhere
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
		checkCornerOrCenterOrAnywhere
      if[ $isCornerEmpty == true ]
      then
             isCornerEmpty=false
             continue
      fi 
	   checkWinAndLooseComputerMove $computerSymbol
		checkWinAndLoose
		conclusion
			if [ $valid == true ]
	   		then
	         		return 0
	    		fi
		checkWinAndLooseComputerMove $playerSymbol

	done
		displayBoard
	 	echo "game Tie"
}
function ischeckWinAndLooseResult()
{
	symbol=$1
	if [ ${board[0,0]} == $symbol ]  && [ ${board[0,1]} == $symbol ] && [ ${board[0,2]} == $symbol ]
	then
		if [ $symbol == $playerSymbol ]
		then
			playerWinning=true
		else
			computerWinning=true
		fi
	 elif [ ${board[1,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[1,2]} == $symbol ]
    then
		if [ $symbol == $playerSymbol ]
		then
   		playerWinning=true
		else
   		computerWinning=true
		fi
	 elif [ ${board[2,0]} == $symbol ] && [ ${board[2,1]} == $symbol ] && [ ${board[2,2]} == $symbol ]
    then
		 if [ $symbol == $playerSymbol ]
      	then
         	playerWinning=true
      	else
         	computerWinning=true
		 fi
	 elif [ ${board[0,0]} == $symbol ] && [ ${board[1,0]} == $symbol ] && [ ${board[2,0]} == $symbol ]
    then
 		if [ $symbol == $playerSymbol ]
		then
   		playerWinning=true
		else
   		computerWinning=true
      fi       
	 elif [ ${board[0,1]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,1]} == $symbol ]
    then
      if [ $symbol == $playerSymbol ]
      then
         	playerWinning=true
      else
         	computerWinning=true
      fi	
	 elif [ ${board[0,2]} == $symbol ] && [ ${board[1,2]} == $symbol ] && [ ${board[2,2]} == $symbol ]
    then
	 	if [ $symbol == $playerSymbol ]
     	then
	 		playerWinning=true
	 	else
			computerWinning=true
	 	fi
    elif [ ${board[0,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,2]} == $symbol ]
    then
	   if [ $symbol == $playerSymbol ]
	   then
	      	playerWinning=true
	  	  else
	      	computerWinning=true
		fi
	 elif [ ${board[0,2]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,0]} == $symbol ]
    then
    	if [ $symbol == $playerSymbol ]
	   then
	   	playerWinning=true
	   else
	   	computerWinning=true
		fi       
	fi
}
function checkWinAndLooseComputerMove()
{
   local row=0
   local col=0
   local sign=$1
	#<----------------row wise checkWinAndLoose------------------------------------------------------------->  
 for (( row=0; row<$ROW; row++ ))
   do
      if [ ${board[$row,$col]} == $sign ] && [ ${board[$row,$(( $col + 1 ))]} == $sign ]
      then
         board[$row,$(( $col + 2 ))]=$computerSymbol
      elif [ ${board[$row,$(( $col + 1 ))]} == $sign ] && [ ${board[$row,$(( $col + 2 ))]} == $sign ]
      then
         board[$row,$col]=$computerSymbol
      elif [ ${board[$row,$col]} == $sign ] && [ ${board[$row,$(( $col + 2 ))]} == $sign ]
      then
         board[$row,$(( $col + 1 ))]=$computerSymbol
      fi
   done
	#<--------------------column wise checkWinAndLoose--------------------------------------------------------->
	row=0
   for (( col=0; col<$COLUMN; col++ ))
   do
      if [ ${board[$row,$col]} == $sign ] && [ ${board[$(( $row+1 )),$col]} == $sign ]
      then
         board[$(( $row+2 )),$col]=$computerSymbol
      elif [ ${board[$row,$col]} == $sign ] && [ ${board[$(($row+2)),$col]} == $sign ]
      then
         board[$(($row+1)),$col]=$computerSymbol
      elif [ ${board[$(($row+1)),$col]} == $sign ] && [ ${board[$(($row+2)),$col]} == $sign ]
      then
         board[$row,$col]=$computerSymbol
      fi
   done
	#<-----------------------------Diagonally checkWinAndLoose------------------------------------------------------>
   col=0
   if [ ${board[$row,$col]} == $sign ] && [ ${board[$(( $row+1 )),$(( $col+1 ))]} == $sign ]
   then
      board[$(( $row+2 )),$(( $col+2 ))]=$computerSymbol
   elif [ ${board[$row,$col]} == $sign ] && [ ${board[$(($row+2)),$(($col+2))]} == $sign ]
   then
      board[$(($row+1)),$(($col+1))]=$computerSymbol
   elif [ ${board[$(($row+1)),$(($col+1))]} == $sign ] && [ ${board[$(($row+2)),$(($col+2))]} == $sign ]
	then
      board[$row,$col]=$computerSymbol
   elif [ ${board[$row,$(($col+2))]} == $sign ] && [ ${board[$(($row+1)),$(($col+1))]} == $sign ]
   then
      board[$(($row+2)),$col]=$computerSymbol
   elif [ ${board[$row,$(($col+2))]} == $sign ] && [ ${board[$(($row+2)),$col]} == $sign ]
   then
      board[$(($row+1)),$(($col+1))]=$computerSymbol
   elif [ ${board[$(($row+2)),$col]} == $sign ] && [ ${board[$(($row+1)),$(($col+1))]} == $sign ]
   then
      board[$row,$(($col+2))]=$computerSymbol
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
function conclusion()
{
	if [ $playerWinning == true ]
   then
	   displayBoard
	   echo "you are won"
	   valid=true
	elif [ $computerWinning == true ]
   then
   	displayBoard
     	echo "you are loose"
      valid=true
	fi 
}
function checkWinAndLoose()
{
	i=1
   while [ $i -le 2 ]
   do
      if [ $i == 1 ]
      then
      $(ischeckWinAndLooseResult $playerSymbol $computerSymbol)
      elif [ $i == 2 ]
      then
          $(ischeckWinAndLooseResult $computerSymbol $playerSymbol)
      fi
      (( i++ ))
   done
}
function checkCornerOrCenterOrAnywhere()
{
     if [ ${board[0,0]} != $playerSymbol ] && [ ${board[0,0]} != $computerSymbol ]
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
     fi
     elif [ ${board[1,1]} != $playerSymbol ] && [ ${board[1,1]} != $computerSymbol ]
     then
        board[2,2]=$computerSymbol
        isCornerEmpty=true
     elif [ ${board[0,1]} != $playerSymbol ] && [ ${board[0,1]} != $computerSymbol ]
     then
        board[0,1]=$computerSymbol
        isCornerEmpty=true
     fi
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
}
resetBoard
playTicTacToe
