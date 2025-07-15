#!/bin/bash
#FLUX: --job-name=anxious-butter-2233
#FLUX: -c=12
#FLUX: --queue=anything
#FLUX: -t=86400
#FLUX: --urgency=16

module load nvidia/cuda/11.3
python setup.py build_ext --inplace
python rsd.py -c configs/rsd/$1.yaml -n $2
