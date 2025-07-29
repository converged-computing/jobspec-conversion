#!/bin/bash
#SBATCH --mail-user=addankn@sunyit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:2
#SBATCH --time=1-12:30:00
#SBATCH --partition=GPU-shared

export CUDA_VISIBLE_DEVICES='0,1'
export TENSORFLOW_ENV='$TF_ENV'

set -x
export CUDA_VISIBLE_DEVICES=0,1
module load tensorflow/1.5_gpu
module load keras/2.0.4
export TENSORFLOW_ENV=$TF_ENV
source $KERAS_ENV/bin/activate
cd $HOME
cd r2/Retinal-Segmentation
python python/main_model.py --classification 4 --dataset big --cache --activation relu
echo "ALL DONE!"
