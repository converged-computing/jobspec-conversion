#!/bin/bash
#FLUX: --job-name=crusty-butter-3618
#FLUX: --queue=dev
#FLUX: -t=60
#FLUX: --urgency=16

module purge
module load anaconda/2020.11-py3.8
module load singularity/3.7.1
module load tensorflow
singularity run --nv /home/$USER/tensorflow-2.7.0.sif localfit_v2.py $SLURM_ARRAY_TASK_ID
