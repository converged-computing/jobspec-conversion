#!/bin/bash
#SBATCH --job-name=winograd
#SBATCH --output=ret-%j.err
#SBATCH --error=ret-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --qos=gpu-short
#SBATCH --constraint=Volta

echo "Job start at $(date "+%Y-%m-%d %H:%M:%S")"
echo "Job run at:"
echo "$(hostnamectl)"
source ~/.bashrc
source /tools/module_env.sh
module list                       # list modules loaded by default
module load cmake/3.15.7
module load git/2.17.1
module load vim/8.1.2424
module load gcc/7.5.0
module load python3/3.6.8
conda activate winograd 
module list                      # list modules loaded by default
echo $(module list)              # list modules loaded
echo $(which gcc)
echo $(which python)
echo $(which python3)
nvidia-smi --format=csv --query-gpu=name,driver_version,power.limit
nvprof python network.py
echo "Job end at $(date "+%Y-%m-%d %H:%M:%S")"
