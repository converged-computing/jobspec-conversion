#!/bin/bash
#SBATCH --job-name=collect_dat
#SBATCH --output=collect_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50gb
#SBATCH --time=00:40:00
#SBATCH --partition=cca
#SBATCH --array=1-3

module load  gcc/7.4.0 cuda/10.1.243_418.87.00 cudnn/v7.6.2-cuda-10.1 nccl/2.4.2-cuda-10.1 python3/3.7.3
source ~/anaconda3/bin/activate tf_gpu
python3 make_h5.py $SLURM_ARRAY_TASK_ID /mnt/home/tmakinen/repositories/deep21/configs/
