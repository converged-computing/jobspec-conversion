#!/bin/bash
#SBATCH --job-name={batch_name}
#SBATCH --output={save_path}/out
#SBATCH --error={save_path}/err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=10000
#SBATCH --time=08:00:00

export CUDA_VISIBLE_DEVICES='0'

cd /gpfs/home/jastrs01/cooperative_optimization
source /gpfs/home/jastrs01/cooperative_optimization/e_bigpurple.sh
export CUDA_VISIBLE_DEVICES=0
{job}
