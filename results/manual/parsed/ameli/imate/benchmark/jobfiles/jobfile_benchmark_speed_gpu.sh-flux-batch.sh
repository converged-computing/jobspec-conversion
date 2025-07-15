#!/bin/bash
#FLUX: --job-name=benchmark_gpu
#FLUX: -c=8
#FLUX: --queue=savio2_1080ti
#FLUX: -t=345600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

PYTHON_DIR=$HOME/programs/miniconda3
SCRIPTS_DIR=$(dirname $PWD)/scripts
LOG_DIR=$PWD
module load cuda/11.2
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
$PYTHON_DIR/bin/python ${SCRIPTS_DIR}/benchmark_speed.py -g > ${LOG_DIR}/stream_output_gpu.txt
