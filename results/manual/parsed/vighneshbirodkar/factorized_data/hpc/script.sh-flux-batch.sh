#!/bin/bash
#FLUX: --job-name=$JOB_NAME
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --priority=16

USER_NAME=$(whoami)
echo "Starting script.sh"
echo "Username = $USER_NAME"
echo "Command = $COMMAND"
module load mesa/intel/17.0.2
module load python3/intel/3.5.3
module load ffmpeg/intel
cd /scratch/$USER_NAME/code/factorized_data
eval "$COMMAND"
