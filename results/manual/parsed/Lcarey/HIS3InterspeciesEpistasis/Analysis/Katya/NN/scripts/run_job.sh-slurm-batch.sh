#!/bin/bash
#SBATCH --job-name=R2_calculations
#SBATCH --output=r2_log_hist
#SBATCH --mail-user=ekaterina.putintseva@ist.ac.at
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=gpu:1
#SBATCH --mem=5G
#SBATCH --time=1-12:00:00
#SBATCH --no-requeue
#SBATCH --array=0-4

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

unset SLURM_EXPORT_ENV
module load tensorflow/python-2.7/1.3.0 
/usr/bin/nvidia-smi
echo $SLURM_ARRAY_TASK_ID
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun --cpu_bind=verbose python ./rebuttal_NN.py -f $SLURM_ARRAY_TASK_ID
