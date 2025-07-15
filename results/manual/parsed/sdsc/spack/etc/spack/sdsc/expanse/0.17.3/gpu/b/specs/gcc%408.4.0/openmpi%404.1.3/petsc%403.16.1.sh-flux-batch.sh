#!/bin/bash
#FLUX: --job-name=petsc@3.16.1
#FLUX: -c=10
#FLUX: --queue=ind-gpu-shared
#FLUX: -t=1800
#FLUX: --priority=16

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
------------------------------------------------------------------------------
declare -xr SPACK_PACKAGE='petsc@3.16.1'
declare -xr SPACK_COMPILER='gcc@8.4.0'
declare -xr SPACK_VARIANTS='~X ~batch ~cgns ~complex +cuda cuda_arch=70 ~debug +double ~exodusii +fftw ~giflib +hdf5 ~hpddm ~hwloc +hypre ~int64 ~jpeg ~knl ~libpng ~libyaml ~memkind +metis ~mkl-pardiso ~mmg ~moab ~mpfr +mpi +mumps ~p4est ~parmmg +ptscotch ~random123 ~rocm ~saws +scalapack +shared ~strumpack ~suite-sparse +superlu-dist ~tetgen ~trilinos ~valgrind'
declare -xr SPACK_DEPENDENCIES="^openblas@0.3.18/$(spack find --format '{hash:7}' openblas@0.3.18 % ${SPACK_COMPILER} ~ilp64 threads=none) ^fftw@3.3.10/$(spack find --format '{hash:7}' fftw@3.3.10 % ${SPACK_COMPILER} +mpi ^openmpi@4.1.3) ^hdf5@1.10.7/$(spack find --format '{hash:7}' hdf5@1.10.7 % ${SPACK_COMPILER} +mpi ^openmpi@4.1.3) ^hypre@2.23.0/$(spack find --format '{hash:7}' hypre@2.23.0 % ${SPACK_COMPILER} ~int64 +mpi ^openmpi@4.1.3) ^mumps@5.4.0/$(spack find --format '{hash:7}' mumps@5.4.0 % ${SPACK_COMPILER} ~int64 +mpi ^openmpi@4.1.3) ^superlu-dist@7.1.1/$(spack find --format '{hash:7}' superlu-dist@7.1.1 % ${SPACK_COMPILER} ~int64 ^openmpi@4.1.3)"
declare -xr SPACK_SPEC="${SPACK_PACKAGE} % ${SPACK_COMPILER} ${SPACK_VARIANTS} ${SPACK_DEPENDENCIES}"
printenv
spack config get compilers  
spack config get config  
spack config get mirrors
spack config get modules
spack config get packages
spack config get repos
spack config get upstreams
time -p spack spec --long --namespaces --types --reuse $(echo "${SPACK_SPEC}")
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack concretization failed.'
  exit 1
fi
time -p spack install --jobs "${SLURM_CPUS_PER_TASK}" --fail-fast --yes-to-all --reuse $(echo "${SPACK_SPEC}")
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack install failed.'
  exit 1
fi
sbatch --dependency="afterok:${SLURM_JOB_ID}" 'slepc@3.16.0.sh'
sleep 30
