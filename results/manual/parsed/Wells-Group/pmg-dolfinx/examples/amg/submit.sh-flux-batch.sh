#!/bin/bash
#FLUX: --job-name=examplejob
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --urgency=16

export MPICH_GPU_SUPPORT_ENABLED='1'
export SPACK_DIR='/scratch/project_465000633/adrianj/spack'
export MPICH_OFI_NIC_POLICY='NUMA'
export HIPCC_COMPILE_FLAGS_APPEND='--offload-arch=gfx90a $(CC --cray-print-opts=cflags)'
export HIPCC_LINK_FLAGS_APPEND='$(CC --cray-print-opts=libs)'
export CXX='hipcc'

export MPICH_GPU_SUPPORT_ENABLED=1
echo "Starting job $SLURM_JOB_ID at `date`"
ulimit -c unlimited
ulimit -s unlimited
gpu_bind=../select_gpu.sh
cpu_bind="--cpu-bind=map_cpu:49,57,17,23,1,9,33,41"
module load PrgEnv-gnu
module load craype-x86-trento
module load craype-accel-amd-gfx90a
module load rocm
export SPACK_DIR=/scratch/project_465000633/adrianj/spack
source $SPACK_DIR/share/spack/setup-env.sh
spack env activate fenicsx-gpu-env
spack load fenics-dolfinx
export MPICH_GPU_SUPPORT_ENABLED=1
export MPICH_OFI_NIC_POLICY=NUMA
export HIPCC_COMPILE_FLAGS_APPEND="--offload-arch=gfx90a $(CC --cray-print-opts=cflags)"
export HIPCC_LINK_FLAGS_APPEND=$(CC --cray-print-opts=libs)
export CXX=hipcc
rm -rf build
mkdir build
cd build
cmake ..
make -j8
srun -N ${SLURM_NNODES} -n ${SLURM_NTASKS} ${cpu_bind} ${gpu_bind} ./mg
