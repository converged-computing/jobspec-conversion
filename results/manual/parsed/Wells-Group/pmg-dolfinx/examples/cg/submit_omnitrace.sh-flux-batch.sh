#!/bin/bash
#FLUX: --job-name=examplejob
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=standard-g
#FLUX: -t=1800
#FLUX: --urgency=16

export SPACK_DIR='/scratch/project_465000356/adrianj/spack'
export MPICH_GPU_SUPPORT_ENABLED='1'
export MPICH_OFI_NIC_POLICY='NUMA'
export HIPCC_COMPILE_FLAGS_APPEND='--offload-arch=gfx90a $(CC --cray-print-opts=cflags)'
export HIPCC_LINK_FLAGS_APPEND='$(CC --cray-print-opts=libs)'
export CXX='hipcc'
export ROCR_VISIBLE_DEVICES='$SLURM_LOCALID'
export OMNITRACE_VERSION='latest'
export ROCM_VERSION='5.2.3'
export OMNITRACE_INSTALL_DIR='/scratch/project_465000356/adrianj/omnitrace'
export PATH='$PATH:${OMNITRACE_INSTALL_DIR}/bin'
export OMNITRACE_CONFIG_FILE='/scratch/project_465000356/adrianj/pmg-dolfinx/examples/cg/build/omnitrace.cfg'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/scratch/project_465000356/adrianj/omnitrace/lib'

echo "Starting job $SLURM_JOB_ID at `date`"
ulimit -c unlimited
ulimit -s unlimited
gpu_bind=../select_gpu.sh
cpu_bind="--cpu-bind=map_cpu:49,57,17,23,1,9,33,41"
module load PrgEnv-gnu
module load craype-x86-trento
module load craype-accel-amd-gfx90a
module load rocm
export SPACK_DIR=/scratch/project_465000356/adrianj/spack
source $SPACK_DIR/share/spack/setup-env.sh
spack env activate fenicsx-gpu-env
spack load fenics-dolfinx
export MPICH_GPU_SUPPORT_ENABLED=1
export MPICH_OFI_NIC_POLICY=NUMA
export HIPCC_COMPILE_FLAGS_APPEND="--offload-arch=gfx90a $(CC --cray-print-opts=cflags)"
export HIPCC_LINK_FLAGS_APPEND=$(CC --cray-print-opts=libs)
export CXX=hipcc
export ROCR_VISIBLE_DEVICES=$SLURM_LOCALID
export OMNITRACE_VERSION=latest
export ROCM_VERSION=5.2.3
export OMNITRACE_INSTALL_DIR=/scratch/project_465000356/adrianj/omnitrace
export PATH=$PATH:${OMNITRACE_INSTALL_DIR}/bin
export OMNITRACE_CONFIG_FILE=/scratch/project_465000356/adrianj/pmg-dolfinx/examples/cg/build/omnitrace.cfg
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/scratch/project_465000356/adrianj/omnitrace/lib
srun -n 1 rm -fr cg_inst
srun -n 1 omnitrace-instrument -o cg_inst -- cg
time srun -N ${SLURM_NNODES} -n ${SLURM_NTASKS} ${cpu_bind} ${gpu_bind}  omnitrace-run --  ./cg_inst --ndofs=30000000
