#!/bin/bash
#FLUX: --job-name=Iden_matrix_interval_1_train
#FLUX: -n=28
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --urgency=16

module load Anaconda/2-5.0.1
source activate my_tensorflow-gpu-1.4.1
python Identity_Matrix_interval_1.py ../Datasets/Final_Data/unique_fold_train ../Datasets/Intermediate_Data/Identity_matrix_Interval_1/
source deactivate
