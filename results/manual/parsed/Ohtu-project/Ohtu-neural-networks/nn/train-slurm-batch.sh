#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=train_class.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=100G
#SBATCH --time=7-00:00:00
#SBATCH --partition=gpu

module purge
module load Python cuDNN
source ~/myTensorflow/bin/activate
keras_retinanet/bin/train.py --gpu 2 --epochs 50 --weights /home/barimpac/keras-retinanet/snapshots/resubmit/resnet50_csv_34.h5 --snapshot-path /home/barimpac/keras-retinanet/snapshots/squares/ --steps 1473 csv DT_square_train.csv csv/class_mapping_multi.csv
