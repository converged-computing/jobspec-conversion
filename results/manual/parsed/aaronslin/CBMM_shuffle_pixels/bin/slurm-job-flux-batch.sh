#!/bin/bash
#FLUX: --job-name=shuffle_pixels
#FLUX: --urgency=16

set -euxo pipefail
${SLURM_ARRAY_TASK_ID:=3}
source ${MODULESHOME}/init/bash
module add openmind/singularity/2.2.1
singularity exec --bind /om:/om /om/user/aaronlin/py35-tf.img python -u conv_shuffle.py -s $SLURM_ARRAY_TASK_ID -o 1 -d cifar
