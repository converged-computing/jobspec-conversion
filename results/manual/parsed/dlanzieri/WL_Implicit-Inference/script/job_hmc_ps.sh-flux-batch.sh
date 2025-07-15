#!/bin/bash
#FLUX: --job-name=name_of_the_job
#FLUX: -c=20
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

module purge
module load tensorflow-gpu/py3/2.7.0
python hmc_ps.py  
