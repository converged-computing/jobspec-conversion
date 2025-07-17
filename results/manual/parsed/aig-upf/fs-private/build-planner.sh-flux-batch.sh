#!/bin/bash
#FLUX: --job-name=build-planner
#FLUX: --queue=short
#FLUX: -t=3600
#FLUX: --urgency=16

export LIBRARY_PATH='$LIBRARY_PATH:${HOME}/local/lib'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:${HOME}/local/lib'

module purge
LMOD_DISABLE_SAME_NAME_AUTOSWAP=no module load Boost/1.65.1-foss-2017a-Python-3.6.4
LMOD_DISABLE_SAME_NAME_AUTOSWAP=no module load SCons/3.0.1-foss-2017a-Python-3.6.4
source /homedtic/gfrances/lib/virtualenvs/fs-sdd/bin/activate
export LIBRARY_PATH=$LIBRARY_PATH:${HOME}/local/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${HOME}/local/lib
cd "/homedtic/gfrances/projects/code/fs-sdd"
"/homedtic/gfrances/lib/virtualenvs/fs-sdd/bin/python" "./build.py" "-p"
