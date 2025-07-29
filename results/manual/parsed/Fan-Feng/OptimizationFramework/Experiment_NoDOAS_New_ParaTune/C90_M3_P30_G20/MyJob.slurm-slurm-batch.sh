#!/bin/bash
#FLUX: --job-name=C90_M3_P30_G50
#FLUX: -n=30
#FLUX: -t=3600
#FLUX: --urgency=16

export PATH='$SCRATCH/programs/EnergyPlus-9-5-0:$PATH'

ml purge
ml intel/2019a
ml CMake/3.15.3-GCCcore-8.3.0
export PATH=$SCRATCH/programs/EnergyPlus-9-5-0:$PATH
mpirun python runTestEplus_parallel.py
