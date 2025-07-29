#!/bin/bash
#SBATCH --account=<project_id>
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --time=01:00:00
#SBATCH --constraint=epyc-7513,ntasks-per-node=64

module purge
module load julia/1.10.2
module load gcc/12.3.0
module load openmpi/4.1.6
ulimit -s unlimited
srun --mpi=pmix_v2 -n $SLURM_NTASKS julia mpi.jl
