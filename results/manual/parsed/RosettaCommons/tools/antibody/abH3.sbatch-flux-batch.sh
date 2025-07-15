#!/bin/bash
#FLUX: --job-name=astute-pedo-0450
#FLUX: --urgency=16

export MKL_MIC_ENABLE='1'

ROSETTA=$WORK/git/Rosetta
ROSETTABIN=$ROSETTA/main/source/bin
ROSETTAEXE=antibody_H3
COMPILER=mklmpi.linuxiccrelease
EXE=$ROSETTABIN/$ROSETTAEXE.$COMPILER
echo Starting MPI job running $EXE
export MKL_MIC_ENABLE=1
time ibrun $EXE @../abH3.flags
