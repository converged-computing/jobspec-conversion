#!/bin/bash
#FLUX: --job-name=PELE
#FLUX: -n=5
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load anaconda
module load intel impi mkl boost cmake transfer bsc
eval "$(conda shell.bash hook)"
conda activate /gpfs/projects/bsc72/conda_envs/platform/1.6.3
python -m AdaptivePELE.adaptiveSampling adaptive.conf
