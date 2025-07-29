#!/bin/bash
#SBATCH --job-name=Anchors
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/anchors.out
#SBATCH --error=/home/b.weinstein/logs/anchors.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=25GB
#SBATCH --time=3-00:00:00

export PATH='${PATH}:/home/b.weinstein/miniconda3/envs/DeepForest/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.7/site-packages/'
export LD_LIBRARY_PATH='/home/b.weinstein/miniconda3/envs/crowns/lib/:${LD_LIBRARY_PATH}'

module load tensorflow/1.14.0
export PATH=${PATH}:/home/b.weinstein/miniconda3/envs/DeepForest/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/DeepForest/lib/python3.7/site-packages/
export LD_LIBRARY_PATH=/home/b.weinstein/miniconda3/envs/crowns/lib/:${LD_LIBRARY_PATH}
cd /home/b.weinstein/DeepForest_Model/
python GenerateAnchors.py
