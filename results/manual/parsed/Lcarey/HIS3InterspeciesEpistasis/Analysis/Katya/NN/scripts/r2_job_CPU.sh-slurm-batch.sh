#!/bin/bash
#SBATCH --job-name=R2_calculations
#SBATCH --output=r2_log_hist
#SBATCH --mail-user=ekaterina.putintseva@ist.ac.at
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=5G
#SBATCH --time=1-12:00:00
#SBATCH --constraint=edrIB1
#SBATCH --no-requeue
#SBATCH --array=1-12

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

unset SLURM_EXPORT_ENV
module load tensorflow/python-2.7/1.4.0-avx
echo $SLURM_ARRAY_TASK_ID
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun --cpu_bind=verbose python ./network.py -c S$SLURM_ARRAY_TASK_ID -n 75
