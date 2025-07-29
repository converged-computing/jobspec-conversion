#!/bin/bash
#FLUX: --job-name=Launcher
#FLUX: -N=2
#FLUX: -n=128
#FLUX: -t=3600
#FLUX: --urgency=16

export LAUNCHER_RMI='SLURM'
export LAUNCHER_WORKDIR='/home/easybuild/launcher_test'
export LAUNCHER_JOB_FILE='helloworld_multi'

module load launcher
export LAUNCHER_RMI=SLURM
export LAUNCHER_WORKDIR=/home/easybuild/launcher_test
export LAUNCHER_JOB_FILE=helloworld_multi
paramrun
