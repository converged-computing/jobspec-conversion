#!/bin/bash
#FLUX: --job-name=my_job_name
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export EXE='/bin/hostname'

export EXE=/bin/hostname
cd "${SLURM_SUBMIT_DIR}"
${EXE}
echo JOB ID: ${SLURM_JOBID}
echo Working Directory: $(pwd)
echo Start Time: $(date)
nvidia-smi --query-gpu=name --format=csv,noheader
source ../pyvenv/bin/activate
python $1 ${@:2}
echo End Time: $(date)
