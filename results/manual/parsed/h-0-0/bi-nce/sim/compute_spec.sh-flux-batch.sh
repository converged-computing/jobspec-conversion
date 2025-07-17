#!/bin/bash
#FLUX: --job-name=sim
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --urgency=16

export EXE='/bin/hostname'

export EXE=/bin/hostname
cd "${SLURM_SUBMIT_DIR}"
${EXE}
echo JOB ID: ${SLURM_JOBID}
echo Working Directory: $(pwd)
echo Start Time: $(date)
nvidia-smi --query-gpu=name --format=csv,noheader
source ../.venv/bin/activate
python $1 ${@:2}
echo End Time: $(date)
