#!/bin/bash
#FLUX: --job-name=stanky-platanos-7829
#FLUX: --priority=16

export MPICH_ASYNC_PROGRESS='1'

export MPICH_ASYNC_PROGRESS=1
source ${HOME}/python3.7/bin/activate
cd ${HOME}/mpi-sppy/paperruns/larger_uc
srun -n 200 unbuffer python3.7 uc_cylinders.py --bundles-per-rank=0 --max-iterations=100 --default-rho=1.0 --num-scens=50 --max-solver-threads=2 --solver-name=gurobi_persistent --rel-gap=0.00001 --abs-gap=1 --no-cross-scenario-cuts --with-display-timing --intra-hub-conv-thres=-1.0
