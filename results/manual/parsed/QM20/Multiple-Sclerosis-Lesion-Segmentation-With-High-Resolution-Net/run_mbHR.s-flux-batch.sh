#!/bin/bash
#FLUX: --job-name=mbHRNet
#FLUX: -c=10
#FLUX: --queue=nvidia
#FLUX: -t=144000
#FLUX: --urgency=16

module purge
module load all
module load cuda/10.0
cd /home/qc690/Video/MS_Lesion_Seg
/home/qc690/anaconda3_3.4.1/bin/python  -u train_mbHRNet.py>log_mbHRNet_samedataset.txt
