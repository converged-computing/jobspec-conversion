#!/bin/bash
#FLUX: --job-name=spicy-soup-8651
#FLUX: -n=6
#FLUX: --queue=GPU
#FLUX: -t=3600
#FLUX: --urgency=16

MY_TMP_DIR=/slurmtmp/${SLURM_JOB_USER}.${SLURM_JOB_ID}
mv <path/to/your/data/> ${MY_TMP_DIR}
module purge
module load python/3.6.7
module load tensorflow/1.12.0
echo "Hello world"
