#!/bin/bash
#FLUX: --job-name=5km_abl
#FLUX: -N=70
#FLUX: -t=172800
#FLUX: --urgency=50

export SPACK_MANAGER='/home/asharma/exawind_spack_latest/spack-manager'

export SPACK_MANAGER=/home/asharma/exawind_spack_latest/spack-manager
source ${SPACK_MANAGER}/configs/eagle/env.sh
module load mpt
source ${SPACK_MANAGER}/start.sh && quick-activate ${SPACK_MANAGER}/environments/latest
spack load exawind
amr_exec="$(spack location -i amr-wind)/bin/amr_wind"
mpirun -np 2520 ${amr_exec} abl.inp
