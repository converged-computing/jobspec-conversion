#!/bin/bash
#FLUX: --job-name=quantum
#FLUX: -t=43200
#FLUX: --priority=16

singularity exec --overlay $SCRATCH/overlay-25GB-500K.ext3:rw /scratch/work/public/singularity/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif /bin/bash -c "
source /ext3/env.sh
conda activate quantum
python planes.py
"
