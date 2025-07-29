#!/bin/bash
#SBATCH --output=slurm_output/slurm-%j.out
#SBATCH --error=slurm_output/slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --constraint=ntasks-per-node=16

export SLURM_CPU_BIND='none'

cd $HOME/verne/
module load pre2019
module unload GCCcore
module load Python/2.7.12-intel-2016b
module load slurm-tools
export SLURM_CPU_BIND=none
time mpirun -np 16 python2.7 RunMPI_verne.py -target MOD -index $1
