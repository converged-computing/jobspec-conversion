#!/bin/bash
#FLUX: --job-name=trilinos@13.0.1
#FLUX: -c=16
#FLUX: --queue=ind-shared
#FLUX: -t=3600
#FLUX: --priority=16

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
 # condition(1632)
 # condition(5851)
 # condition(6190)
 # dependency_condition(6190,"trilinos","hypre")
 # dependency_type(6190,"link")
 # hash("hypre","7xcmtpkwg3eg5vdx25ymchauzwodyccm")
 # imposed_constraint(6190,"variant_set","hypre","int64","False")
 # root("trilinos")
 # variant_condition(1632,"hypre","int64")
 # variant_condition(5851,"trilinos","hypre")
 # variant_set("trilinos","hypre","True")
declare -xr SPACK_PACKAGE='trilinos@13.0.1'
declare -xr SPACK_COMPILER='gcc@10.2.0'
declare -xr SPACK_VARIANTS='+adios2 +amesos +amesos2 +anasazi +aztec ~basker +belos +boost ~chaco ~complex ~cuda ~cuda_rdc ~debug ~dtk +epetra +epetraext ~epetraextbtf ~epetraextexperimental ~epetraextgraphreorderings ~exodus +explicit_template_instantiation ~float +fortran +gtest +hdf5 ~hypre +ifpack +ifpack2 ~intrepid ~intrepid2 ~ipo ~isorropia +kokkos ~mesquite ~minitensor +ml +mpi +muelu ~mumps ~nox ~openmp ~phalanx ~piro +python ~rol ~rythmos +sacado ~scorec ~shards +shared ~shylu ~stk ~stokhos ~stratimikos ~strumpack +suite-sparse ~superlu +superlu-dist ~teko ~tempus +tpetra ~trilinoscouplings ~wrapper ~x11 ~zoltan ~zoltan2'
declare -xr SPACK_DEPENDENCIES="^adios2@2.7.1/$(spack find --format '{hash:7}' adios2@2.7.1 % ${SPACK_COMPILER} +mpi ^openmpi@4.1.3) ^boost@1.77.0/$(spack find --format '{hash:7}' boost@1.77.0 % ${SPACK_COMPILER} ~mpi) ^hdf5@1.10.7/$(spack find --format '{hash:7}' hdf5@1.10.7 % ${SPACK_COMPILER} +mpi ^openmpi@4.1.3) ^parmetis@4.0.3/$(spack find --format '{hash:7}' parmetis@4.0.3 % ${SPACK_COMPILER} ^openmpi@4.1.3) ^superlu-dist@7.1.1/$(spack find --format '{hash:7}' superlu-dist@7.1.1 % ${SPACK_COMPILER} ~int64 ^openmpi@4.1.3)"
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
sleep 60
