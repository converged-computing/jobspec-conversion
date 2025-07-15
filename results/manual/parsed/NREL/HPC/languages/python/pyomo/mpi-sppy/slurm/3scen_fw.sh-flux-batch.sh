#!/bin/bash
#FLUX: --job-name=butterscotch-rabbit-3932
#FLUX: -n=12
#FLUX: -t=300
#FLUX: --urgency=16

export MPICH_ASYNC_PROGRESS='1'

module load conda
module load xpressmp
conda activate pyomo
export MPICH_ASYNC_PROGRESS=1
cd ${HOME}/software/mpi-sppy/paperruns/larger_uc
srun python -u -m mpi4py uc_cylinders.py --bundles-per-rank=0 --max-iterations=100 --default-rho=1.0 --num-scens=3 --max-solver-threads=2 --solver-name=xpress_persistent --rel-gap=0.00001 --abs-gap=1 --no-cross-scenario-cuts
