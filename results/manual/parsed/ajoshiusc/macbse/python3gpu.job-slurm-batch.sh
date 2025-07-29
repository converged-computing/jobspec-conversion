#!/bin/bash
#SBATCH --account=ajoshi_27
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=64GB
#SBATCH --time=23:00:00

eval "$(conda shell.bash hook)"
cd /scratch1/ajoshi/projects/macbse
module load gcc/11.3.0 python/3.9.12 git
ulimit -n 2880
echo "Checking Cuda, GPU USED?"
python -c 'import torch; print(torch.cuda.is_available()); print(torch.cuda.current_device()); print(torch.cuda.get_device_name(0))'
nvidia-smi
echo "Running: python " $1
python $1
