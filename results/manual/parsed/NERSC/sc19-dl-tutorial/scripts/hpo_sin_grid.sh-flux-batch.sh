#!/bin/bash
#FLUX: --job-name=faux-destiny-4862
#FLUX: --urgency=16

module load tensorflow/intel-1.13.1-py36
module load cray-hpo
script=grid_example.py
path=hpo/sin
cd $path && python -u $script
