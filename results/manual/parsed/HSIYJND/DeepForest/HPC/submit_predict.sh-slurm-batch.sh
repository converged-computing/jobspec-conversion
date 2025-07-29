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
ml geos/3.6.2
ml tensorflow/1.10.1
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.6/site-packages/
echo $PYTHONPATH
cd /home/b.weinstein/DeepForest
python predict.py --model /orange/ewhite/b.weinstein/retinanet/snapshots/20181022_120303/resnet50_14.h5 --image /orange/ewhite/NeonData/SJER/DP3.30010.001/2018/FullSite/D17/2018_SJER_3/L3/Camera/Mosaic/V01/2018_SJER_3_255000_4106000_image.tif
