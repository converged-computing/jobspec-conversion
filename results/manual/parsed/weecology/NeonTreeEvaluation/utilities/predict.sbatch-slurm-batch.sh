#!/bin/bash
#SBATCH --job-name=predict_crops
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/crops_%j.out
#SBATCH --error=/home/b.weinstein/logs/crops_%j.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=30GB
#SBATCH --time=3-00:00:00

export PATH='${PATH}:/home/b.weinstein/miniconda3/envs/DeepTreeAttention_DeepForest/bin/:/home/b.weinstein/DeepTreeAttention/'
export PYTHONPATH='/home/b.weinstein/miniconda3/envs/DeepTreeAttention_DeepForest/lib/python3.7/site-packages/:/home/b.weinstein/DeepTreeAttention/:${PYTHONPATH}'
export LD_LIBRARY_PATH='/home/b.weinstein/miniconda3/envs/DeepTreeAttention_DeepForest/lib/:${LD_LIBRARY_PATH}'

module load tensorflow/1.14.0
export PATH=${PATH}:/home/b.weinstein/miniconda3/envs/DeepTreeAttention_DeepForest/bin/:/home/b.weinstein/DeepTreeAttention/
export PYTHONPATH=/home/b.weinstein/miniconda3/envs/DeepTreeAttention_DeepForest/lib/python3.7/site-packages/:/home/b.weinstein/DeepTreeAttention/:${PYTHONPATH}
export LD_LIBRARY_PATH=/home/b.weinstein/miniconda3/envs/DeepTreeAttention_DeepForest/lib/:${LD_LIBRARY_PATH}
python predict_crops.py
