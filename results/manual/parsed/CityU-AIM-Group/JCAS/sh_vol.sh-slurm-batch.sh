#!/bin/bash
#SBATCH --job-name=Polyp
#SBATCH --output=log/VolMin/Noise_ellipse.out
#SBATCH --error=error.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --nodelist=node5

echo "Submitted from:"$SLURM_SUBMIT_DIR" on node:"$SLURM_SUBMIT_HOST
echo "Running on node "$SLURM_JOB_NODELIST 
echo "Allocate Gpu Units:"$CUDA_VISIBLE_DEVICES
source /home/xiaoqiguo2/.bashrc
conda activate torch020
cd /home/xiaoqiguo2/Class2affinity/tools_ablation/
python ./VolMin.py
