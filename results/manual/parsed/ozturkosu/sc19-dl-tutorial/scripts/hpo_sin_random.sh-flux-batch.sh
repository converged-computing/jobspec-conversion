#!/bin/bash
#FLUX: --job-name=dirty-cinnamonbun-1218
#FLUX: --urgency=16

module load tensorflow/intel-1.13.1-py36
module load cray-hpo
script=random_example.py
path=hpo/sin
cd $path && python $script
