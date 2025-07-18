#!/bin/bash
#FLUX: --job-name=expensive-hope-3830
#FLUX: -n=4
#FLUX: -t=360000
#FLUX: --urgency=16

export PYTHONPATH='$EB_PREFIX/easybuild-framework:$EB_PREFIX/easybuild-easyblocks:$EB_PREFIX/easybuild-easyconfigs'
export PATH='$EB_PREFIX/easybuild-framework:$HOME/.local/bin:$PATH'
export EASYBUILD_PREFIX='$TOPDIR/$USER/Rocky8/haswell'
export EASYBUILD_BUILDPATH='/tmp/$USER'
export EASYBUILD_SOURCEPATH='$TOPDIR/$USER/sources:$TOPDIR/maintainers/sources'
export EASYBUILD_GITHUB_USER='boegelbot'
export EB_PYTHON='python3'
export EASYBUILD_ACCEPT_EULA_FOR='.*'
export EASYBUILD_HOOKS='$HOME/boegelbot/eb_hooks.py'
export EASYBUILD_CUDA_COMPUTE_CAPABILITIES='7.0'
export INTEL_LICENSE_FILE='$TOPDIR/maintainers/licenses/intel.lic'

set -e
TOPDIR="/project"
EB_PREFIX=$HOME/easybuild
export PYTHONPATH=$EB_PREFIX/easybuild-framework:$EB_PREFIX/easybuild-easyblocks:$EB_PREFIX/easybuild-easyconfigs
export PATH=$EB_PREFIX/easybuild-framework:$HOME/.local/bin:$PATH
export EASYBUILD_PREFIX=$TOPDIR/$USER/Rocky8/haswell
export EASYBUILD_BUILDPATH=/tmp/$USER
export EASYBUILD_SOURCEPATH=$TOPDIR/$USER/sources:$TOPDIR/maintainers/sources
export EASYBUILD_GITHUB_USER=boegelbot
export EB_PYTHON=python3
export EASYBUILD_ACCEPT_EULA_FOR='.*'
export EASYBUILD_HOOKS=$HOME/boegelbot/eb_hooks.py
export EASYBUILD_CUDA_COMPUTE_CAPABILITIES=7.0
export INTEL_LICENSE_FILE=$TOPDIR/maintainers/licenses/intel.lic
module use $EASYBUILD_PREFIX/modules/all
eb --from-pr $EB_PR --debug --rebuild --robot --upload-test-report --download-timeout=1000 $EB_ARGS
