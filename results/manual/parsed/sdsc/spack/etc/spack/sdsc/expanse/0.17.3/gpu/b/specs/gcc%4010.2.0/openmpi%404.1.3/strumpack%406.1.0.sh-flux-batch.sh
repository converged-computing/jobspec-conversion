#!/bin/bash
#FLUX: --job-name=strumpack@6.1.0
#FLUX: -c=10
#FLUX: --queue=ind-gpu-shared
#FLUX: -t=3600
#FLUX: --urgency=16

declare -xr LOCAL_TIME="$(date +'%Y%m%dT%H%M%S%z')"
declare -xir UNIX_TIME="$(date +'%s')"
declare -xr LOCAL_SCRATCH_DIR="/scratch/${USER}/job_${SLURM_JOB_ID}"
declare -xr TMPDIR="${LOCAL_SCRATCH_DIR}"
declare -xr SYSTEM_NAME='expanse'
declare -xr SPACK_VERSION='0.17.3'
declare -xr SPACK_INSTANCE_NAME='gpu'
declare -xr SPACK_INSTANCE_VERSION='b'
declare -xr SPACK_INSTANCE_DIR="/cm/shared/apps/spack/${SPACK_VERSION}/${SPACK_INSTANCE_NAME}/${SPACK_INSTANCE_VERSION}"
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
declare -xr SPACK_PACKAGE='strumpack@6.1.0'
declare -xr SPACK_COMPILER='gcc@10.2.0'
declare -xr SPACK_VARIANTS='+butterflypack +c_interface ~count_flops ~cuda ~ipo +mpi ~openmp +parmetis ~rocm ~scotch +shared +slate ~task_timers +zfp'
declare -xr SPACK_DEPENDENCIES="^butterflypack@2.0.0/$(spack find --format '{hash:7}' butterflypack@2.0.0 % ${SPACK_COMPILER} ^openmpi@4.1.3) ^slate@2021.05.02/$(spack find --format '{hash:7}' slate@2021.05.02 % ${SPACK_COMPILER} ^openmpi@4.1.3)"
declare -xr SPACK_SPEC="${SPACK_PACKAGE} % ${SPACK_COMPILER} ${SPACK_VARIANTS} $butterflypackNCIES}"
printenv
spack config get compilers  
spack config get config  
spack config get mirrors
spack config get modules
spack config get packages
spack config get repos
spack config get upstreams
time -p spack spec --long --namespaces --types "${SPACK_SPEC}"
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack concretization failed.'
  exit 1
fi
time -p spack install --jobs "${SLURM_CPUS_PER_TASK}" --fail-fast --yes-to-all "${SPACK_SPEC}"
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack install failed.'
  exit 1
fi
sleep 30
