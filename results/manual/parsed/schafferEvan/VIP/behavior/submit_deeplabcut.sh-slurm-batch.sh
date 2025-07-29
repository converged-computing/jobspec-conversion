#!/bin/bash
#SBATCH --job-name=dlctest0
#SBATCH --output=dlcTest0.out
#SBATCH --error=dlcTest0.err
#SBATCH --mail-user=ess2129@columbia.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

export PATH='/mnt/home/evanschaffer/anaconda3/bin:$PATH'
export PYTHONPATH='/mnt/home/evanschaffer/anaconda3/envs/deeplabcut'

source activate deeplabcut
module load cuda/9.0.176 
module load cudnn/v7.0-cuda-9.0
module load gcc/7.4.0
export PATH=/mnt/home/evanschaffer/anaconda3/bin:$PATH
export PYTHONPATH=/mnt/home/evanschaffer/anaconda3/envs/deeplabcut
conda list
/mnt/home/evanschaffer/anaconda3/envs/deeplabcut/bin/python deeplabcut_train.py
