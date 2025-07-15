#!/bin/bash
#FLUX: --job-name=quantum-espresso@7.0
#FLUX: -c=16
#FLUX: --queue=ind-shared
#FLUX: -t=172800
#FLUX: --urgency=16

declare -xr LOCAL_TIME="$(date +'%Y%m%dT%H%M%S%z')"
declare -xir UNIX_TIME="$(date +'%s')"
declare -xr SYSTEM_NAME='expanse'
declare -xr SPACK_VERSION='0.17.2'
declare -xr SPACK_INSTANCE_NAME='cpu'
declare -xr SPACK_INSTANCE_DIR="/cm/shared/apps/spack/${SPACK_VERSION}/${SPACK_INSTANCE_NAME}"
declare -xr SLURM_JOB_SCRIPT="$(scontrol show job ${SLURM_JOB_ID} | awk -F= '/Command=/{print $2}')"
declare -xr SLURM_JOB_MD5SUM="$(md5sum ${SLURM_JOB_SCRIPT})"
declare -xr SCHEDULER_MODULE='slurm'
echo "${UNIX_TIME} ${SLURM_JOB_ID} ${SLURM_JOB_MD5SUM} ${SLURM_JOB_DEPENDENCY}" 
echo ""
cat "${SLURM_JOB_SCRIPT}"
module purge
module load "${SCHEDULER_MODULE}"
module list
. "${SPACK_INSTANCE_DIR}/share/spack/setup-env.sh"
declare -xr SPACK_PACKAGE='quantum-espresso@7.0'
declare -xr SPACK_COMPILER='aocc@3.2.0'
declare -xr SPACK_VARIANTS='~cmake ~elpa ~environ hdf5=parallel +epw ~ipo ~libxc +mpi +openmp +patch ~qmcpack +scalapack'
declare -xr SPACK_DEPENDENCIES="^hdf5@1.10.7/$(spack find --format '{hash:7}' hdf5@1.10.7 % ${SPACK_COMPILER} +mpi ^openmpi@4.1.3) ^amdlibflame@3.1/$(spack find --format '{hash:7}' amdlibflame@3.1 % ${SPACK_COMPILER} ~ilp64 threads=none ^amdblis@3.1 ~ilp64 threads=openmp) ^amdfftw@3.1/$(spack find --format '{hash:7}' amdfftw@3.1 % ${SPACK_COMPILER} ~mpi +openmp) ^amdscalapack@3.1/$(spack find --format '{hash:7}' amdscalapack@3.1 % ${SPACK_COMPILER})"
declare -xr SPACK_SPEC="${SPACK_PACKAGE} % ${SPACK_COMPILER} ${SPACK_VARIANTS} ${SPACK_DEPENDENCIES}"
printenv
spack config get compilers
spack config get config  
spack config get mirrors
spack config get modules
spack config get packages
spack config get repos
spack config get upstreams
spack --show-cores=minimized spec --long --namespaces --types quantum-espresso@7.0 % aocc@3.2.0 ~cmake ~elpa ~environ hdf5=parallel +epw ~ipo +libxc +mpi +openmp +patch ~qmcpack +scalapack "^hdf5@1.10.7/$(spack find --format '{hash:7}' hdf5@1.10.7 % ${SPACK_COMPILER} +mpi ^openmpi@4.1.3) ^amdlibflame@3.1/$(spack find --format '{hash:7}' amdlibflame@3.1 % ${SPACK_COMPILER} ~ilp64 threads=none ^amdblis@3.1 ~ilp64 threads=openmp) ^amdfftw@3.1/$(spack find --format '{hash:7}' amdfftw@3.1 % ${SPACK_COMPILER} ~mpi +openmp) ^amdscalapack@3.1/$(spack find --format '{hash:7}' amdscalapack@3.1 % ${SPACK_COMPILER} ^amdblis@3.1 ~ilp64 threads=openmp)"
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack concretization failed.'
  exit 1
fi
time -p spack install --jobs "${SLURM_CPUS_PER_TASK}" --fail-fast --yes-to-all quantum-espresso@7.0 % aocc@3.2.0 ~cmake ~elpa ~environ hdf5=parallel +epw ~ipo +libxc +mpi +openmp +patch ~qmcpack +scalapack "^hdf5@1.10.7/$(spack find --format '{hash:7}' hdf5@1.10.7 % ${SPACK_COMPILER} +mpi ^openmpi@4.1.3) ^amdlibflame@3.1/$(spack find --format '{hash:7}' amdlibflame@3.1 % ${SPACK_COMPILER} ~ilp64 threads=none ^amdblis@3.1 ~ilp64 threads=openmp) ^amdfftw@3.1/$(spack find --format '{hash:7}' amdfftw@3.1 % ${SPACK_COMPILER} ~mpi +openmp) ^amdscalapack@3.1/$(spack find --format '{hash:7}' amdscalapack@3.1 % ${SPACK_COMPILER} ^amdblis@3.1 ~ilp64 threads=openmp)"
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack install failed.'
  exit 1
fi
spack module lmod refresh --delete-tree -y
sleep 60
