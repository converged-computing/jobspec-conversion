#!/bin/bash
#FLUX: --job-name=stream
#FLUX: --exclusive
#FLUX: --queue=standard
#FLUX: -t=600
#FLUX: --priority=16

export IOCOMP_DIR='/work/d403/d403/shr2032/opt/gcc/iocomp/1.1.3'
export LD_LIBRARY_PATH='${IOCOMP_DIR}/lib:${LD_LIBRARY_PATH}'
export EXE='${IOCOMP_DIR}/stream/test'
export OMP_NUM_THREADS='1'
export SLURM_NTASKS_PER_NODE='72'
export FULL_CORES='72'
export NODESIZE='36'
export HALF_CORES='$((${FULL_CORES}/2))'
export HALF_NODES='$((${SLURM_NNODES}/2))'
export PARENT_DIR='${SLURM_SUBMIT_DIR}/TEST'
export MAP='0 '

module load gcc/8.2.0 
module load mpt 
module load hdf5parallel/1.10.6-gcc8-mpt225
export IOCOMP_DIR=/work/d403/d403/shr2032/opt/gcc/iocomp/1.1.3
export LD_LIBRARY_PATH=${IOCOMP_DIR}/lib:${LD_LIBRARY_PATH}
export EXE=${IOCOMP_DIR}/stream/test
export OMP_NUM_THREADS=1
export SLURM_NTASKS_PER_NODE=72
export FULL_CORES=72
export NODESIZE=36
export HALF_CORES=$((${FULL_CORES}/2))
export HALF_NODES=$((${SLURM_NNODES}/2))
export PARENT_DIR=${SLURM_SUBMIT_DIR}/TEST
export MAP=0 
if [ -z ${IO} ] 
then 
  export IO=0  # MPIIO 
fi 
if [ -z ${nx} ] 
then 
  export nx=1024
fi 
if [ -z ${ny} ] 
then 
  export ny=1024
fi 
source ${SLURM_SUBMIT_DIR}/slurm_files/sequential.sh 
