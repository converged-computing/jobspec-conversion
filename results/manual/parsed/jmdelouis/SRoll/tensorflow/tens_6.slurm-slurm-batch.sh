#!/bin/bash
#SBATCH --job-name=sroll4
#SBATCH --nodes=6
#SBATCH --ntasks=144
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=118000
#SBATCH --time=00:10:00
#SBATCH --constraint=HSW24,ntasks-per-node=24

export OMP_NUM_THREADS='1'
export MXM_TLS='self,shm,rc'
export TF_XLA_FLAGS='--tf_xla_cpu_global_jit'

cd /scratch/cnt0028/ias1717/SHARED/bware/sroll22_trick/SrollEx/tensorflow
export OMP_NUM_THREADS=1
export MXM_TLS=self,shm,rc
export TF_XLA_FLAGS=--tf_xla_cpu_global_jit
srun --mpi=pmi2 -K1 -n $SLURM_NTASKS --distribution=cyclic ./isroll2.py param545.py &> /scratch/cnt0028/ias1717/SHARED/bware/sroll22_trick/SrollEx/tensorflow/testtens_6.log
exit 0
