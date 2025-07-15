#!/bin/bash
#FLUX: --job-name=dirty-bicycle-8445
#FLUX: --priority=16

export OMP_NUM_THREADS='16'

module load abacus/3.4.1-icc
export OMP_NUM_THREADS=16
NP=`expr $SLURM_NTASKS / $OMP_NUM_THREADS`
touch JobProcessing.state
echo `date` >> JobProcessing.state 
mpirun -np $NP abacus
echo `date` >> $HOME/finish
echo `pwd` >> $HOME/finish
echo `date` >> JobProcessing.state
