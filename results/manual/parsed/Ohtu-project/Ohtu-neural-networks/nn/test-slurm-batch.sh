#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=test_out.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=1000
#SBATCH --time=00:10:00

module purge
module load Python cuDNN
source ~/myTensorflow/bin/activate
keras_retinanet/bin/evaluate.py --save-path ~/results/squares csv test_annotation_multi.csv csv/class_mapping_multi.csv snapshots/squares/resnet50_csv_50.h5
