#!/bin/bash
#FLUX: --job-name=ITER_SOLVERS
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${NTH} '

lscpu
nvidia-smi
source ${HOME}/nec_hpc_tools/env/mpi/hpcx-2.7.0/linux-x64-intel2018.3/env.sh
source ${HOME}/nec_hpc_tools/env/compilers/linux-x64-cuda11.2/env.sh
SOLVER=7
E_MTX=1
LOG=0
P_LOG=0
NTH=24
PADDING=0
NP=1
VE="0"
 NAME=bbmat RHS=1 X=1  # contain rhs and sol
MTX="${HOME}/HYPRE/sim_data/${NAME}/${NAME}.mtx"
MTX_B="${HOME}/HYPRE/sim_data/${NAME}/${NAME}_b.mtx"
MTX_X="${HOME}/HYPRE/sim_data/${NAME}/${NAME}_x.mtx"
DIR="${HOME}/HYPRE/SpMTXReader"
echo "Dataset: ${NAME}"
echo "NThreads: ${NTH}"
echo "CPU INFO:"
lscpu |grep -e "Model name"
lscpu |grep -e "Socket(s):" -e "Core(s) per socket" -e "NUMA node(s):"
CMD="${DIR}/solver_x86 -solver ${SOLVER}  -log ${LOG}  -precond_log ${P_LOG}  -niter 1  -maxit 10000  -tol 1e-16  -emtx ${E_MTX} -mtx ${MTX}"
if [[ $PADDING -eq 1 ]]; then
       CMD+="  -padding"
fi
if [[ $RHS -eq 1 ]]; then
       CMD+=" -b ${MTX_B}"
fi
if [[ $X -eq 1 ]]; then
       CMD+=" -x ${MTX_X}"
fi
export OMP_NUM_THREADS=${NTH} 
PPN=1
mpirun -np ${NP} --map-by ppr:${PPN}:node:pe=${NTH}  ${CMD}
exit 0
