#!/bin/bash
#FLUX: --job-name=aph_reallystarved
#FLUX: -N=34
#FLUX: -n=300
#FLUX: -c=2
#FLUX: -t=1800
#FLUX: --urgency=16

export MPICH_ASYNC_PROGRESS='1'

export MPICH_ASYNC_PROGRESS=1
source ${HOME}/venvs/mpisppy-jan2023/bin/activate
date
NODENAME="$(srun hostname)"
echo ${NODENAME[0]}
SOLVERNAME="gurobi_persistent"
REPLICANT=1
PICKLE_DIR="/p/lustre1/watson61/aircond/$REPLICANT"
BF1=1000
BF2=25
BF3=10
BF4=4
let SPB=BF2*BF3*BF4
let SC=BF1*BF2*BF3*BF4
let PBF=BF1  # by design, this is the number of bundles
BI=50
NC=1
QSC=0.3
SD=40
OTC=5
let SEED=(REPLICANT-1)*1000000
EC="--Capacity 200 --QuadShortCoeff $QSC  --BeginInventory $BI --mu-dev 0 --sigma-dev $SD --start-seed $SEED --NegInventoryCost=$NC --OvertimeProdCost=$OTC"
echo "^^^^^^^^^ Make pickle bundles"
srun -n $SLURM_NTASKS unbuffer python -m mpi4py bundle_pickler.py --branching-factors "$BF1 $BF2 $BF3 $BF4" --pickle-bundles-dir=$PICKLE_DIR --scenarios-per-bundle=$SPB $EC
srun -n $SLURM_NTASKS unbuffer python -m mpi4py aircond_cylinders.py --run-async --aph-frac-needed=1.0 --aph-dispatch-frac=0.20 --max-iterations=100 --default-rho=1 --solver-name=${SOLVERNAME} --branching-factors $PBF --rel-gap 0.0001 --abs-gap 0.5 --max-solver-threads 2 --start-seed $SEED --bundles-per-rank=0  --scenarios-per-bundle=$SPB --write-solution --intra-hub-conv-thresh 0 --unpickle-bundles-dir=$PICKLE_DIR $EC --display-progress --solver-options="method=0" --lagrangian --xhatshuffle --trace-prefix "${SLURM_JOB_NAME}_"
