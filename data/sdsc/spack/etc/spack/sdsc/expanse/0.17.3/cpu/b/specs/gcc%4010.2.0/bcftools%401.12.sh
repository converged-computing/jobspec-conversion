#!/usr/bin/env bash

#SBATCH --job-name=bcftools@1.12
#SBATCH --account=use300
#SBATCH --reservation=rocky8u7_testing
#SBATCH --partition=ind-shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=48:00:00
#SBATCH --output=%x.o%j.%N

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

# condition(4536)
#  hash("py-matplotlib","sq3nm3dje2kwhpzu3raopbthrsru67i7")
#  imposed_constraint("7pgfevds7qur5drimyoyv2f7xxaj4eyf","hash","sqlite","jgocl7xy6xkcmfuc4dhb2vqup6twposr")
#  imposed_constraint("jgocl7xy6xkcmfuc4dhb2vqup6twposr","node","sqlite")
#  imposed_constraint("sq3nm3dje2kwhpzu3raopbthrsru67i7","hash","py-python-dateutil","7pgfevds7qur5drimyoyv2f7xxaj4eyf")
#  variant_condition(4536,"sqlite","rtree")
#  variant_set("sqlite","rtree","False")

declare -xr SPACK_PACKAGE='bcftools@1.12'
declare -xr SPACK_COMPILER='gcc@10.2.0'
declare -xr SPACK_VARIANTS='+libgsl +perl-filters'
declare -xr SPACK_DEPENDENCIES="^gsl@2.7/$(spack find --format '{hash:7}' gsl@2.7 % ${SPACK_COMPILER}) ^htslib@1.12/$(spack find --format '{hash:7}' htslib@1.12 % ${SPACK_COMPILER}) ^py-matplotlib@3.4.3/$(spack find --format '{hash:7}' py-matplotlib@3.4.3 % ${SPACK_COMPILER})"
declare -xr SPACK_SPEC="${SPACK_PACKAGE} % ${SPACK_COMPILER} ${SPACK_VARIANTS} ${SPACK_DEPENDENCIES}"

printenv

spack config get compilers  
spack config get config  
spack config get mirrors
spack config get modules
spack config get packages
spack config get repos
spack config get upstreams

spack --show-cores=minimized spec --long --namespaces --types "${SPACK_SPEC}"
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack concretization failed.'
  exit 1
fi

time -p spack install --jobs "${SLURM_CPUS_PER_TASK}" --fail-fast --yes-to-all "${SPACK_SPEC}"
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack install failed.'
  exit 1
fi

#spack module lmod refresh --delete-tree -y

sbatch --dependency="afterok:${SLURM_JOB_ID}" 'samtools@1.13.sh'

sleep 30
