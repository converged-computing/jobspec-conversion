#!/bin/bash
#FLUX: --job-name=lammps@20210310
#FLUX: -c=8
#FLUX: --queue=hotel-gpu
#FLUX: -t=172800
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
declare -xr COMPILER_MODULE='gcc/10.2.0'
declare -xr MPI_MODULE='intel-mpi@2019.10.317'
declare -xr CUDA_MODULE='cuda/11.5.0'
echo "${UNIX_TIME} ${SLURM_JOB_ID} ${SLURM_JOB_MD5SUM} ${SLURM_JOB_DEPENDENCY}" 
echo ""
cat "${SLURM_JOB_SCRIPT}"
module purge
module load "${SCHEDULER_MODULE}"
. "${SPACK_INSTANCE_DIR}/share/spack/setup-env.sh"
module use "${SPACK_ROOT}/share/spack/lmod/linux-rocky9-x86_64/Core"
module load "${SPACK_INSTANCE_NAME}"
module load "${COMPILER_MODULE}"
module load "${MPI_MODULE}"
module load "${CUDA_MODULE}"
module list
declare -xr CUDA_CUDA_LIBRARY='/cm/local/apps/cuda/libs/current/lib64'
declare -xr CMAKE_LIBRARY_PATH="${CUDA_CUDA_LIBRARY}"
declare -xr SPACK_PACKAGE='lammps@20210310'
declare -xr SPACK_COMPILER='gcc@10.2.0'
declare -xr SPACK_VARIANTS='+asphere +body +class2 +colloid +compress +coreshell +cuda cuda_arch=60,75,80,86 +dipole ~exceptions +ffmpeg +granular ~ipo +jpeg +kim +kokkos +kspace ~latte +lib +manybody +mc ~meam +misc +mliap +molecule +mpi +mpiio ~opencl +openmp +opt +peri +png +poems +python +qeq +replica +rigid +shock +snap +spin +srd ~user-adios +user-atc +user-awpmd +user-bocs +user-cgsdk +user-colvars +user-diffraction +user-dpd +user-drude +user-eff +user-fep ~user-h5md +user-lb +user-manifold +user-meamc +user-mesodpd +user-mesont +user-mgpt +user-misc +user-mofff ~user-netcdf ~user-omp +user-phonon +user-plumed +user-ptm +user-qtb +user-reaction +user-reaxc +user-sdpd +user-smd +user-smtbq +user-sph +user-tally +user-uef +user-yaff +voronoi'
declare -xr SPACK_DEPENDENCIES="^openblas@0.3.17/$(spack find --format '{hash:7}' openblas@0.3.17 % ${SPACK_COMPILER} ~ilp64 threads=none) ^fftw@3.3.10/$(spack find --format '{hash:7}' fftw@3.3.10 % ${SPACK_COMPILER} ~mpi ~openmp)  ^kokkos@3.4.01/$(spack find --format '{hash:7}' kokkos@3.4.01 % ${SPACK_COMPILER} ^kokkos-nvcc-wrapper +mpi ^intel-mpi) ^ffmpeg@4.3.2/$(spack find --format '{hash:7}' ffmpeg@4.3.2 % ${SPACK_COMPILER}) ^plumed@2.6.3/$(spack find --format '{hash:7}' plumed@2.6.3 % ${SPACK_COMPILER} +mpi ^intel-mpi@2019.10.317) ^python@3.8.12/$(spack find --format '{hash:7}' python@3.8.12 % ${SPACK_COMPILER}) ^cmake@3.21.4/$(spack find --format '{hash:7}' cmake@3.21.4 % ${SPACK_COMPILER})  ^curl@7.79.0/$(spack find --format '{hash:7}' curl@7.79.0 % ${SPACK_COMPILER})"
declare -xr SPACK_SPEC="${SPACK_PACKAGE} % ${SPACK_COMPILER} ${SPACK_VARIANTS} ${SPACK_DEPENDENCIES}"
echo ${SPACK_SPEC} > spec.$$
printenv
spack config get compilers
spack config get config  
spack config get mirrors
spack config get modules
spack config get packages
spack config get repos
spack config get upstreams
spack spec --long --namespaces --types `cat spec.$$`
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack concretization failed.'
  exit 1
fi
time -p spack install -v --jobs "${SLURM_CPUS_PER_TASK}" --fail-fast --yes-to-all `cat spec.$$`
rm spec.$$
if [[ "${?}" -ne 0 ]]; then
  echo 'ERROR: spack install failed.'
  exit 1
fi
spack module lmod refresh --delete-tree -y
sbatch --dependency="afterok:${SLURM_JOB_ID}" ''
sleep 20
