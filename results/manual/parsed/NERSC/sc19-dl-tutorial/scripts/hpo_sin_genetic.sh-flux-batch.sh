#!/bin/bash
#FLUX: --job-name=joyous-taco-5392
#FLUX: --priority=16

module load tensorflow/intel-1.13.1-py36
module load cray-hpo
script=genetic_example.py
path=hpo/sin
cd $path && python -u $script
