#!/bin/bash
#FLUX: --job-name=tau@2.30.2
#FLUX: -c=8
#FLUX: --queue=hotel-gpu
#FLUX: -t=1800
#FLUX: --urgency=16

declare -xr LOCAL_TIME="$(date +'%Y%m%dT%H%M%S%z')"
declare -xir UNIX_TIME="$(date +'%s')"
declare -xr SYSTEM_NAME='tscc'
declare -xr SPACK_VERSION='0.17.3'
declare -xr SPACK_INSTANCE_NAME='gpu'
declare -xr SPACK_INSTANCE_DIR="/home/jpg/cm/shared/apps/spack/${SPACK_VERSION}/${SPACK_INSTANCE_NAME}"
declare -xr SLURM_JOB_SCRIPT="$(scontrol show job ${SLURM_JOB_ID} | awk -F= '/Command=/{print $2}')"
declare -xr SLURM_JOB_MD5SUM="$(md5sum ${SLURM_JOB_SCRIPT})"
declare -xr SCHEDULER_MODULE='slurm/tscc/current'
echo "${UNIX_TIME} ${SLURM_JOB_ID} ${SLURM_JOB_MD5SUM} ${SLURM_JOB_DEPENDENCY}" 
echo ""
cat "${SLURM_JOB_SCRIPT}"
module purge
module load "${SCHEDULER_MODULE}"
module load ${SPACK_INSTANCE_NAME}
module load ${COMPILER_MODULE}
declare -xr COMPILER_MODULE='intel/19.1.1.217'
module list
. "${SPACK_INSTANCE_DIR}/share/spack/setup-env.sh"
declare -xr INTEL_LICENSE_FILE='40000@elprado.sdsc.edu:40200@elprado.sdsc.edu'
declare -xr SPACK_PACKAGE='tau@2.30.2'
declare -xr SPACK_COMPILER='intel@19.1.1.217'
declare -xr SPACK_VARIANTS='~adios2 +binutils ~comm ~craycnl ~cuda +elf +fortran ~gasnet +io ~level_zero +libdwarf +libunwind ~likwid +mpi ~ompt ~opari ~opencl ~openmp +otf2 +papi +pdt ~phase ~ppc64le ~profileparam +pthreads ~python ~rocm ~rocprofiler ~roctracer ~scorep ~shmem +sqlite ~x86_64'
declare -xr SPACK_DEPENDENCIES="^openmpi@4.1.3/$(spack find --format '{hash:7}' openmpi@4.1.3 % ${SPACK_COMPILER}) ^papi@6.0.0.1/$(spack find --format '{hash:7}' papi@6.0.0.1 % ${SPACK_COMPILER})"
declare -xr SPACK_SPEC="${SPACK_PACKAGE} % ${SPACK_COMPILER} ${SPACK_VARIANTS} ${SPACK_DEPENDENCIES}"
printenv
spack config get compilers
spack config get config  
spack config get mirrors
spack config get modules
spack config get packages
spack config get repos
spack config get upstreams
spack spec --long --namespaces --types "${SPACK_SPEC}"
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack concretization failed.'
  exit 1
fi
time -p spack install --jobs "${SLURM_CPUS_PER_TASK}" --fail-fast --yes-to-all "${SPACK_SPEC}"
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack install failed.'
  exit 1
fi
sleep 20
