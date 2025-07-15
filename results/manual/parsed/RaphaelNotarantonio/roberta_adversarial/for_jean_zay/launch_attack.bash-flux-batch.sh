#!/bin/bash
#FLUX: --job-name=pgd
#FLUX: -c=10
#FLUX: -t=10800
#FLUX: --urgency=16

cd ${SLURM_SUBMIT_DIR}
module purge
module load pytorch-gpu/py3/1.6.0
srun python ./attack.py   
