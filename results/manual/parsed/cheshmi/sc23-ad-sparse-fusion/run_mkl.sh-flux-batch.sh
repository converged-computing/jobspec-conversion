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
   bash $SCRIPTPATH/run_exp.sh  "$BINPATH/mkl_mv_trsv"  "$UFDB" 1 $THRD $MATLIST > $LOGS/spmv_sptrsv_mkl.csv
   bash $SCRIPTPATH/run_exp.sh  "$BINPATH/mkl_trsv_mv"  "$UFDB" 1 $THRD $MATLIST > $LOGS/sptrsv_spmv_mkl.csv
   bash $SCRIPTPATH/run_exp.sh  "$BINPATH/mkl_trsv_trsv"  "$UFDB" 1 $THRD $MATLIST > $LOGS/sptrsv_sptrsv_mkl.csv
   bash $SCRIPTPATH/run_exp.sh  "$BINPATH/mkl_demo" "$UFDB" 1 $THRD $MATLIST > $LOGS/spilu0_sptrsv_mkl.csv
   bash $SCRIPTPATH/run_exp.sh  "$BINPATH/mkl_dad_spilu0_demo" "$UFDB" 1 $THRD $MATLIST > $LOGS/scal_spilu0_mkl.csv
   bash $SCRIPTPATH/run_exp.sh  "$BINPATH/mkl_trsv" "$UFDB" 1 $THRD $MATLIST > $LOGS/sptrsv_mkl.csv
   bash $SCRIPTPATH/run_exp.sh  "$BINPATH/mkl_mv_mv" "$UFDB" 1 $THRD $MATLIST > $LOGS/spmv_spmv_mkl.csv
