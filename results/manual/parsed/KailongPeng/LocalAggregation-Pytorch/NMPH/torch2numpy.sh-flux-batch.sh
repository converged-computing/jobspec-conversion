#!/bin/bash
#FLUX: --job-name=torch2numpy
#FLUX: --queue=psych_day
#FLUX: -t=21600
#FLUX: --urgency=16

set -e
cd /gpfs/milgram/project/turk-browne/projects/LocalAggregation-Pytorch/
. /gpfs/milgram/apps/hpc.rhel7/software/Python/Anaconda3/etc/profile.d/conda.sh
conda activate py36
python -u ./NMPH/torch2numpy.py
echo "done"
