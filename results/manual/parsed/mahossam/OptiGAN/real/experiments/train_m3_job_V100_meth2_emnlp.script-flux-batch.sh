#!/bin/bash
#FLUX: --job-name=RelGAN_Job
#FLUX: -c=2
#FLUX: --queue=m3g
#FLUX: -t=259200
#FLUX: --priority=16

nvidia-smi
. /home/mahmoudm/anaconda3/etc/profile.d/conda.sh
conda activate tf_new_py3
pwd
date
python emnlp_small_relgan_meth2.py 0 0
date
