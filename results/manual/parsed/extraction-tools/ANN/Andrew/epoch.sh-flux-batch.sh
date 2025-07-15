#!/bin/bash
#FLUX: --job-name=blue-lentil-8508
#FLUX: --urgency=16

sbatch --array=${1}-${2} <<EOT
module purge
module load anaconda/2019.10-py3.7
module load singularity/3.5.2
module load tensorflow/2.1.0-py37
singularity run --nv /home/atz6cq/tensorflow-2.1.0-py37.sif Method2epochs.py ${SLURM_ARRAY_TASK_ID} ${3}
EOT
