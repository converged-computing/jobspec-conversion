#!/bin/bash
#FLUX: --job-name=ABNAME0000
#FLUX: -n=64
#FLUX: --queue=normal
#FLUX: -t=86400
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
