#!/bin/bash
#FLUX: --job-name=fusion
#FLUX: --urgency=16

export OMP_NUM_THREADS='20'

BINPATH="singularity exec --env LD_LIBRARY_PATH=/opt/intel/oneapi/mkl/latest/lib/intel64 artifact.sif /source/fusion/build/demo/"
LOGS=./logs/ 
SCRIPTPATH=./
UFDB=./mm/
LOGS=./logs/
MATLIST=./spd_list.txt
THRD=20
NUM_THREAD=20
export OMP_NUM_THREADS=20
mkdir $LOGS
bash $SCRIPTPATH/run_exp.sh "${BINPATH}/k_kernel_demo" $UFDB 1 $THRD $MATLIST > $LOGS/k_kernel_gs4.csv
