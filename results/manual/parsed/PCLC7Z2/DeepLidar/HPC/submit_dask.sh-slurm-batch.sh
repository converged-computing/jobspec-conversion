#!/bin/bash
#SBATCH --job-name=Dask_Generation
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/Dask.out
#SBATCH --error=/home/b.weinstein/logs/Dask.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5GB
#SBATCH --time=2-00:00:00

export PATH='${PATH}:/home/b.weinstein/miniconda/envs/DeepLidar/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepLidar/lib/python3.6/site-packages/'

ml gcc
ml git
ml geos
ml tensorflow
export PATH=${PATH}:/home/b.weinstein/miniconda/envs/DeepLidar/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda/envs/DeepLidar/lib/python3.6/site-packages/
sleep 2
python /home/b.weinstein/DeepLidar/dask_generate.py
