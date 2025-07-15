#!/bin/bash
#FLUX: --job-name=tokens
#FLUX: -t=1800
#FLUX: --priority=16

singularity exec --overlay /scratch/cl5625/overlay-exceptions.ext3:ro /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif /bin/bash -c "
source /ext3/env.sh
conda activate exceptions
python $SCRATCH/exceptions/scripts/count_tokens.py --dataset_name $DATASET_NAME
"
