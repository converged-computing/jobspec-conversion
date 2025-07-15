#!/bin/bash
#FLUX: --job-name=RabbitThickness
#FLUX: -c=20
#FLUX: --queue=small
#FLUX: -t=21600
#FLUX: --priority=16

module load gcc/8.3.0 cuda/10.1.168
module load pytorch/1.4
module load bioconda
DATA_DIR=../../data
echo "Start the job..."
srun ./exp_csc.sh ${SLURM_ARRAY_TASK_ID} ${DATA_DIR}/data
echo "Done the job!"
