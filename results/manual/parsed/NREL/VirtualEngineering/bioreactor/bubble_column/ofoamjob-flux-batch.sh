#!/bin/bash
#FLUX: --job-name=bcolumn
#FLUX: -N=2
#FLUX: --queue=short
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load openmpi/1.10.7/gcc-7.3.0
module load gcc
source /projects/vebio/hsitaram/VirtualEngineering/submodules/OpenFOAM-dev/etc/bashrc
. ./presteps.sh
srun -n 72 reactingTwoPhaseEulerFoam -parallel
