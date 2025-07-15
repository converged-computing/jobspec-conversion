#!/bin/bash
#FLUX: --job-name=tart-cat-5080
#FLUX: -t=300
#FLUX: --urgency=16

if [ -z "$1" ]; then
    echo "Usage: $0 <number>"
    exit 1
fi
iter=$(printf "%04d" $1)
id=$SLURM_ARRAY_TASK_ID
output_dir="${iter}/deltaProcess/sys${id}"
cd $output_dir || exit
echo "current directory is $(pwd)"
python ../../../pybash/jdftxoutToXYZstep1.py iter_${iter}_sys$id.xyz
