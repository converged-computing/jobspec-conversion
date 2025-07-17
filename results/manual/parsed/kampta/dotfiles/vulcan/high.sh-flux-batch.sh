#!/bin/bash
#FLUX: --job-name=bumfuzzled-diablo-2245
#FLUX: -c=4
#FLUX: --queue=dpart
#FLUX: -t=129600
#FLUX: --urgency=50

export WORK_DIR='/scratch0/slurm_${SLURM_JOBID}'
export PYTHONPATH='.:$PYTHONPATH'

set -x
module add cuda gcc/6.3.0
export WORK_DIR="/scratch0/slurm_${SLURM_JOBID}"
export PYTHONPATH=".:$PYTHONPATH"
srun bash -c "mkdir ${WORK_DIR}"
srun rsync -a --exclude="*.out" $WORK_DIR
srun bash -c "cd ${WORK_DIR}"
srun python -u "$@"
srun bash -c "rm -rf ${WORK_DIR}"
