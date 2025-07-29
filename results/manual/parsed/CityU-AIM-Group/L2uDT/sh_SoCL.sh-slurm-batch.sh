#!/bin/bash
#SBATCH --job-name=SoCL
#SBATCH --output=CVC_SoCL.out
#SBATCH --error=error.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=ntasks-per-node=2
#SBATCH --nodelist=hpc-gpu007

echo "Submitted from:"$SLURM_SUBMIT_DIR" on node:"$SLURM_SUBMIT_HOST
echo "Running on node "$SLURM_JOB_NODELIST 
echo "Allocate Gpu Units:"$CUDA_VISIBLE_DEVICES
source /home/xiaoqiguo2/.bashrc
module load cuda/10.2.89
conda activate torch
cd /home/xiaoqiguo2/L2uDT/experiment/Ours/
python ./train_SoCL.py
