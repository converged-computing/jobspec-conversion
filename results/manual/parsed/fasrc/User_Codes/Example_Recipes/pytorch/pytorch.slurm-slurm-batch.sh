#!/bin/bash
#SBATCH --output=pytorch_%j.out
#SBATCH --error=pytorch_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --time=00:00:30
#SBATCH --partition=gpu

module load Anaconda3/5.0.1-fasrc02
module load cuda/10.0.130-fasrc01 cudnn/7.4.1.5_cuda10.0-fasrc01
source activate pytorch_3
python examples/mnist/main.py
