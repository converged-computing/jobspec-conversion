#!/bin/bash
#FLUX: --job-name=angry-punk-1979
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

date;hostname;pwd
module load singularity
singularity exec --nv /blue/vendor-nvidia/hju/monaicore1.0.1 \
nsys profile \
--output ./output_base \
--force-overwrite true \
--trace-fork-before-exec true \
python3 $HOME/tutorials/performance_profiling/radiology/train_base_nvtx.py
