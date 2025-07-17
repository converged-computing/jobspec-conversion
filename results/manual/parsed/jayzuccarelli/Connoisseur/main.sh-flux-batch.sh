#!/bin/bash
#FLUX: --job-name=connoisseur
#FLUX: -c=16
#FLUX: --queue=sched_mit_sloan_gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load python/3.6.3
module load sloan/python/modules/python-3.6/tensorflow/1.9.0/gpu
python3.6 main.py
