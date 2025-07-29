#!/bin/bash
#SBATCH --job-name=parallelSlurm
#SBATCH --account=PAA0202
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=28

cd $SLURM_SUBMIT_DIR
module load miniconda3
source activate vak-env
conda install pytorch torchvision cudatoolkit -c pytorch
conda install attrs dask joblib matplotlib pandas scipy toml tqdm
pip install vak
pip install tweetynet
