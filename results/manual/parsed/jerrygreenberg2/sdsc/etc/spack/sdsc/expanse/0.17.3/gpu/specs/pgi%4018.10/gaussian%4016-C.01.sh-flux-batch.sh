#!/bin/bash
#FLUX: --job-name=gaussian@16-C.01
#FLUX: -c=10
#FLUX: --queue=ind-gpu-shared
#FLUX: -t=3600
#FLUX: --priority=16

declare -xr LOCAL_TIME="$(date +'%Y%m%dT%H%M%S%z')"
declare -xir UNIX_TIME="$(date +'%s')"
declare -xr SYSTEM_NAME='expanse'
declare -xr SPACK_VERSION='0.17.3'
declare -xr SPACK_INSTANCE_NAME='gpu'
declare -xr SPACK_INSTANCE_DIR="${HOME}/cm/shared/apps/spack/${SPACK_VERSION}/${SPACK_INSTANCE_NAME}"
declare -xr TMPDIR="${LOCAL_SCRATCH_DIR}/spack-stage"
declare -xt TMP="${TMPDIR}"
declare -xr SLURM_JOB_SCRIPT="$(scontrol show job ${SLURM_JOB_ID} | awk -F= '/Command=/{print $2}')"
declare -xr SLURM_JOB_MD5SUM="$(md5sum ${SLURM_JOB_SCRIPT})"
declare -xr SCHEDULER_MODULE='slurm'
declare -xr COMPILER_MODULE='pgi/18.10'
declare -xr CUDA_MODULE='cuda/10.0.130'
echo "${UNIX_TIME} ${SLURM_JOB_ID} ${SLURM_JOB_MD5SUM} ${SLURM_JOB_DEPENDENCY}" 
echo ""
cat "${SLURM_JOB_SCRIPT}"
module purge
module load "${SCHEDULER_MODULE}"
. "${SPACK_INSTANCE_DIR}/share/spack/setup-env.sh"
module use "${SPACK_ROOT_DIR}/share/spack/lmod/linux-rocky8-x86_64/Core"
module load "${COMPILER_MODULE}"
module load "${CUDA_MODULE}"
module list
declare -xr PGROUPD_LICENSE_FILE='40000@elprado.sdsc.edu:40200@elprado.sdsc.edu'
declare -xr LM_LICENSE_FILE='40000@elprado.sdsc.edu:40200@elprado.sdsc.edu'
declare -xr SPACK_PACKAGE='gaussian@16-C.01' # 16-C.02 supports cuda_arch=80
declare -xr SPACK_COMPILER='pgi@18.10'
declare -xr SPACK_VARIANTS='~binary +cuda cuda_arch=70'
declare -xr SPACK_DEPENDENCIES="^cuda@10.0.130/$(spack find --format '{hash:7}' cuda@10.0.130 % ${SPACK_COMPILER})"
declare -xr SPACK_SPEC="${SPACK_PACKAGE} % ${SPACK_COMPILER} ${SPACK_VARIANTS} ${SPACK_DEPENDENCIES}"
printenv
spack config get compilers
spack config get config  
spack config get mirrors
spack config get modules
spack config get packages
spack config get repos
spack config get upstreams
spack spec --long --namespaces --types gaussian@16-C.01 % pgi@18.10 ~binary +cuda cuda_arch=70 "${SPACK_DEPENDENCIES}"
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack concretization failed.'
  exit 1
fi
time -p spack install --jobs "${SLURM_CPUS_PER_TASK}" --fail-fast --yes-to-all gaussian@16-C.01 % pgi@18.10 ~binary +cuda cuda_arch=70 "${SPACK_DEPENDENCIES}"
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack install failed.'
  exit 1
fi
spack module lmod refresh --delete-tree -y
sleep 60
