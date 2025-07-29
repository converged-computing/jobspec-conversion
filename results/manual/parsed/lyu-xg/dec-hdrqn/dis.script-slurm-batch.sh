#!/bin/bash
#SBATCH --job-name=dqn
#SBATCH --output=job.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=1g
#SBATCH --partition=gpu
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=6-19

cd /scratch/lu.xue/dec-hdrqn
srun python main.py --gridx 3 --gridy 3 --n_quant 16  --implicit 1 --likely 1 --distort_type wang --distort_param 0.0  --run_id $SLURM_ARRAY_TASK_ID
