#!/bin/bash
#SBATCH --job-name=DeepForest_cpu
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/DeepForest_cpu.out
#SBATCH --error=/home/b.weinstein/logs/DeepForest_cpu.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=5GB
#SBATCH --time=1-00:00:00

export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.6/site-packages/'

ml git
ml gcc
ml gdal
ml tensorflow/1.7.0
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.6/site-packages/
echo $PYTHONPATH
cd /home/b.weinstein/DeepForest
python train.py
