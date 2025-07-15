#!/bin/bash
#FLUX: --job-name=evasive-pancake-3481
#FLUX: -N=6
#FLUX: -n=144
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export MXM_TLS='self,shm,rc'
export TF_XLA_FLAGS='--tf_xla_cpu_global_jit'

cd /scratch/cnt0028/ias1717/SHARED/bware/sroll22_trick/SrollEx/tensorflow
export OMP_NUM_THREADS=1
export MXM_TLS=self,shm,rc
export TF_XLA_FLAGS=--tf_xla_cpu_global_jit
srun --mpi=pmi2 -K1 -n $SLURM_NTASKS --distribution=cyclic ./isroll2.py param545.py &> /scratch/cnt0028/ias1717/SHARED/bware/sroll22_trick/SrollEx/tensorflow/testtens_6.log
exit 0
