#!/bin/bash
#SBATCH --job-name=pred
#SBATCH --output=pred_out.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=1000
#SBATCH --time=4-00:00:00

module purge
module load Python cuDNN
source ~/myTensorflow/bin/activate
python Predictions_ukko.py snapshots/resnet50_csv_50_13april2018.h5 Acrorad_1704-0601-8/Acrorad_1704-0601-8/Measurement_1/RAW/ Acrorad_1704-0601-8/predictions testi.csv
