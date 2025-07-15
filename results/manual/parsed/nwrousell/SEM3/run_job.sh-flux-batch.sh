#!/bin/bash
#FLUX: --job-name=doopy-milkshake-8426
#FLUX: --urgency=16

export APPTAINER_BINDPATH='/oscar/home/$USER,/oscar/scratch/$USER,/oscar/data'
export PYTHONUNBUFFERED='TRUE'

module purge
unset LD_LIBRARY_PATH
cd src
export APPTAINER_BINDPATH="/oscar/home/$USER,/oscar/scratch/$USER,/oscar/data"
export PYTHONUNBUFFERED=TRUE
srun apptainer exec --nv ../tensorflow-24.03-tf2-py3.simg python -m main --train --seed 3 --name $SLURM_JOB_NAME
