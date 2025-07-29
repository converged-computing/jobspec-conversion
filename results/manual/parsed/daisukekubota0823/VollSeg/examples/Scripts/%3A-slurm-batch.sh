#!/bin/bash
#FLUX: --job-name=oneat
#FLUX: -c=48
#FLUX: -t=72000
#FLUX: --urgency=16

module purge # purging modules inherited by default
module load tensorflow-gpu/py3/2.7.0
module load anaconda-py3/2020.11
conda deactivate
conda activate naparienv
set -x # activating echo of
srun python -u TrainProjectionModel.py
