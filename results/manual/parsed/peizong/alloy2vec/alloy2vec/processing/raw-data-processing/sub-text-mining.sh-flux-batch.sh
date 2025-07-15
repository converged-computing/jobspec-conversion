#!/bin/bash
#FLUX: --job-name=fugly-nunchucks-8444
#FLUX: -t=604800
#FLUX: --urgency=16

singularity exec --overlay /scratch/zp2137/text-mining/overlay-25GB-500K.ext3:ro \
        /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
        /bin/bash -c "source /ext3/env.sh; conda activate py36; ./specify-task.sh"
