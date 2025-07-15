#!/bin/bash
#FLUX: --job-name=2c_mccd_train
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load tensorflow-gpu/py3/2.4.1
set -x
cd $WORK/repo/wf-psf/jz-submissions/slurm-logs/
srun python ./../scripts/training_mccd_200.py
