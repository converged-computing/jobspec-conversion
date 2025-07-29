#!/bin/bash
#SBATCH --output=out.log
#SBATCH --error=err.log
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu
#SBATCH: --no-requeue

module load nvidia/cuda/10.0
module load pytorch/1.0_python3.7_gpu
python src/ensemble.py \
  --checkpoints checkpoints/pt6_64 checkpoints/pt7_64 checkpoints/pt9_64 checkpoints/pt9_16 checkpoints/pt10_64\
  --output_dir ensemble_results.txt
