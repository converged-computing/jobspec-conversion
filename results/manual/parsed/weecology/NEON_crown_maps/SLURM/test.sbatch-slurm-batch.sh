#!/bin/bash
#SBATCH --job-name=dask-worker
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/dask-worker-%j.out
#SBATCH --error=/home/b.weinstein/logs/dask-worker-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=19G
#SBATCH --time=1-00:00:00

export PATH='${PATH}:/home/b.weinstein/miniconda/envs/crowns/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda/envs/crowns/lib/python3.7/site-packages/'

module load tensorflow/1.14.0
export PATH=${PATH}:/home/b.weinstein/miniconda/envs/crowns/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda/envs/crowns/lib/python3.7/site-packages/
cd /home/b.weinstein/NEON_crown_maps/
python available.py
