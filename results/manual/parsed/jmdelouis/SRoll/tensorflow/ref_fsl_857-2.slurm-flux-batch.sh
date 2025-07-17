#!/bin/bash
#FLUX: --job-name=857_2
#FLUX: -N=10
#FLUX: -n=240
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export MXM_TLS='self,shm,rc'
export TF_XLA_FLAGS='--tf_xla_cpu_global_jit'

cd /scratch/cnt0028/ias1717/SHARED/bware/sroll22_trick/SrollEx/tensorflow
export OMP_NUM_THREADS=1
export MXM_TLS=self,shm,rc
export TF_XLA_FLAGS=--tf_xla_cpu_global_jit
numproc=240
rstep=1
outlog=/scratch/cnt0028/ias1717/SHARED/bware/sroll22_trick/SrollEx/tensorflow/
srun --mpi=pmi2 -K1 -n ${numproc} --distribution=cyclic ./SRoll4.py param545_ONE.py --data --rstep ${rstep} --bolo '857-2' --nocnn &> ${outlog}/ref_fsl_857-2.log
exit 0
