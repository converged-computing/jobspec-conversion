#!/bin/bash
#FLUX: --job-name=new_exp
#FLUX: --priority=16

cd ..
singularity exec -B /om:/om --nv /om/user/nprasad/singularity/belledon-tensorflow-keras-master-latest.simg \
python /om/user/nprasad/angel-pfizer/eval_final.py
