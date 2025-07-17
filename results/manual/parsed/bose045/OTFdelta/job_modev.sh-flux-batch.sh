#!/bin/bash
#FLUX: --job-name=NNmd
#FLUX: --queue=npl-2024
#FLUX: -t=900
#FLUX: --urgency=16

if [ -z "$1" ]; then
    echo "Usage: $0 <number>"
    exit 1
fi
iter=$(printf "%04d" $1)
id=$SLURM_ARRAY_TASK_ID
output_dir="${iter}/NNmd/sys${id}"
cd "$output_dir" || exit
curdir=$(pwd)
echo "Current directory: $curdir"
python ../../../pybash/modelDev.py ${id}
