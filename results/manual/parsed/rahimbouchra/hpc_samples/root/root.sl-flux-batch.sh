#!/bin/bash
#FLUX: --job-name=blue-snack-0671
#FLUX: --queue=shortq
#FLUX: --priority=16

export WORK_DIR='/data/$USER/root_$SLURM_JOB_ID'
export INPUT_DIR='$PWD/hist/'

module load root/gcc/64/6.16.00
module load cmake/gcc/64
export WORK_DIR=/data/$USER/root_$SLURM_JOB_ID
export INPUT_DIR=$PWD/hist/
mkdir -p $WORK_DIR
cp -r $INPUT_DIR $WORK_DIR
echo "Running root in $WORK_DIR"
cd $WORK_DIR
root -b -q hsum.C
echo "Done"
