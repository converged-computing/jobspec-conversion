#!/bin/bash
#SBATCH --job-name=pytorch-lightning-demo
#SBATCH --account=ie-idi
#SBATCH --output=pytorch-lightning-demo.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --time=00:30:00
#SBATCH --partition=GPUQ
#SBATCH --constraint=ntasks-per-node=1

cd ${SLURM_SUBMIT_DIR}/
module purge
module load Anaconda3/2023.09-0
conda activate tdt4265
srun python trainer.py
