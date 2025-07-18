#!/bin/bash
#FLUX: --job-name=coupled
#FLUX: -N=21
#FLUX: -t=600
#FLUX: --urgency=16

export FI_CXI_RX_MATCH_MODE='software'
export OMP_PROC_BIND='true'
export OMP_NUM_THREADS='14'
export coupler_bin_path='$MEMBERWORK/phy122/coupler-build-frontier/pcms/test/xgc_n0_server'
export xgc_totalf_path='$MEMBERWORK/phy122/coupler-build-frontier/xgc-delta-f/bin/xgc-es-cpp-gpu'
export xgc_deltaf_path='$MEMBERWORK/phy122/coupler-build-frontier/xgc-delta-f/bin/xgc-es-cpp-gpu'
export n_mpi_ranks_per_node='8'
export n_mpi_ranks='$((${SLURM_JOB_NUM_NODES} * ${n_mpi_ranks_per_node}))'

source modules.sh
export FI_CXI_RX_MATCH_MODE=software
export OMP_PROC_BIND=true
export OMP_NUM_THREADS=14
export coupler_bin_path=$MEMBERWORK/phy122/coupler-build-frontier/pcms/test/xgc_n0_server
export xgc_totalf_path=$MEMBERWORK/phy122/coupler-build-frontier/xgc-delta-f/bin/xgc-es-cpp-gpu
export xgc_deltaf_path=$MEMBERWORK/phy122/coupler-build-frontier/xgc-delta-f/bin/xgc-es-cpp-gpu
export n_mpi_ranks_per_node=8
export n_mpi_ranks=$((${SLURM_JOB_NUM_NODES} * ${n_mpi_ranks_per_node}))
echo 'Number of nodes: '                  ${SLURM_JOB_NUM_NODES}
echo 'MPI ranks (total): '                $n_mpi_ranks
echo 'MPI ranks per node: '               $n_mpi_ranks_per_node
echo 'Number of OMP threads: '            ${OMP_NUM_THREADS}
echo 'Coupler executable: '               ${coupler_bin_path}
echo 'totalf executable: '                ${xgc_totalf_path}
echo 'deltaf executable: '                ${xgc_deltaf_path}
srun hostname
scontrol show jobid ${SLURM_JOB_ID}
removeBPSST() {
rm -r *.sst
rm -r core_c2s.bp
rm -r core_s2c.bp
rm -r edge_c2s.bp 
rm -r edge_s2c.bp
}
run_coupler() {
set -x
OMP_NUM_THREADS=1
srun -r0 -c 1 -n 8 --gpus-per-task=1 --gpu-bind=closest $coupler_bin_path 590kmesh.osh 590kmesh_8.cpn 8 >> ${SLURM_JOB_ID}.out 2>&1 &
set +x
}
run_xgc_totalf() {
set -x
srun -r1 -n 128 -c 14 --gpus-per-task=1 --gpu-bind=closest $xgc_totalf_path >> ${SLURM_JOB_ID}.out 2>&1 &
set +x
}
run_xgc_deltaf() {
set -x
srun -r17 -n 32 -c 14 --ntasks-per-node=4 --gpus-per-task=1  --gpu-bind=closest $xgc_deltaf_path >> ${SLURM_JOB_ID}.out 2>&1 &
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
