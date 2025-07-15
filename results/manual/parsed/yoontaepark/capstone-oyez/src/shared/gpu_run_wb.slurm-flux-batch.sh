#!/bin/bash
#FLUX: --job-name=myTest
#FLUX: -t=86400
#FLUX: --priority=16

module purge    
singularity exec --nv --bind $SCRATCH/comp_gen --overlay $SCRATCH/overlay-25GB-500K.ext3:ro \
            /scratch/work/public/singularity/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif /bin/bash -c "
source /ext3/env.sh
conda activate
pip install rouge
CUDA_LAUNCH_BLOCKING=1 python $SCRATCH/capstone_wb/wb_code_v2.py conclusion --finetune
"
