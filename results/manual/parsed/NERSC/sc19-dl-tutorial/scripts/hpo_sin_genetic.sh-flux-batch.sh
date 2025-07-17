#!/bin/bash
#FLUX: --job-name=hpo-sin-genetic
#FLUX: --queue=regular
#FLUX: -t=300
#FLUX: --urgency=16

module load tensorflow/intel-1.13.1-py36
module load cray-hpo
script=genetic_example.py
path=hpo/sin
cd $path && python -u $script
