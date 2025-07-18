#!/bin/bash
#FLUX: --job-name=coupled-totaldf
#FLUX: -N=21
#FLUX: --queue=regular
#FLUX: -t=14400
#FLUX: --urgency=16

export FI_CXI_RX_MATCH_MODE='hybrid  # prevents crash for large number of MPI processes, e.g. > 4096'
export OMP_STACKSIZE='2G   # required for GNU build to prevent a segfault'
export OMP_PLACES='cores'
export OMP_PROC_BIND='close'
export OMP_NUM_THREADS='8'
export n_mpi_ranks_per_node='32'
export xgc_bin_path='/pscratch/sd/j/jmerson/coupler-build-cpu/xgc-delta-f/bin/xgc-es-cpp'
export n_mpi_ranks='$((${SLURM_JOB_NUM_NODES} * ${n_mpi_ranks_per_node}))'
export coupler_bin_path='/pscratch/sd/j/jmerson/coupler-build-cpu/pcms/test/xgc_n0_server'

module unload gpu
module load cray-fftw
export FI_CXI_RX_MATCH_MODE=hybrid  # prevents crash for large number of MPI processes, e.g. > 4096
export OMP_STACKSIZE=2G   # required for GNU build to prevent a segfault
export OMP_PLACES=cores
export OMP_PROC_BIND=close
export OMP_NUM_THREADS=8
export n_mpi_ranks_per_node=32
export xgc_bin_path=XGC_executable_path
export n_mpi_ranks=$((${SLURM_JOB_NUM_NODES} * ${n_mpi_ranks_per_node}))
echo 'Number of nodes: '                  ${SLURM_JOB_NUM_NODES}
echo 'MPI ranks (total): '                $n_mpi_ranks
echo 'MPI ranks per node: '               $n_mpi_ranks_per_node
echo 'Number of OMP threads: '            ${OMP_NUM_THREADS}
echo 'XGC executable: '                   ${xgc_bin_path}
echo ''
srun -N ${SLURM_JOB_NUM_NODES} -n ${n_mpi_ranks} -c ${OMP_NUM_THREADS} --cpu-bind=cores --ntasks-per-node=${n_mpi_ranks_per_node} $xgc_bin_path
run_coupler() {
export coupler_bin_path=/pscratch/sd/j/jmerson/coupler-build-cpu/pcms/test/xgc_n0_server
echo 'Coupler executable: '                   ${coupler_bin_path}
set -x
OMP_NUM_THREADS=1
srun -N 1 -c 1 -n 6  --ntasks-per-node=6 --cpu-bind=cores \
$coupler_bin_path 590kmesh.osh 590kmesh_6.cpn 8 >> ${SLURM_JOB_ID}.out 2>&1 &
set +x
}
run_xgc_totalf() {
export xgc_bin_path=/pscratch/sd/j/jmerson/coupler-build-cpu/xgc-total-f/bin/xgc-es-cpp
echo 'totalf executable: '                   ${xgc_bin_path}
set -x
srun -N 16 -n 512 -c 8 --cpu-bind=cores --ntasks-per-node=32 \
$xgc_bin_path >> ${SLURM_JOB_ID}.out 2>&1 &
set +x
}
run_xgc_deltaf() {
export xgc_bin_path=/pscratch/sd/j/jmerson/coupler-build-cpu/xgc-delta-f/bin/xgc-es-cpp
echo 'deltaf executable: '                   ${xgc_bin_path}
set -x
srun -N 4 -n 128 -c 8 --cpu-bind=cores --ntasks-per-node=32 \
$xgc_bin_path >> ${SLURM_JOB_ID}.out 2>&1 &
set +x
}
ROOT_DIR=$PWD
cd $ROOT_DIR/edge
run_xgc_totalf
cd $ROOT_DIR/core
run_xgc_deltaf
cd $ROOT_DIR
run_coupler
wait
