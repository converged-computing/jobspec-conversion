#!/bin/bash
#SBATCH --job-name=pytorch-gpu-condaenv
#SBATCH --output=job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu
#SBATCH --mem=200G
#SBATCH --time=23:00:00

echo "Running on $(hostname):"
module load Anaconda3
conda create --name pytorchenv
source activate pytorchenv
python -c "import torch; print(torch.cuda.get_device_name(0))"
python3 model1.py
