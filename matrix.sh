#!/bin/bash

# This file is a practice to print out a matrix effect in CentOS terminal
# The escape sequences used doesn't work properly on OS terminal
# (research shows OS terminal use different escape rules...)

trap cleanUp EXIT

cleanUp() {
  run=false
  echo -e "\e[0m"
  PS1=$ORIGINAL_PROMPT
  clear
  return 0
}

fillBg() {
  clear
  for i in $(seq 0 $rows)
  do
    echo
    for j in $(seq 0 $cols)
    do
      printf "\e[48;5;232m%s" " "
      #printf "%s" " "
    done
  done
}

runLoop() {
  while [ true ]
  do
    for i in $(seq 0 $(($threadNum-1)))
    do
      #Initilize everything if animation finished
      if [ ${sleepCount[$i]} -eq 0 ] ; then
        if [ ${currHeadRow[$i]} -eq ${headRow[$i]} ] && [ ${tailRow[$i]} -eq ${headRow[$i]} ] ; then
          #echo "init"
          #Sleep random 1 - 21 cycle 
          sleepCount[$i]=$(($RANDOM % (2*$rows)))
          #Column random based on column number
          colIndex[$i]=$(($RANDOM % $cols))
          #currHeadRow random maximum based on row number but 10 grid up
          currHeadRow[$i]=$(( 0 - ($RANDOM % 10) ))
          #headRow random based on currHeadRow
          headRow[$i]=$((($RANDOM % 10) + ($rows-5)))
          #tailRow is the starting position
          tailRow[$i]=$((${currHeadRow[$i]}))

          #echo -n "${currHeadRow[$i]} "
          #echo "${tailRow[$i]} ${currHeadRow[$i]} ${headRow[$i]}"
        elif [ ${currHeadRow[$i]} -eq ${headRow[$i]} ] ; then
          #Tail start moving down
          if [ ${tailRow[$i]} -ge 0 ] ; then
            tput cup ${tailRow[$i]} ${colIndex[$i]}
            echo -en "\e[48;5;232;38;5;0m \e[0m"
          fi
          tailRow[$i]=$((${tailRow[$i]}+1))
        else
          #Head moving down
          #echo "run"
          #echo -n "${currHeadRow[$i]} "
          curr=${currHeadRow[$i]}
          col=$((colIndex[$i]))

          if [ $curr -ge 0 ] && [ $curr -ge $tailRow ] ; then
            tput cup $curr $col
            echo -en "\e[48;5;232;38;5;255m${chars[$(($RANDOM % ${#chars[@]}))]}\e[0m"
          fi
          curr=$(($curr-1))
          if [ $curr -ge 0 ] && [ $curr -ge $tailRow ] ; then
            tput cup $curr $col
            echo -en "\e[48;5;232;38;5;120m${chars[$(($RANDOM % ${#chars[@]}))]}\e[0m"
          fi
          curr=$(($curr-1))
          if [ $curr -ge 0 ] && [ $curr -ge $tailRow ] ; then
            tput cup $curr $col
            echo -en "\e[48;5;232;38;5;47m${chars[$(($RANDOM % ${#chars[@]}))]}\e[0m"
          fi
          curr=$(($curr-1))
          if [ $curr -ge 0 ] && [ $curr -ge $tailRow ] ; then
            tput cup $curr $col
            echo -en "\e[48;5;232;38;5;46m${chars[$(($RANDOM % ${#chars[@]}))]}\e[0m"
          fi
          #Move forward
          currHeadRow[$i]=$((${currHeadRow[$i]}+1))
        fi
      else
        sleepCount[$i]=$((sleepCount[$i] - 1))
      fi      
    done
      
    sleep 0.05
  done
}

ORIGINAL_PROMPT=$PS1
PS1=""
rows=`tput lines`
rows=`expr $rows + 1`
cols=`tput cols`
cols=`expr $cols - 1`
chars=( {a..z} {A..Z} {0..9} \, \. \/ \: \; \- \+ \) \( \! \@ \# \$ \% \^ \& \* \' \" \? )

fillBg

run=true
threadNum=40

colIndex=()
headRow=()
tailRow=()
currHeadRow=()
sleepCount=()

for i in $(seq 0 $(($threadNum-1)))
do
  sleepCount[i]="0"
done

runLoop


