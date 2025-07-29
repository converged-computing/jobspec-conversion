#!/bin/bash
#SBATCH --job-name=TESTTENSORFLOW
#SBATCH --account=training2206
#SBATCH --output=output.out
#SBATCH --error=error.er
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=4

export CUDA_VISIBLE_DEVICES='0,1,2,3'

ml Stages/2022
ml CUDA/11.5
ml cuDNN/8.3.1.22-CUDA-11.5
export CUDA_VISIBLE_DEVICES="0,1,2,3"
echo "Starting training"
source /p/project/training2206/<username>/pixel-detector/.venv/bin/activate
srun python code/train.py
echo "DONE"
