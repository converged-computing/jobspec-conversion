#!/bin/bash
#FLUX: --job-name=buttery-peanut-2316
#FLUX: --urgency=16

module load tensorflow/intel-1.13.1-py36
module load cray-hpo
script=genetic_example.py
path=hpo/sin
cd $path && python -u $script
