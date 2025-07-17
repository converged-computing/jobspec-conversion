#!/bin/bash
#FLUX: --job-name=joyous-taco-9691
#FLUX: -n=4
#FLUX: -t=360000
#FLUX: --urgency=16

export PYTHONPATH='$EB_PREFIX/easybuild-framework:$EB_PREFIX/easybuild-easyblocks:$EB_PREFIX/easybuild-easyconfigs'
export PATH='$EB_PREFIX/easybuild-framework:$HOME/.local/bin:$PATH'
export EASYBUILD_PREFIX='$TOPDIR/$USER/Rocky8/zen2'
export EASYBUILD_BUILDPATH='/tmp/$USER'
export EASYBUILD_SOURCEPATH='$TOPDIR/$USER/sources'
export EASYBUILD_GITHUB_USER='boegelbot'
export EB_PYTHON='python3'
export EASYBUILD_ACCEPT_EULA_FOR='.*'
export EASYBUILD_HOOKS='$HOME/boegelbot/eb_hooks.py'
export EASYBUILD_OPTARCH='Intel:march=core-avx2'
export EASYBUILD_CUDA_COMPUTE_CAPABILITIES='7.0'
export EASYBUILD_SET_GID_BIT='1'
export EASYBUILD_UMASK='022'

set -e
TOPDIR="/project/def-maintainers"
module use $TOPDIR/$USER/Rocky8/zen2/modules/all
EB_PREFIX=$HOME/easybuild
export PYTHONPATH=$EB_PREFIX/easybuild-framework:$EB_PREFIX/easybuild-easyblocks:$EB_PREFIX/easybuild-easyconfigs
export PATH=$EB_PREFIX/easybuild-framework:$HOME/.local/bin:$PATH
export EASYBUILD_PREFIX=$TOPDIR/$USER/Rocky8/zen2
export EASYBUILD_BUILDPATH=/tmp/$USER
export EASYBUILD_SOURCEPATH=$TOPDIR/$USER/sources
export EASYBUILD_GITHUB_USER=boegelbot
export EB_PYTHON=python3
export EASYBUILD_ACCEPT_EULA_FOR='.*'
export EASYBUILD_HOOKS=$HOME/boegelbot/eb_hooks.py
export EASYBUILD_OPTARCH='Intel:march=core-avx2'
export EASYBUILD_CUDA_COMPUTE_CAPABILITIES=7.0
export EASYBUILD_SET_GID_BIT=1
export EASYBUILD_UMASK='022'
module use $EASYBUILD_PREFIX/modules/all
eb --from-pr $EB_PR --debug --rebuild --robot --upload-test-report --download-timeout=1000 $EB_ARGS
