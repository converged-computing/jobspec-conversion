#!/bin/bash
#SBATCH --job-name=no_spillover
#SBATCH --output=eta_output_file.o
#SBATCH --error=eta_error_file.e
#SBATCH --nodes=25
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=16:00:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=36,mc

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
for i in $(seq 0 5 50)
do
   srun python3 ./eta_mpi.py $i
done
