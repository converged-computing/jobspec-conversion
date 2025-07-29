#!/bin/bash
#SBATCH --job-name=d21_analysis
#SBATCH --output=nu_avg_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=250gb
#SBATCH --time=09:00:00
#SBATCH --partition=cca
#SBATCH --array=1-5

module load  gcc/7.4.0 cuda/10.1.243_418.87.00 cudnn/v7.6.2-cuda-10.1 nccl/2.4.2-cuda-10.1 python3/3.7.3
source ~/anaconda3/bin/activate tf_gpu
python3 analysis.py $SLURM_ARRAY_TASK_ID
