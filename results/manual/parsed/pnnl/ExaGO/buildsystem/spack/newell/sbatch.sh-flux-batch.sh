#!/bin/bash
#FLUX: --job-name=pusheena-pancake-4473
#FLUX: --priority=16

export MY_CLUSTER='newell'

exit() {
  # Clear all trap handlers so this isn't echo'ed multiple times, potentially
  # throwing off the CI script watching for this output
  trap - `seq 1 31`
  # If called without an argument, assume not an error
  local ec=${1:-0}
  # Echo the snippet the CI script is looking for
  echo BUILD_STATUS:${ec}
  # Actually exit with that code, although it won't matter in most cases, as CI
  # is only looking for the string 'BUILD_STATUS:N'
  builtin exit ${ec}
}
cleanup() {
  # Clear all trap handlers
  trap - `seq 1 31`
  # When 'trap' is invoked, each signal handler will be a curried version of
  # this function which has the first argument bound to the signal it's catching
  local sig=$1
  echo
  echo Exit code $2 caught in build script triggered by signal ${sig}.
  echo
  exit $2
}
export MY_CLUSTER=newell
cp /qfs/projects/earthshot/src/coinhsl-archive-2019.05.21.tar.gz . &&
. buildsystem/spack/load_spack.sh &&
spack -e $SPACKENV develop --no-clone --path=$(pwd) exago@develop &&
mkdir hiop_dev
spack -e $SPACKENV develop --clone --force FORCE --path=$(pwd)/hiop_dev hiop@develop &&
cd hiop_dev &&
git submodule update --init --recursive &&
cd - &&
./buildsystem/spack/configure_modules.sh 128
EXIT_CODE=$?
exit $EXIT_CODE
