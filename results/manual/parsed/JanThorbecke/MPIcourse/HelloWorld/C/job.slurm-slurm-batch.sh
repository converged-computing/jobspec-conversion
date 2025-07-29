#!/bin/bash
#SBATCH --job-name=hello-mpi
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:00:09
#SBATCH --exclusive

echo $SLURM_JOB_NODELIST
sleep 10 
srun --mpi=pmix -n $SLURM_NTASKS ./hello_world
