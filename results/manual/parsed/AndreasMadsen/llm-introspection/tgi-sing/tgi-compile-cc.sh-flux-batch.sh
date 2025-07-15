#!/bin/bash
#FLUX: --job-name=placid-ricecake-6199
#FLUX: -c=2
#FLUX: -t=36000
#FLUX: --urgency=16

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
module load StdEnv/2023
module load apptainer
mkdir -p $RELEASE_DIR
apptainer build $RELEASE_DIR/tgi.sif docker://ghcr.io/huggingface/text-generation-inference:2.0.1
