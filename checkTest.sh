#!/bin/bash

MY_EXE=$1
REF_EXE=$2

MY_OUT=~/Desktop/my_out
REF_OUT=~/Desktop/ref_out
ARG_FILE=~/Desktop/args

rm -f ${MY_OUT}
rm -f ${REF_OUT}

touch ${MY_OUT}
touch ${REF_OUT}

while IFS= read -r line
do
  $MY_EXE $line >> ${MY_OUT} 2>&1
  $REF_EXE $line >> ${REF_OUT} 2>&1
  # echo $line
done < $ARG_FILE

vimdiff $MY_OUT $REF_OUT
