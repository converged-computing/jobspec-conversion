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

export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.6/site-packages/'

ml git
ml gcc
ml gdal
ml tensorflow/1.7.0
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.6/site-packages/
echo $PYTHONPATH
cd /home/b.weinstein/DeepForest
python eval.py --score-threshold 0.75 --save-path snapshots/images/ onthefly data/training/detection.csv /orange/ewhite/b.weinstein/retinanet/snapshots/resnet50_onthefly_24.h5 --convert-model
