#!/bin/bash
#FLUX: --job-name=grated-cattywampus-1215
#FLUX: --priority=16

module load tensorflow/intel-1.13.1-py36
module load cray-hpo
script=random_example.py
path=hpo/sin
cd $path && python $script
