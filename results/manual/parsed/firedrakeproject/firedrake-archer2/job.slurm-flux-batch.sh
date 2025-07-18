#!/bin/bash
#FLUX: --job-name=firedrake
#FLUX: -N=2
#FLUX: --queue=standard
#FLUX: -t=600
#FLUX: --urgency=16

export FIREDRAKE_DIR='/your/firedrake/install/dir'
export FI_OFI_RXM_SAR_LIMIT='64K'

export FIREDRAKE_DIR=/your/firedrake/install/dir
myScript=example.py
export FI_OFI_RXM_SAR_LIMIT=64K
module load epcc-job-env
source $FIREDRAKE_DIR/firedrake_activate.sh
srun --ntasks-per-node 1 $FIREDRAKE_DIR/firedrake_activate.sh
srun --ntasks-per-node 128 $VIRTUAL_ENV/bin/python ${myScript}
