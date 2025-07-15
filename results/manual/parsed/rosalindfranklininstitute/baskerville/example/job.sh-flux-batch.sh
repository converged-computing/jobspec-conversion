#!/bin/bash
#FLUX: --job-name=spicy-arm-7134
#FLUX: -c=36
#FLUX: -t=1200
#FLUX: --priority=16

export PROJECT_DIR='/bask/projects/f/ffnr0871-rfi-test/pje39613'
export SINGULARITY_CACHEDIR='$PROJECT_DIR/.singularity-cache'
export CONTAINER='docker://quay.io/rosalindfranklininstitute/jax@sha256:0c9fcac6a84d3c427e6b92489452afb46157995996524d40c1a4286c7ca6bb49'

module purge
module load baskerville
module load bask-apps/live
module load OpenMPI/4.0.5-gcccuda-2020b
set -x
export PROJECT_DIR="/bask/projects/f/ffnr0871-rfi-test/pje39613"
export SINGULARITY_CACHEDIR="$PROJECT_DIR/.singularity-cache"
export CONTAINER="docker://quay.io/rosalindfranklininstitute/jax@sha256:0c9fcac6a84d3c427e6b92489452afb46157995996524d40c1a4286c7ca6bb49"
mpirun singularity run --nv $CONTAINER python example/job.py --log_nvsmi \
                       --train_dataset "$PROJECT_DIR/mnist-train" \
                       --val_dataset   "$PROJECT_DIR/mnist-test"
