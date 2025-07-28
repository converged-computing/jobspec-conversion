#!/bin/bash
#FLUX: --job-name=FROG1
#FLUX: -c=2
#FLUX: -t=174180
#FLUX: --urgency=16

set -e
module purge
module load anaconda
module load applications-extra
module load cuda/8.0.44-cudNN5.1
echo "SLURM_JOB_ID" $SLURM_ARRAY_TASK_ID
source activate py2-tf
./experiments/scripts/train_faster_rcnn.sh 0 pascal_voc vgg16
source deactivate py27
