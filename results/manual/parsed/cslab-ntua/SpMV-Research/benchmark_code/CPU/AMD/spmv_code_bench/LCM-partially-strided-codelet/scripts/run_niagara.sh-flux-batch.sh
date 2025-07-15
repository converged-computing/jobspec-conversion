#!/bin/bash
#FLUX: --job-name="TRSV"
#FLUX: -c=40
#FLUX: --priority=16

module load NiaEnv/2019b
module load cmake/3.17.3
module load gcc
module load metis/5.1.0
make clean
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j 20
BINPATH=/scratch/m/mmehride/kazem/development/DDT/build/demo/
UFDB=/scratch/m/mmehride/kazem/UFDB/
LOGS=/scratch/m/mmehride/kazem/development/DDT/build/logs/
SCRIPTPATH=/scratch/m/mmehride/kazem/development/DDT/scripts/
bash $SCRIPTPATH/run_exp.sh $BINPATH/spmv_demo $UFDB 3 20 > $LOGS/spmv.csv
