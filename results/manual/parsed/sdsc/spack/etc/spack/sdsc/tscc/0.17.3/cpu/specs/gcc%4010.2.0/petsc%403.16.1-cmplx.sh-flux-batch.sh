#!/bin/bash
#FLUX: --job-name=petsc@3.16.1-cmplx
#FLUX: -c=8
#FLUX: --queue=hotel
#FLUX: -t=1800
#FLUX: --urgency=16

declare -xr LOCAL_TIME="$(date +'%Y%m%dT%H%M%S%z')"
declare -xir UNIX_TIME="$(date +'%s')"
declare -xr SYSTEM_NAME='tscc'
declare -xr SPACK_VERSION='0.17.3'
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
declare -xr SPACK_PACKAGE='petsc@3.16.1'
declare -xr SPACK_COMPILER='gcc@10.2.0'
declare -xr SPACK_VARIANTS='~X ~batch ~cgns +complex ~cuda ~debug +double ~exodusii ~fftw ~giflib ~hdf5 ~hpddm ~hwloc ~hypre ~int64 ~jpeg ~knl ~libpng ~libyaml ~memkind +metis ~mkl-pardiso ~mmg ~moab ~mpfr ~mpi ~mumps ~openmp ~p4est ~parmmg ~ptscotch ~random123 ~rocm ~saws ~scalapack +shared ~suite-sparse ~superlu-dist ~tetgen ~trilinos ~valgrind'
declare -xr SPACK_DEPENDENCIES="^python@3.8.12/$(spack find --format '{hash:7}' python@3.8.12 % ${SPACK_COMPILER}) ^openblas@0.3.17/$(spack find --format '{hash:7}' openblas@0.3.17 % ${SPACK_COMPILER} ~ilp64 threads=none) ^metis@5.1.0/$(spack find --format '{hash:7}' metis@5.1.0 % ${SPACK_COMPILER})"
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
spack module lmod refresh --delete-tree -y
sbatch --dependency="afterok:${SLURM_JOB_ID}" 'slepc@3.16.0.sh'
sleep 20
