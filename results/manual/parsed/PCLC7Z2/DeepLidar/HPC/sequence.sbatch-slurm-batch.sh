#!/bin/bash
#SBATCH --job-name=retrain_sequence
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/retrain_sequence.out
#SBATCH --error=/home/b.weinstein/logs/retrain_sequence.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:tesla:1
#SBATCH --mem=20GB
#SBATCH --time=2-00:00:00

export PATH='${PATH}:/home/b.weinstein/miniconda/envs/DeepLidar/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepLidar/lib/python3.6/site-packages/'

ml git
ml gcc
ml geos
ml tensorflow
export PATH=${PATH}:/home/b.weinstein/miniconda/envs/DeepLidar/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepLidar/lib/python3.6/site-packages/
cd /home/b.weinstein/DeepLidar
python retrain_sequence.py
cat analysis/pretraining_size.csv
