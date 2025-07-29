#!/bin/bash
#SBATCH --job-name=compute_ZINB
#SBATCH --mail-user=pravich2@jhu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:2
#SBATCH --time=12:00:00
#SBATCH --partition=gpup100
#SBATCH --constraint=ntasks-per-node=6

module load cuda/9.0
module load python/3.6-anaconda
conda activate tensorflow_gpu_env
python -u ../src/run_ZINB.py --cell-type $1 --n-genes 200 --learning-rate 0.0001 --train-epochs 100000 | tee ../log/compute_ZINB/$1_200_0.0001_100000.log 
