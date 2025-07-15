#!/bin/bash
#FLUX: --job-name=ISBI_UNet
#FLUX: -c=12
#FLUX: -t=144000
#FLUX: --priority=16

module purge
module load all
module load cuda/10.0
source activate py362
cd /scratch/qc690/Video/MS_Lesion_seg
python  -u train_UNet_ISBI.py>Log/log_UNet_ISBI.txt
