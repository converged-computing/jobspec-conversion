#!/bin/bash
#SBATCH --job-name=BBPip
#SBATCH --output=mulitple_jobs_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-300

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
mpirun -np $SLURM_NTASKS python main.py $1
