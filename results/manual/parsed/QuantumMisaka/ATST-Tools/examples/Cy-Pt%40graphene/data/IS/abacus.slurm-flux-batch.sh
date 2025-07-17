#!/bin/bash
#FLUX: --job-name=IS
#FLUX: -n=64
#FLUX: --queue=amd41
#FLUX: --urgency=16

export OMP_NUM_THREADS='4'

module load abacus/3.4.1-icc
export OMP_NUM_THREADS=4
NP=`expr $SLURM_NTASKS / $OMP_NUM_THREADS`
touch JobProcessing.state
echo `date` >> JobProcessing.state 
mpirun -np $NP abacus
echo `date` >> $HOME/finish
echo `pwd` >> $HOME/finish
echo `date` >> JobProcessing.state
