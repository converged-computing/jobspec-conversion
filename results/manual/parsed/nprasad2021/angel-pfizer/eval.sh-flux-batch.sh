#!/bin/bash
#FLUX: --job-name=new_exp
#FLUX: -n=4
#FLUX: -t=10800
#FLUX: --urgency=16

cd ..
singularity exec -B /om:/om --nv /om/user/nprasad/singularity/belledon-tensorflow-keras-master-latest.simg \
python /om/user/nprasad/angel-pfizer/eval_final.py
