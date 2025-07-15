#!/bin/bash
#FLUX: --job-name=angry-cupcake-7202
#FLUX: --urgency=16

export SPACK_ROOT='${INSTALL_DIR}/spack'
export SPACK_DISABLE_LOCAL_CONFIG='true'
export SPACK_USER_CACHE_PATH='${SPACK_ROOT}/var/spack/user_cache'
export SPACK_USER_CONFIG_PATH='${SPACK_ROOT}/var/spack/user_config'

TYPE=software
DATE=2022-10
set -e
cmd() {
  echo "+ $@";
  eval "$@";
}
printf "============================================================\n"
printf "$(date)\n"
printf "============================================================\n"
printf "Job is running on ${HOSTNAME}\n"
printf "============================================================\n"
case "${NREL_CLUSTER}" in
  eagle)
    MACHINE=eagle
  ;;
esac
MYHOSTNAME=$(hostname -s)
case "${MYHOSTNAME}" in
  rhodes)
    MACHINE=rhodes
  ;;
esac
case "${NREL_CLUSTER}" in
  ellis)
    MACHINE=ellis
  ;;
esac
if [ "${MACHINE}" == 'eagle' ]; then
  BASE_DIR=/nopt/nrel/ecom/hpacf
elif [ "${MACHINE}" == 'rhodes' ]; then
  BASE_DIR=/opt
elif [ "${MACHINE}" == 'ellis' ]; then
  BASE_DIR=/projects/hpacf/apps
else
  printf "\nMachine name not recognized.\n"
  exit 1
fi
INSTALL_DIR=${BASE_DIR}/${TYPE}/${DATE}
if [ "${TYPE}" == 'base' ]; then
  GCC_COMPILER_VERSION=4.8.5
  if [ "${MACHINE}" == 'eagle' ]; then
    CPU_OPT=haswell
    HOST_OS=centos7
  elif [ "${MACHINE}" == 'rhodes' ]; then
    CPU_OPT=haswell
    HOST_OS=centos7
  elif [ "${MACHINE}" == 'ellis' ]; then
    CPU_OPT=zen
    HOST_OS=rocky8
    GCC_COMPILER_VERSION=8.5.0
  fi
elif [ "${TYPE}" == 'compilers' ] || [ "${TYPE}" == 'utilities' ] || [ "${TYPE}" == 'software' ]; then
  GCC_COMPILER_VERSION=8.5.0
  if [ "${MACHINE}" == 'eagle' ]; then
    HOST_OS=centos7
    CPU_OPT=skylake_avx512
  elif [ "${MACHINE}" == 'rhodes' ]; then
    HOST_OS=centos7
    CPU_OPT=broadwell
  elif [ "${MACHINE}" == 'ellis' ]; then
    CPU_OPT=zen
    HOST_OS=rocky8
  fi
fi
GCC_COMPILER_MODULE=gcc/${GCC_COMPILER_VERSION}
INTEL_COMPILER_VERSION=20.0.4
INTEL_COMPILER_MODULE=intel-parallel-studio/cluster.2020.4
CLANG_COMPILER_VERSION=15.0.2
CLANG_COMPILER_MODULE=llvm/${CLANG_COMPILER_VERSION}
THIS_REPO_DIR=$(pwd)/..
export SPACK_ROOT=${INSTALL_DIR}/spack
export SPACK_DISABLE_LOCAL_CONFIG=true
export SPACK_USER_CACHE_PATH=${SPACK_ROOT}/var/spack/user_cache
export SPACK_USER_CONFIG_PATH=${SPACK_ROOT}/var/spack/user_config
if [ ! -d "${INSTALL_DIR}" ]; then
  printf "============================================================\n"
  printf "Install directory doesn't exist.\n"
  printf "Creating everything from scratch...\n"
  printf "============================================================\n"
  printf "Creating top level install directory...\n"
  cmd "mkdir -p ${INSTALL_DIR}"
  printf "\nCloning Spack repo...\n"
  cmd "git clone https://github.com/spack/spack.git ${SPACK_ROOT}"
  cmd "cd ${SPACK_ROOT} && git checkout 560a9eec920e1fba3d334c6506d193aa8d9cb098 && cd -"
  printf "\nConfiguring Spack...\n"
  cmd "cd ${THIS_REPO_DIR}/scripts && ./setup-spack.sh"
  cmd "cp ${THIS_REPO_DIR}/configs/${MACHINE}/${TYPE}/compilers.yaml ${SPACK_ROOT}/etc/spack/"
  cmd "cp ${THIS_REPO_DIR}/configs/${MACHINE}/${TYPE}/modules.yaml ${SPACK_ROOT}/etc/spack/"
  cmd "cp ${THIS_REPO_DIR}/configs/${MACHINE}/${TYPE}/upstreams.yaml ${SPACK_ROOT}/etc/spack/ || true"
  if [ "${TYPE}" == 'compilers' ] || [ "${TYPE}" == 'base' ]; then
    cmd "rm -f ${SPACK_ROOT}/etc/spack/upstreams.yaml || true"
  fi
  cmd "mkdir -p ${SPACK_ROOT}/etc/spack/licenses/intel"
  if [ "${MACHINE}" != 'ellis' ]; then
    cmd "cp ${HOME}/save/license.lic ${SPACK_ROOT}/etc/spack/licenses/intel/"
  fi
  cmd "source ${SPACK_ROOT}/share/spack/setup-env.sh"
  cmd "spack env create ${TYPE}"
  cmd "cp ${THIS_REPO_DIR}/configs/${MACHINE}/${TYPE}/spack.yaml ${SPACK_ROOT}/var/spack/environments/${TYPE}/spack.yaml"
  printf "============================================================\n"
  printf "Done setting up install directory.\n"
  printf "============================================================\n"
else
  printf "\nLoading Spack...\n"
  cmd "source ${SPACK_ROOT}/share/spack/setup-env.sh"
fi
cmd "module purge"
cmd "module unuse ${MODULEPATH}"
if [ "${TYPE}" != 'software' ]; then
  cmd "module use ${BASE_DIR}/compilers/modules"
  cmd "module use ${BASE_DIR}/utilities/modules"
elif [ "${TYPE}" == 'software' ]; then
  cmd "module use ${BASE_DIR}/compilers/modules-${DATE}"
  cmd "module use ${BASE_DIR}/utilities/modules-${DATE}"
fi
cmd "module load binutils"
cmd "source ${SPACK_ROOT}/share/spack/setup-env.sh"
cmd "spack compilers"
cmd "spack arch"
if [ "${MACHINE}" == 'eagle' ]; then
  printf "\nMaking and setting TMPDIR to disk...\n"
  cmd "mkdir -p /scratch/${USER}/.tmp"
  cmd "export TMPDIR=/scratch/${USER}/.tmp"
fi
printf "\nInstalling ${TYPE}...\n"
cmd "spack env activate ${TYPE}"
  #cmd "spack install --deprecated --fresh" #&
cmd "spack module tcl refresh -y"
printf "\nDone installing ${TYPE} at $(date).\n"
printf "\nCreating dated modules symlink...\n"
cmd "cd ${INSTALL_DIR}/.. && ln -sf ${DATE}/spack/share/spack/modules/linux-${HOST_OS}-zen2 modules-${DATE} && cd -"
cmd "cd ${INSTALL_DIR}/.. && ln -sf ${DATE}/spack/share/spack/modules/linux-${HOST_OS}-zen2 modules && cd -"
printf "\n$(date)\n"
printf "\nDone!\n"
