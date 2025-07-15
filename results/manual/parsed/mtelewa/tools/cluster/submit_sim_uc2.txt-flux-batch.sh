#!/bin/bash
#FLUX: --job-name=Pump
#FLUX: --queue=single
#FLUX: -t=172800
#FLUX: --priority=16

export KMP_AFFINITY='compact,1,0'

export KMP_AFFINITY=compact,1,0
module load compiler/intel/19.1
module load mpi/openmpi/4.0
$${rocket_launch}
