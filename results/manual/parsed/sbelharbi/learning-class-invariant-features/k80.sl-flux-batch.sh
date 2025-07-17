#!/bin/bash
#FLUX: --job-name=lenet
#FLUX: --queue=gpu_k80
#FLUX: -t=86400
#FLUX: --urgency=16

module load cuda/8.0
module load python/2.7.12
cd $LOCAL_WORK_DIR/workspace/code/class-invariance-hint/
