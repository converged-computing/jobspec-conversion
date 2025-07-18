#!/bin/bash
#FLUX: --job-name=amber@22
#FLUX: -c=10
#FLUX: --queue=ind-gpu-shared
#FLUX: -t=172800
#FLUX: --urgency=16

declare -xr LOCAL_TIME="$(date +'%Y%m%dT%H%M%S%z')"
declare -xir UNIX_TIME="$(date +'%s')"
declare -xr SYSTEM_NAME='expanse'
declare -xr SPACK_VERSION='0.17.3'
declare -xr SPACK_INSTANCE_NAME='gpu'
declare -xr SPACK_INSTANCE_VERSION='b'
declare -xr SPACK_INSTANCE_DIR="/cm/shared/apps/spack/${SPACK_VERSION}/${SPACK_INSTANCE_NAME}/${SPACK_INSTANCE_VERSION}"
declare -xr SLURM_JOB_SCRIPT="$(scontrol show job ${SLURM_JOB_ID} | awk -F= '/Command=/{print $2}')"
declare -xr SLURM_JOB_MD5SUM="$(md5sum ${SLURM_JOB_SCRIPT})"
declare -xr SCHEDULER_MODULE='slurm'
declare -xr COMPILER_MODULE='gcc/8.4.0'
declare -xr MPI_MODULE='openmpi/4.1.3'
declare -xr CUDA_MODULE='cuda/10.2.89'
declare -xr CMAKE_MODULE='cmake/3.21.4'
echo "${UNIX_TIME} ${SLURM_JOB_ID} ${SLURM_JOB_MD5SUM} ${SLURM_JOB_DEPENDENCY}" 
echo ""
cat "${SLURM_JOB_SCRIPT}"
module purge
module load "${SCHEDULER_MODULE}"
. "${SPACK_INSTANCE_DIR}/share/spack/setup-env.sh"
module use "${SPACK_ROOT}/share/spack/lmod/linux-rocky8-x86_64/Core"
module load "${COMPILER_MODULE}"
module load "${MPI_MODULE}"
module load "${CUDA_MODULE}"
module load "${CMAKE_MODULE}"
module list
shopt -s expand_aliases
source ~/.bashrc
declare -xr SPACK_PACKAGE='amber@22'
declare -xr SPACK_COMPILER='gcc@8.4.0'
declare -xr SPACK_VARIANTS="+cuda cuda_arch=70 +mpi +openmp +update"
declare -xr SPACK_DEPENDENCIES="^cuda@10.2.89/$(spack find --format '{hash:7}' cuda@10.2.89 % ${SPACK_COMPILER}) ^netcdf-c@4.8.1/$(spack find --format '{hash:7}' netcdf-c@4.8.1 % ${SPACK_COMPILER} +mpi ^openmpi@4.1.3)"
declare -xr SPACK_SPEC="${SPACK_PACKAGE} % ${SPACK_COMPILER} ${SPACK_VARIANTS} ${SPACK_DEPENDENCIES}"
printenv
spack config get compilers
spack config get config  
spack config get mirrors
spack config get modules
spack config get packages
spack config get repos
spack config get upstreams
time -p spack --show-cores=minimized spec --long --namespaces --types --reuse $(echo "${SPACK_SPEC}")
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack concretization failed.'
fi
time -p spack install -v --jobs "${SLURM_CPUS_PER_TASK}" --fail-fast --yes-to-all --reuse $(echo "${SPACK_SPEC}")
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack install failed.'
  exit 1
fi
sleep 30
