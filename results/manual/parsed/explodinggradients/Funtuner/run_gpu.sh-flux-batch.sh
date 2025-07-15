#!/bin/bash
#FLUX: --job-name=hello-leopard-7524
#FLUX: -t=21600
#FLUX: --urgency=16

export PYTHONPATH='${PYTHONPATH}:/home/c.scmse/Funtuner'

git pull origin dev-train 
module purge
module load deepspeed
module list
export PYTHONPATH="${PYTHONPATH}:/home/c.scmse/Funtuner"
exec singularity exec --nv $DEEPSPEED_IMAGE /nfshome/store03/users/c.scmse/venv/bin/python3 funtuner/trainer.py
