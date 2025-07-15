#!/bin/bash
#FLUX: --job-name=delicious-buttface-4698
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'
export TOKENIZERS_PARALLELISM='false'

. ~/miniconda3/etc/profile.d/conda.sh
echo "[$1] Activating env...."
. env_activate.sh
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
export TOKENIZERS_PARALLELISM=false
echo "Running script ...."
if [ -z "$2" ]
  then
    echo "New Run"
    guild run -y $1
  else
    echo "Restarting Run [$2]"
    guild run -y $1 --force-sourcecode --restart $2
fi
echo "---------- FINALIZED -------------"
