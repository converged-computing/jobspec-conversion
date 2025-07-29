#!/bin/bash
#SBATCH --job-name=DeepForest
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/DeepForest_%j.out
#SBATCH --error=/home/b.weinstein/logs/DeepForest_%j.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=1
#SBATCH --mem=30GB
#SBATCH --time=3-00:00:00

export PATH='${PATH}:/home/b.weinstein/miniconda/envs/DeepForest/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepForest/lib/python3.7/site-packages/'

module load tensorflow/1.14.0
export PATH=${PATH}:/home/b.weinstein/miniconda/envs/DeepForest/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepForest/lib/python3.7/site-packages/
cd /home/b.weinstein/DeepForest_Model/Weinstein_unpublished/
python compare.py
