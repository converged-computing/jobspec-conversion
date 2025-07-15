#!/bin/bash
#FLUX: --job-name=svr
#FLUX: -N=12
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --priority=16

export LAUNCHER_WORKDIR='~/bathymetry'
export LAUNCHER_JOB_FILE='svr-job-file.txt'

spack --color=never env activate ~/bathymetry
module load launcher
export LAUNCHER_WORKDIR=~/bathymetry
export LAUNCHER_JOB_FILE=svr-job-file.txt
${LAUNCHER_DIR}/paramrun
