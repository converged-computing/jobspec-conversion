#!/bin/bash
#SBATCH --job-name=DeepForest
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/DeepForest.out
#SBATCH --error=/home/b.weinstein/logs/DeepForest.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=gpu:tesla:1
#SBATCH --mem=10GB
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

export PYTHONPATH='/apps/geos/3.6.2/lib/python3.6/site-packages:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.6/site-packages/'

ml git
ml tensorflow/1.10.1
ml geos/3.6.2
export PYTHONPATH=/apps/geos/3.6.2/lib/python3.6/site-packages:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.6/site-packages/
echo $PYTHONPATH
cd /home/b.weinstein/DeepForest
python train.py --mode train
