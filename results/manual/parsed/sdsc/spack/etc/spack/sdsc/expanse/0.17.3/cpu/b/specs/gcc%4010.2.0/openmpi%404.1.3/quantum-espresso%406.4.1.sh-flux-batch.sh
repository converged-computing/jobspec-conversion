#!/bin/bash
#FLUX: --job-name=quantum-espresso@6.4.1
#FLUX: -c=16
#FLUX: --queue=ind-shared
#FLUX: -t=1800
#FLUX: --urgency=16

declare -xr LOCAL_TIME="$(date +'%Y%m%dT%H%M%S%z')"
declare -xir UNIX_TIME="$(date +'%s')"
declare -xr LOCAL_SCRATCH_DIR="/scratch/${USER}/job_${SLURM_JOB_ID}"
declare -xr TMPDIR="${LOCAL_SCRATCH_DIR}"
declare -xr SYSTEM_NAME='expanse'
declare -xr SPACK_VERSION='0.17.3'
declare -xr SPACK_INSTANCE_NAME='cpu'
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
declare -xr SPACK_PACKAGE='quantum-espresso@6.4.1'
declare -xr SPACK_COMPILER='gcc@10.2.0'
declare -xr SPACK_VARIANTS='~cmake ~elpa +environ ~epw ~ipo +mpi ~openmp +patch ~qmcpack +scalapack'
declare -xr SPACK_DEPENDENCIES="^openblas@0.3.18/$(spack find --format '{hash:7}' openblas@0.3.18 % ${SPACK_COMPILER} ~ilp64 threads=none) ^fftw@3.3.10/$(spack find --format '{hash:7}' fftw@3.3.10 % ${SPACK_COMPILER} ~mpi ~openmp) ^netlib-scalapack@2.1.0/$(spack find --format '{hash:7}' netlib-scalapack@2.1.0 % ${SPACK_COMPILER} ^openmpi@4.1.3)"
declare -xr SPACK_SPEC="${SPACK_PACKAGE} % ${SPACK_COMPILER} ${SPACK_VARIANTS} ${SPACK_DEPENDENCIES}"
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
