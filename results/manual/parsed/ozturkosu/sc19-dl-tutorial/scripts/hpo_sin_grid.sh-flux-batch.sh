#!/bin/bash
#FLUX: --job-name=hpo-sin-grid
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

module load tensorflow/intel-1.13.1-py36
module load cray-hpo
script=grid_example.py
path=hpo/sin
cd $path && python $script
