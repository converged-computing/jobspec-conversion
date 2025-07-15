#!/bin/bash
#FLUX: --job-name=arid-fudge-6063
#FLUX: --urgency=16

module purge
module load anaconda/2019.10-py3.7
module load singularity
module load tensorflow/2.1.0-py37
singularity run --nv /home/$USER/tensorflow-2.1.0-py37.sif /home/sl8rn/Rivannas/General2.py ${SLURM_ARRAY_TASK_ID}
