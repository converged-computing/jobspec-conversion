#!/bin/bash
#FLUX: --job-name=milky-underoos-8246
#FLUX: --urgency=16

export MPICH_ASYNC_PROGRESS='1'

export MPICH_ASYNC_PROGRESS=1
source ${HOME}/python3.7/bin/activate
cd ${HOME}/mpi-sppy/examples/uc
srun -n 12 unbuffer python3.7 uc_cylinders.py --bundles-per-rank=0 --max-iterations=100 --default-rho=1.0 --num-scens=3 --max-solver-threads=2 --solver-name=gurobi_persistent --rel-gap=0.0001 --abs-gap=1 --no-fw --no-fixer
