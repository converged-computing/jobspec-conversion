#!/bin/bash
#FLUX: --job-name=ann_paramsweep
#FLUX: -c=10
#FLUX: -t=86400
#FLUX: --priority=16

module purge
/scratch/ab10313/pytorch-example/my_pytorch.ext3:ro \
  /scratch/work/public/singularity/cuda11.0-cudnn8-devel-ubuntu18.04.sif
singularity exec --nv \
            --overlay /scratch/ab10313/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.0-cudnn8-devel-ubuntu18.04.sif \
            /bin/bash -c "source /ext3/env.sh; python /home/ab10313/submeso_ML/nn/lightning/ann_hyperparam_sweep.py 10"
