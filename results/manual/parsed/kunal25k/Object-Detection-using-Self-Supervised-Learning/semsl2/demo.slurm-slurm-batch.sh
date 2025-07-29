#!/bin/bash
#FLUX: --job-name=jobName
#FLUX: -c=4
#FLUX: -t=25200
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='/tmp/$USER'
export PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:128'

mkdir /tmp/$USER
export SINGULARITY_CACHEDIR=/tmp/$USER
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:128
singularity exec --nv \
--bind /scratch \
--overlay /scratch/sca321/dlproject/data/labeled.sqsh \
--overlay /scratch/sca321/dlproject/data/unlabeled.sqsh \
--overlay /scratch/sca321/dlproject/data/conda.ext3:ro \
/scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
/bin/bash -c "
source /ext3/env.sh
conda activate
python threestage.py
"
