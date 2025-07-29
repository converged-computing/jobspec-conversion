#!/bin/bash
#FLUX: --job-name=demo
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --urgency=16

singularity exec --nv \
--overlay /scratch/xl3136/conda.ext3:ro \
--overlay /scratch/xl3136/dl-sp22-final-project/dataset/labeled.sqsh \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif \
/bin/bash -c "
source /ext3/env.sh
python barlowtwins.py -n 20 --lr 0.0001
"
