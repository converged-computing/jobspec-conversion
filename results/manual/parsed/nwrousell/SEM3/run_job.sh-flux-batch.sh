#!/bin/bash
#FLUX: --job-name=sticky-mango-8507
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

export APPTAINER_BINDPATH='/oscar/home/$USER,/oscar/scratch/$USER,/oscar/data'
export PYTHONUNBUFFERED='TRUE'

module purge
unset LD_LIBRARY_PATH
cd src
export APPTAINER_BINDPATH="/oscar/home/$USER,/oscar/scratch/$USER,/oscar/data"
export PYTHONUNBUFFERED=TRUE
srun apptainer exec --nv ../tensorflow-24.03-tf2-py3.simg python -m main --train --seed 3 --name $SLURM_JOB_NAME
