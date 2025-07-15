#!/bin/bash
#FLUX: --job-name=dirty-lettuce-9731
#FLUX: --queue=gpu_k80
#FLUX: -t=86400
#FLUX: --priority=16

module load cuda/8.0
module load python/2.7.12
cd $LOCAL_WORK_DIR/workspace/code/class-invariance-hint/
