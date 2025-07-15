#!/bin/bash
#FLUX: --job-name=ISBI_HR_aug
#FLUX: -c=12
#FLUX: -t=144000
#FLUX: --priority=16

module purge
module load all
module load cuda/10.0
source activate py362
cd /scratch/lw1474/qiming/Video/MS_Lesion_seg
python  -u train_HRNet_ISBI.py --save_dir="./results_HRNet_ISBI">>Log/log_HRNet_ISBI_aug_tmp.txt
