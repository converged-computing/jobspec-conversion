#!/bin/bash
#FLUX: --job-name=fixids
#FLUX: --queue=bluemoon
#FLUX: -t=108000
#FLUX: --priority=16

pwd; hostname; date
set -e
spack load python@3.7.7
python /gpfs1/home/m/r/mriedel/pace/dsets/code/fix_ids.py
date
