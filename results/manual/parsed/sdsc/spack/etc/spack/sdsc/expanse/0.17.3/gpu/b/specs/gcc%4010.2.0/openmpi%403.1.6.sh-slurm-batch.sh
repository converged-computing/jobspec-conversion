#!/bin/bash
#FLUX: --job-name=openmpi@3.1.6
#FLUX: -c=10
#FLUX: --queue=ind-gpu-shared
#FLUX: -t=172800
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
declare -xr SPACK_PACKAGE='openmpi@3.1.6'
declare -xr SPACK_COMPILER='gcc@10.2.0'
declare -xr SPACK_VARIANTS='~atomics +cuda cuda_arch=70,80 +cxx +cxx_exceptions ~gpfs ~internal-hwloc ~java +legacylaunchers ~lustre ~memchecker +pmi +pmix +romio ~rsh ~singularity +static +vt +wrapper-rpath fabrics=verbs schedulers=slurm'
declare -xr SPACK_DEPENDENCIES="^slurm@21.08.8 ^rdma-core@43.0 ^cuda@11.2.2/$(spack find --format '{hash:7}' cuda@11.2.2 % ${SPACK_COMPILER})"
declare -xr SPACK_SPEC="${SPACK_PACKAGE} % ${SPACK_COMPILER} ${SPACK_VARIANTS} ${SPACK_DEPENDENCIES}"
printenv
spack config get compilers  
spack config get config  
spack config get mirrors
spack config get modules
spack config get repos
spack config get upstreams
time -p spack spec --long --namespaces --types openmpi@3.1.6 % gcc@10.2.0 ~atomics +cuda cuda_arch=70,80 +cxx +cxx_exceptions ~gpfs~internal-hwloc ~java +legacylaunchers ~lustre ~memchecker +pmi +pmix +romio ~rsh ~singularity +static +vt +wrapper-rpath fabrics=verbs schedulers=slurm "${SPACK_DEPENDENCIES}"
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack concretization failed.'
  exit 1
fi
sleep 30
