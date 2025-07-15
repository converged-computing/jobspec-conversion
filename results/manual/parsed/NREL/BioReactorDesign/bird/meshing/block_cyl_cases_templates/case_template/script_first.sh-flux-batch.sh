#!/bin/bash
#FLUX: --job-name=bubbleCol
#FLUX: -t=86340
#FLUX: --priority=16

module purge
source /projects/gas2fuels/load_OF9_pbe
TMPDIR=/tmp/scratch/
touch sol.foam
./Allrun
cp system/fvSchemes.upwind system/fvSchemes
cp system/controlDict.first system/controlDict
decomposePar -fileHandler collated -latestTime
srun -n 36 multiphaseEulerFoam -parallel -fileHandler collated
