#!/bin/bash
#FLUX: --job-name=goodbye-bike-6913
#FLUX: -n=8
#FLUX: -t=1209600
#FLUX: --urgency=16

SAVEIFS=$IFS   # Save current IFS
IFS=$'\n'      # Change IFS to new line
myList=('14A'
'14C'
'21D'
'23A')
filename=${myList[${SLURM_ARRAY_TASK_ID}]}
pathoscope ID -alignFile results_"$filename"/"$filename".sam -fileType sam -outDir results_"$filename" -expTag "$filename"
$IFS=$SAVEIFS
