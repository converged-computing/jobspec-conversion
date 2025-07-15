#!/bin/bash
#FLUX: --job-name=msm
#FLUX: -c=5
#FLUX: --queue=swanson-gpu-np
#FLUX: -t=172800
#FLUX: --priority=16

python3 calling_func_v3.py
echo "... Job Finished at `date`"
