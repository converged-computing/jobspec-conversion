#!/bin/bash
#FLUX: --job-name=Julia_test
#FLUX: --queue=shortq
#FLUX: --urgency=16

export WORK_DIR='/data/$USER/Julia_${SLURM_JOB_ID}'
export INPUT_DIR='$PWD/input'

 module load Julia/1.5.1-linux-x86_64
export WORK_DIR=/data/$USER/Julia_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR   
cd $WORK_DIR
echo "Running code on $WORK_DIR"
julia myscript.jl
echo "Done"
