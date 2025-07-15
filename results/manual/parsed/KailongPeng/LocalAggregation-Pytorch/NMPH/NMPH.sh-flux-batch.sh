#!/bin/bash
#FLUX: --job-name=NMPH
#FLUX: -t=21600
#FLUX: --urgency=16

set -e
cd /gpfs/milgram/project/turk-browne/projects/LocalAggregation-Pytorch/
. /gpfs/milgram/apps/hpc.rhel7/software/Python/Anaconda3/etc/profile.d/conda.sh
conda activate py36_jupyter  # py36_jupyter
python -u ./NMPH/NMPH.py "${SLURM_ARRAY_TASK_ID}"
echo "done"
