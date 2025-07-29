#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=48

pwd
module restore PrgEnv-cray
module load cray-mvapich2_nogpu_svealpha
module load slurm
spack load hpcc@develop fft=internal %cce ^mvapich2 ^cray-libsci
EXE=${EXE:-$(which hpcc)}
srun $EXE 
