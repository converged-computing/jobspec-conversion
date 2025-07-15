#!/bin/bash
#FLUX: --job-name=test_mpi
#FLUX: -N=2
#FLUX: --queue=normal
#FLUX: -t=7200
#FLUX: --priority=16

source /home/sas4990/packages/spack/share/spack/setup-env.sh
module purge all
BASE_DIR=$(pwd)
rm -rf questbeta
mkdir questbeta
for i in syxhn6t
do
    cd $BASE_DIR
    spack load --dependencies /$i
    export OMP_NUM_THREADS=1
    cd questbeta
    cp $BASE_DIR/in.lj .
    for run in {1..20}
    do
	    srun --mpi=pmi2 lmp -in in.lj  </dev/null &> log_$run
    done
done 
