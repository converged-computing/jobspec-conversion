#!/bin/bash
#FLUX: --job-name=ITER_SOLVERS
#FLUX: --exclusive
#FLUX: --queue=amd
#FLUX: -t=21600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${HOME}/HYPRE/build_amd/lib:${LD_LIBRARY_PATH}'
export OMP_DISPLAY_ENV='true'
export OMP_DISPLAY_AFFINITY='true'
export OMP_NUM_THREADS='32'

source /home/blodej/nec_hpc_tools/env/mpi/hpcx-2.9.0/linux-x64-intel2021.3/env.sh
export LD_LIBRARY_PATH=${HOME}/HYPRE/build_amd/lib:${LD_LIBRARY_PATH}
SOLVER=12
DEBUG=0
E_MTX=1
LOG=0
P_LOG=0
PADDING=0
MTX="${HOME}/HYPRE/sim_data/${NAME}/${NAME}.mtx"
MTX_B="${HOME}/HYPRE/sim_data/${NAME}/${NAME}_b.mtx"
MTX_X="${HOME}/HYPRE/sim_data/${NAME}/${NAME}_x.mtx"
DIR="/home/emorsi/HYPRE/iterative_solvers"
echo "Dataset: ${NAME}"
echo "NThreads: ${NTH}"
echo "CPU INFO:"
lscpu |grep -e "Model name"
lscpu |grep -e "Socket(s):" -e "Core(s) per socket" -e "NUMA node(s):"
CMD="${DIR}/solver_amd -solver ${SOLVER}  -log ${LOG}  -precond_log ${P_LOG}  -niter 1  -maxit 1000  -tol 1e-16  -emtx ${E_MTX} -mtx ${MTX}"
if [[ $PADDING -eq 1 ]]; then
       CMD+="  -padding"
fi
if [[ $RHS -eq 1 ]]; then
       CMD+=" -b ${MTX_B}"
fi
if [[ $X -eq 1 ]]; then
       CMD+=" -x ${MTX_X}"
fi
export OMP_DISPLAY_ENV=true
export OMP_DISPLAY_AFFINITY=true
export OMP_NUM_THREADS=8
mpirun -report-bindings --map-by ppr:2:node:pe=32 -x OMP_PROC_BIND=spread   ${CMD}
export OMP_NUM_THREADS=16
mpirun -report-bindings --map-by ppr:2:node:pe=32 -x OMP_PROC_BIND=spread   ${CMD}
export OMP_NUM_THREADS=32
mpirun -report-bindings --map-by ppr:2:node:pe=32 -x OMP_PROC_BIND=spread   ${CMD}
exit 0
