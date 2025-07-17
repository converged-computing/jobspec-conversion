#!/bin/bash
#FLUX: --job-name=grated-peanut-9908
#FLUX: --exclusive
#FLUX: --queue=broadwl
#FLUX: -t=9000
#FLUX: --urgency=16

export OMP_NUM_THREADS='28'

module load mpich/3.2
module load gcc/6.2
module load valgrind
export OMP_NUM_THREADS=28
CRX_MODEL=/project/jozik/midway2/repos/community-rx/model/Release/crx_model-0.3
$CRX_MODEL ./config.props
