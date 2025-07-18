#!/bin/bash
#FLUX: --job-name=openmpi@3.1.6
#FLUX: -c=16
#FLUX: --queue=ind-shared
#FLUX: -t=1800
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
declare -xr SPACK_PACKAGE='openmpi@3.1.6'
declare -xr SPACK_COMPILER='gcc@10.2.0'
declare -xr SPACK_VARIANTS='~atomics~cuda+cxx+cxx_exceptions~gpfs~internal-hwloc~java+legacylaunchers+lustre~memchecker+pmi+pmix+romio~rsh~singularity+static+vt+wrapper-rpath cuda_arch=none fabrics=verbs schedulers=slurm'
declare -xr SPACK_DEPENDENCIES='^lustre@2.12.8 ^slurm@21.08.8 ^rdma-core@28.0'
declare -xr SPACK_SPEC="${SPACK_PACKAGE} % ${SPACK_COMPILER} ${SPACK_VARIANTS} ${SPACK_DEPENDENCIES}"
printenv
spack config get compilers  
spack config get config  
spack config get mirrors
spack config get modules
spack config get packages
spack config get repos
spack config get upstreams
spack spec --long --namespaces --types openmpi@3.1.6 % gcc@10.2.0 ~atomics~cuda+cxx+cxx_exceptions~gpfs~internal-hwloc~java+legacylaunchers+lustre~memchecker+pmi+pmix+romio~rsh~singularity+static+vt+wrapper-rpath cuda_arch=none fabrics=verbs schedulers=slurm ^lustre@2.12.8 ^slurm@21.08.8 ^rdma-core@28.0
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack concretization failed.'
  exit 1
fi
time -p spack install --jobs "${SLURM_CPUS_PER_TASK}" --fail-fast --yes-to-all openmpi@3.1.6 % gcc@10.2.0 ~atomics~cuda+cxx+cxx_exceptions~gpfs~internal-hwloc~java+legacylaunchers+lustre~memchecker+pmi+pmix+romio~rsh~singularity+static+vt+wrapper-rpath cuda_arch=none fabrics=verbs schedulers=slurm ^lustre@2.12.8 ^slurm@21.08.8 ^rdma-core@28.0
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack install failed.'
  exit 1
fi
spack module lmod refresh --delete-tree -y
