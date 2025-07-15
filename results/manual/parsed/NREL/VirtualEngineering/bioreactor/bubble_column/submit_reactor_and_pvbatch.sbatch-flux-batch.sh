#!/bin/bash
#FLUX: --job-name=reactor
#FLUX: -N=2
#FLUX: -t=43200
#FLUX: --priority=16

module purge
module load openmpi/1.10.7/gcc-7.3.0
module load gcc
module load paraview
source /projects/vebio/hsitaram/VirtualEngineering/submodules/OpenFOAM-dev/etc/bashrc
. ./presteps.sh
srun -n $SLURM_NTASKS reactingTwoPhaseEulerFoam -parallel
source /projects/bpms/openfoam/OpenFOAM-dev/etc/bashrc
rm -rf 0.0/
rm -rf 0/
reconstructPar -latestTime
mv 0/ 0.0/
pvpython pv_extract_analyze_script.py 
