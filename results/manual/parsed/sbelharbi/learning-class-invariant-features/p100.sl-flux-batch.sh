#!/bin/bash
#FLUX: --job-name=expressive-earthworm-6615
#FLUX: --queue=gpu_p100
#FLUX: -t=86400
#FLUX: --priority=16

module load cuda/8.0
module load python/2.7.12
cd $LOCAL_WORK_DIR/workspace/code/class-invariance-hint/
