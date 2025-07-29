#!/bin/bash
#FLUX: --job-name=vasp@6.4.0
#FLUX: -c=8
#FLUX: --queue=hotel-gpu
#FLUX: -t=1800
#FLUX: --urgency=16

declare -xr LOCAL_TIME="$(date +'%Y%m%dT%H%M%S%z')"
declare -xir UNIX_TIME="$(date +'%s')"
declare -xr SYSTEM_NAME='tscc'
declare -xr SPACK_VERSION='0.17.3'
declare -xr SPACK_INSTANCE_NAME='gpu'
declare -xr SPACK_INSTANCE_DIR="/cm/shared/apps/spack/${SPACK_VERSION}/${SPACK_INSTANCE_NAME}"
declare -xr SLURM_JOB_SCRIPT="$(scontrol show job ${SLURM_JOB_ID} | awk -F= '/Command=/{print $2}')"
declare -xr SLURM_JOB_MD5SUM="$(md5sum ${SLURM_JOB_SCRIPT})"
declare -xr SCHEDULER_MODULE='slurm'
declare -xr COMPILER_MODULE='nvhpc/21.3'
echo "${UNIX_TIME} ${SLURM_JOB_ID} ${SLURM_JOB_MD5SUM} ${SLURM_JOB_DEPENDENCY}" 
echo ""
cat "${SLURM_JOB_SCRIPT}"
module purge
module load "${SCHEDULER_MODULE}"
. "${SPACK_INSTANCE_DIR}/share/spack/setup-env.sh"
module use "${SPACK_ROOT}/share/spack/lmod/linux-rocky8-x86_64/Core"
module load "${COMPILER_MODULE}"
module load "${MPI_MODULE}"
declare -xr SPACK_PACKAGE='vasp@6.4.0'
declare -xr SPACK_COMPILER="nvhpc@21.3"
declare -xr SPACK_VARIANTS="+acc ~openmp +scalapack ~vaspsol"
declare -xr SPACK_DEPENDENCIES="^intel-mkl@2020.4.304 % ${SPACK_COMPILER}"
declare -xr SPACK_SPEC="${SPACK_PACKAGE} % ${SPACK_COMPILER} ${SPACK_VARIANTS} ${SPACK_DEPENDENCIES}"
printenv
spack config get compilers
spack config get config  
spack config get mirrors
spack config get modules
spack config get packages
spack config get repos
spack config get upstreams
spack spec --long --namespaces --types vasp@6.4.0 % nvhpc@21.3 +acc ~openmp +scalapack ~vaspsol "${SPACK_DEPENDENCIES}"
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack concretization failed.'
  exit 1
fi
time -p spack install -v --jobs 1 --fail-fast --yes-to-all vasp@6.4.0 % nvhpc@21.3 +acc ~openmp +scalapack  ~vaspsol "${SPACK_DEPENDENCIES}"
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack install failed.'
  exit 1
fi
spack module lmod refresh --delete-tree -y
sbatch --dependency="afterok:${SLURM_JOB_ID}" ''
sleep 20
