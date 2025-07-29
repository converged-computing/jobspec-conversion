#!/bin/bash
#SBATCH --output=./logs/%A.out
#SBATCH --error=./logs/%A.err
#SBATCH --mail-user=akshaykjagadish@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=80G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=gpu

cd ~/ermi/categorisation/
module purge
module load anaconda/3/2021.11
module load gcc/11 impi/2021.6
module load cuda/11.6
module load pytorch_distributed/gpu-cuda-11.6/1.13.0
pip3 install tabpfn xgboost
python benchmark/eval.py 
