#!/bin/bash
#FLUX: --job-name=adv1dsycl
#FLUX: --exclusive
#FLUX: --queue=gpua100
#FLUX: -t=7140
#FLUX: --priority=16

NB_RUNS=10
EXECUTABLE=$1
LOG_PATH=$2
OUT_FILENAME=$3
INI_FILE=$4
PREFIX=$5
module load cuda/11.7.0/gcc-11.2.0 cmake/3.21.4/gcc-11.2.0 gcc/11.2.0/gcc-4.8.5
./script/run.sh $EXECUTABLE $INI_FILE $LOG_PATH $NB_RUNS $PREFIX
./script/parse.sh $LOG_PATH $OUT_FILENAME $PREFIX
