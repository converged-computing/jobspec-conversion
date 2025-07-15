#!/bin/bash
#FLUX: --job-name=lovable-cherry-5348
#FLUX: -c=12
#FLUX: --queue=anything
#FLUX: -t=86400
#FLUX: --priority=16

module load nvidia/cuda/11.3
python setup.py build_ext --inplace
python rsd.py -c configs/rsd/$1.yaml -n $2
