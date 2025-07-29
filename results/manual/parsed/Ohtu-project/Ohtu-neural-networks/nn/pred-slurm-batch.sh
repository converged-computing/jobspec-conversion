#!/bin/bash
#FLUX: --job-name=pred
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=345600
#FLUX: --urgency=16

module purge
module load Python cuDNN
source ~/myTensorflow/bin/activate
python Predictions_ukko.py snapshots/resnet50_csv_50_13april2018.h5 Acrorad_1704-0601-8/Acrorad_1704-0601-8/Measurement_1/RAW/ Acrorad_1704-0601-8/predictions testi.csv
