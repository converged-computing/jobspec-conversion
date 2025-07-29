#!/bin/bash
#FLUX: --job-name=JobExample1
#FLUX: -n=100
#FLUX: -t=7200
#FLUX: --urgency=16

export PATH='$SCRATCH/programs/EnergyPlus-9-4-0:$PATH'

ml purge
ml intel/2019a
ml CMake/3.15.3-GCCcore-8.3.0
export PATH=$SCRATCH/programs/EnergyPlus-9-4-0:$PATH
mpirun python runTestEplus_parallel.py
