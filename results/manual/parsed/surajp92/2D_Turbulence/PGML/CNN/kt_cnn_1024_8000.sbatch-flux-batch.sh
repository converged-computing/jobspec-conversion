#!/bin/bash
#FLUX: --job-name=kt_cnn_1024_128_8000
#FLUX: --urgency=16

module load cuda
module load anaconda3/2020.07
python DHIT_CNN_apriori_sgs_TF2.py 
