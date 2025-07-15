#!/bin/bash
#FLUX: --job-name=anxious-chip-1813
#FLUX: -c=2
#FLUX: --queue=unkillable-cpu
#FLUX: -t=36000
#FLUX: --priority=16

set -e
set -v
if [ -z "${RELEASE_DIR}" ]; then
    RELEASE_DIR=$HOME/tgi-sif
fi
if [ -z "${TGI_DIR}" ]; then
    TGI_DIR=$SCRATCH/tgi
fi
if [ -z "${TGI_TMP}" ]; then
    TGI_TMP=$SLURM_TMPDIR/tgi
fi
module load singularity/3.7.1
mkdir -p $RELEASE_DIR
singularity build $RELEASE_DIR/tgi.sif docker://ghcr.io/huggingface/text-generation-inference:2.0.1
