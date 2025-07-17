#!/bin/bash
#FLUX: --job-name=psycho-salad-0584
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --urgency=16

echo Starting job ${SLURM_JOBID}
echo SLURM assigned me these nodes:
squeue -j ${SLURM_JOBID} -O nodelist | tail -n +2
source ~/miniconda3/etc/profile.d/conda.sh
source ~/.bashrc
conda activate base
cd /nfs/students/borchero/natpn
OPTIONS=$(sed "${SLURM_ARRAY_TASK_ID}q;d" $1)
poetry run train --experiment slurm-${SLURM_ARRAY_JOB_ID}-${SLURM_ARRAY_TASK_ID} ${OPTIONS}
