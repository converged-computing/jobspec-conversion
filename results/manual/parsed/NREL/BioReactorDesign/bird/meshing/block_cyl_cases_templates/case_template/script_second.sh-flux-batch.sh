#!/bin/bash
#FLUX: --job-name=bubbleCol
#FLUX: -t=86340
#FLUX: --urgency=50

module purge
source /projects/gas2fuels/load_OF9_pbe
TMPDIR=/tmp/scratch/
cp system/fvSchemes.second system/fvSchemes
cp system/controlDict.second system/controlDict
srun -n 36 multiphaseEulerFoam -parallel -fileHandler collated
reconstructPar -newTimes
