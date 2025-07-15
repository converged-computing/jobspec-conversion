#!/bin/bash
#FLUX: --job-name=conf-bo
#FLUX: -t=43200
#FLUX: --priority=16

export PATH='/ext3/miniconda3/envs/conf-bo-env/bin:${PATH}'

singularity exec --nv --overlay ${SCRATCH}/overlay-50G-10M.ext3:ro /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif /bin/bash -c "
source /ext3/env.sh
export PATH=/ext3/miniconda3/envs/conf-bo-env/bin:${PATH}
conda activate conf-bo-env
cd /home/ss13641/code/remote/conformal-bayesopt
wandb agent --count 4 samuelstanton/conformal-bayesopt/qy5qbae3
"
