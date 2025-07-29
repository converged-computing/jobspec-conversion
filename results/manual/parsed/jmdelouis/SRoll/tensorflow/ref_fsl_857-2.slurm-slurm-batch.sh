#!/bin/bash
#SBATCH --job-name=857_2
#SBATCH --nodes=10
#SBATCH --ntasks=240
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=118000
#SBATCH --time=00:30:00
#SBATCH --constraint=HSW24,ntasks-per-node=24

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
