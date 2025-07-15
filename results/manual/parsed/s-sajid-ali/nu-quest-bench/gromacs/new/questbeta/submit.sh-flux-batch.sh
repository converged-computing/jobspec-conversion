#!/bin/bash
#FLUX: --job-name=test_mpi
#FLUX: -N=2
#FLUX: --queue=normal
#FLUX: -t=7200
#FLUX: --urgency=16

source /home/sas4990/packages/spack/share/spack/setup-env.sh
module purge all
BASE_DIR=$(pwd)
rm -rf questbeta
mkdir questbeta
for i in sfwpwj3
do
    cd $BASE_DIR
    spack load --dependencies /$i
    export OMP_NUM_THREADS=1
    for run in {1..5}
    do
	    srun --mpi=pmi2 gmx_mpi mdrun -s lignocellulose-rf.tpr -maxh 0.5 -resethway -noconfout -nsteps 10000 -g </dev/null &> log_$run
    done
done 
