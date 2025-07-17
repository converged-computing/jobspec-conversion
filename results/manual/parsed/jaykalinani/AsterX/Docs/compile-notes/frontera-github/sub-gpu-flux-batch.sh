#!/bin/bash
#FLUX: --job-name=gloopy-spoon-3864
#FLUX: -n=4
#FLUX: --queue=rtx-dev
#FLUX: -t=7200
#FLUX: --urgency=16

ml
source $SPACK_DIR/share/spack/setup-env.sh
spack load gcc@11.2.0
spack load cuda@11.5.2
ibrun ./cactus_CarpetX-cuda qc0.par
