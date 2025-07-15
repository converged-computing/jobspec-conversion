#!/bin/bash
#FLUX: --job-name=confused-hippo-3706
#FLUX: --urgency=16

ml
source $SPACK_DIR/share/spack/setup-env.sh
spack load gcc@11.2.0
spack load cuda@11.5.2
ibrun ./cactus_CarpetX-cuda qc0.par
