#!/bin/bash

# This script is used for testing my executable against given tester
MY_EXE=$1
REF_EXE=$2

# Input, argument, output files specification
MY_OUT=~/Desktop/my_out
REF_OUT=~/Desktop/ref_out
ARG_FILE=~/Desktop/args
INPT_FILE=~/Desktop/input

# Clean both files
rm -f ${MY_OUT}
rm -f ${REF_OUT}

# Create new files
touch ${MY_OUT}
touch ${REF_OUT}

# Test cases
while IFS= read -r line
do
  $MY_EXE $line >> ${MY_OUT} 2>&1 < ${INPT_FILE}
  $REF_EXE $line >> ${REF_OUT} 2>&1 < ${INPT_FILE}
  #echo "$MY_EXE $line"
done < $ARG_FILE

# Vim diff between the two
vimdiff $MY_OUT $REF_OUT
