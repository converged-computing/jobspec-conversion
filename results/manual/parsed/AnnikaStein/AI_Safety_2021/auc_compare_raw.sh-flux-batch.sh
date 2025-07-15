#!/bin/bash
#FLUX: --job-name=0_raw_101-120
#FLUX: -n=2
#FLUX: -c=2
#FLUX: -t=39000
#FLUX: --urgency=16

cd /home/um106329/aisafety
source ~/miniconda3/bin/activate
conda activate my-env
python3 auc_compare_raw.py "[101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120]" 0
