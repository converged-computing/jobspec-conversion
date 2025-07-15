#!/bin/bash
#FLUX: --job-name=sPhysNet
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
singularity exec \
    --overlay ~/conda_envs/pytorch1.11-rocm4.5.2-25GB-500K.sqf:ro \
    /scratch/work/public/hudson/images/rocm4.5.2-ubuntu20.04.3.sif \
    bash -c "source /ext3/env.sh; export PYTHONPATH=../dataProviders:$PYTHONPATH; python train_rd_split.py --config_name $1 " $1
