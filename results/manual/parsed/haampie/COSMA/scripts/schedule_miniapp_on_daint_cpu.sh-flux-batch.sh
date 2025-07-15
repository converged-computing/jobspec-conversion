#!/bin/bash
#FLUX: --job-name=cosma_miniapp
#FLUX: -N=10
#FLUX: -t=120
#FLUX: --priority=16

export CC='`which cc`'
export CXX='`which CC`'
export CRAYPE_LINK_TYPE='dynamic'
export OMP_NUM_THREADS='18'
export MKL_NUM_THREADS='18'

module load daint-mc
module swap PrgEnv-cray PrgEnv-gnu
module load CMake
module unload cray-libsci
module load intel # defines $MKLROOT
export CC=`which cc`
export CXX=`which CC`
export CRAYPE_LINK_TYPE=dynamic
export OMP_NUM_THREADS=18
export MKL_NUM_THREADS=18
COSMA_DIR=$SCRATCH/cosma-master
MINIAPP_PATH=${COSMA_DIR}/build/miniapp
echo "====================="
echo "   Square Matrices"
echo "====================="
echo "(m, n, k) = (10000, 10000, 10000)"
echo "Nodes: 10"
echo "MPI processes per rank: 2"
echo ""
srun ${MINIAPP_PATH}/scalars_miniapp -m 10000 -n 10000 -k 10000 -P 20
echo ""
echo "====================="
echo "    Tall Matrices"
echo "====================="
echo "(m, n, k) = (1000, 1000, 1000000)"
echo "Nodes: 10"
echo "MPI processes per rank: 2"
echo ""
srun ${MINIAPP_PATH}/scalars_miniapp -m 1000 -n 1000 -k 1000000 -P 20
