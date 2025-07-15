#!/bin/bash
#FLUX: --job-name=ex08cl
#FLUX: -c=10
#FLUX: --queue=pascal-deep.p
#FLUX: -t=1209600
#FLUX: --priority=16

module load CUDA/11.1.1-GCC-10.2.0
. /home/fatimamh/anaconda3/etc/profile.d/conda.sh
conda activate hipo_new
python /hits/basement/nlp/fatimamh/codes/HipoRank-master/exp8_c_run.py 
