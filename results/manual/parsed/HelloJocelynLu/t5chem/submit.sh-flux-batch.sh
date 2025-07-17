#!/bin/bash
#FLUX: --job-name=creamy-truffle-2978
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
script=$1
overlay_ext3=/home/jl8570/torch-env2.ext3
if [[ $(hostname -s) =~ ^g ]]; then nv="--nv"; fi
singularity \
    exec $nv --overlay $overlay_ext3:ro \
    /scratch/work/public/singularity/cuda11.0-cudnn8-devel-ubuntu18.04.sif  \
    /bin/bash -c "source /ext3/env.sh; \
        bash $script"
