#!/bin/bash
#FLUX: --job-name=PGML
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

if [ -d "model-final" ]
then
    scancel $SLURM_ARRAY_JOB_ID
else
    module load Python/3.7.6-intel-2019a
    mpirun python -u main.py resume_latest 
fi
