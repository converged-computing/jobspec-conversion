#!/bin/bash
#FLUX: --job-name=gpu_mono
#FLUX: -c=10
#FLUX: -t=216000
#FLUX: --urgency=16

set -x
cd ${SLURM_SUBMIT_DIR}
module purge
module load python/2.7.16
module load tensorflow-gpu/py3/2.0.0-beta1
module load pandas
srun python Main_X.py
