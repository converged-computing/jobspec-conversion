#!/bin/bash
#FLUX: --job-name=count
#FLUX: -t=18000
#FLUX: --priority=16

singularity exec --nv --overlay /scratch/cl5625/overlay-exceptions.ext3:ro /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif /bin/bash -c "
source /ext3/env.sh
conda activate corpus
echo $SOURCE_V REDUCE $TARGET_V
python $SCRATCH/exceptions/scripts/reduce_counts.py -s $SOURCE_V -t $TARGET_V
"
