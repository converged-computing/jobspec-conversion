#!/bin/bash
#FLUX: --job-name=carnivorous-bike-6152
#FLUX: --priority=16

module load tensorflow/intel-1.13.1-py36
module load cray-hpo
script=grid_example.py
path=hpo/sin
cd $path && python $script
