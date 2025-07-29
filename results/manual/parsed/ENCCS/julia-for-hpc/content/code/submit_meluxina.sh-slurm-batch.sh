#!/bin/bash
#SBATCH --account=p200051
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=8

module load OpenMPI
module load Julia
n=$SLURM_NTASKS
srun -n $n julia estimate_pi.jl         
