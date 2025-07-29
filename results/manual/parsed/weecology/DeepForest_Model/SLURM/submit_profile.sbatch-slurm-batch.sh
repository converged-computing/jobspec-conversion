#!/bin/bash
#SBATCH --job-name=Profiler
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/profile.out
#SBATCH --error=/home/b.weinstein/logs/profile.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=6
#SBATCH --mem=20GB
#SBATCH --time=3-00:00:00

export PATH='${PATH}:/home/b.weinstein/miniconda/envs/DeepForest/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepForest/lib/python3.7/site-packages/'

module load tensorflow
export PATH=${PATH}:/home/b.weinstein/miniconda/envs/DeepForest/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepForest/lib/python3.7/site-packages/
cd /home/b.weinstein/DeepForest_Model/Weinstein_unpublished/
python -m cProfile -o train.prof profiler.py
