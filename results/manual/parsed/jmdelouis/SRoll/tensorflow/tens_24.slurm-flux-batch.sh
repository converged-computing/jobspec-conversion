#!/bin/bash
#FLUX: --job-name=scruptious-muffin-2526
#FLUX: -N=24
#FLUX: -n=576
#FLUX: -t=3600
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export MXM_TLS='self,shm,rc'
export TF_XLA_FLAGS='--tf_xla_cpu_global_jit'

cd /scratch/cnt0028/ias1717/SHARED/bware/sroll22_trick/SrollEx/tensorflow
export OMP_NUM_THREADS=1
export MXM_TLS=self,shm,rc
export TF_XLA_FLAGS=--tf_xla_cpu_global_jit
srun --mpi=pmi2 -K1 -n $SLURM_NTASKS --distribution=cyclic ./isroll.py param545.py &> /scratch/cnt0028/ias1717/SHARED/bware/sroll22_trick/SrollEx/tensorflow/testtens_24.log
exit 0
