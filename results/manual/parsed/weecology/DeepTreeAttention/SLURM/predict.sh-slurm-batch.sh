#!/bin/bash
#SBATCH --job-name=DeepTreeAttention
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/DeepTreeAttention_%j.out
#SBATCH --error=/home/b.weinstein/logs/DeepTreeAttention_%j.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --gres=1
#SBATCH --mem=200GB
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu

ulimit -c 0
source activate DeepTreeAttention
cd ~/DeepTreeAttention/
module load git gcc
python -m cProfile -o nodask_largebatch_8gpu.pstats predict.py
