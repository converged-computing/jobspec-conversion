#!/bin/bash
#FLUX: --job-name=fusion
#FLUX: --queue=skx-normal
#FLUX: -t=39605
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
bash $SCRIPTPATH/run_exp.sh "${BINPATH}/flop_counter_demo" $UFDB 8 $THRD $MATLIST > $LOGS/flop_counts.csv
bash $SCRIPTPATH/run_exp.sh "${BINPATH}/sptrsv_sptrsv_demo" $UFDB 1 $THRD $MATLIST > $LOGS/sptrsv_sptrsv.csv
bash ${SCRIPTPATH}/run_exp.sh "${BINPATH}/sptrsv_spmv_demo" $UFDB 1 $THRD $MATLIST > $LOGS/sptrsv_spmv.csv
bash $SCRIPTPATH/run_exp.sh "${BINPATH}/spmv_sptrsv_demo" $UFDB 1 $THRD $MATLIST > $LOGS/spmv_sptrsv.csv
bash $SCRIPTPATH/run_exp.sh "${BINPATH}/scal_spilu_demo" $UFDB 1 $THRD $MATLIST > $LOGS/scal_spilu0.csv
bash $SCRIPTPATH/run_exp.sh "${BINPATH}/spilu_sptrsv_demo" $UFDB 1 $THRD $MATLIST > $LOGS/spilu0_sptrsv.csv
bash $SCRIPTPATH/run_exp.sh "${BINPATH}/scal_spic0_demo" $UFDB 1 $THRD $MATLIST > $LOGS/scal_spic0.csv
bash $SCRIPTPATH/run_exp.sh "${BINPATH}/spic0_sptrsv_demo" $UFDB 1 $THRD $MATLIST > $LOGS/spic0_sptrsv.csv
bash $SCRIPTPATH/run_exp.sh "${BINPATH}/spmv_spmv_demo" $UFDB 1 $THRD $MATLIST > $LOGS/spmv_spmv_static.csv
