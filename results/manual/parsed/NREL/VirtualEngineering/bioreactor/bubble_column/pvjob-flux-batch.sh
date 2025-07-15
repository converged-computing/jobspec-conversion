#!/bin/bash
#FLUX: --job-name=pvpost
#FLUX: --queue=standard
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
module load openmpi/1.10.7/gcc-7.3.0
module load gcc
module load paraview
source /projects/bpms/openfoam/OpenFOAM-dev/etc/bashrc
rm -rf 0.0/
rm -rf 0/
reconstructPar -withZero -newTimes
mv 0/ 0.0/
pvpython pv_extract_analyze_script.py 
