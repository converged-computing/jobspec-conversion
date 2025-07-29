#!/bin/bash
#SBATCH --job-name=bubbleCol
#SBATCH --account=plasticpyro
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=23:59:00
#SBATCH --qos=high
#SBATCH --constraint=ntasks-per-node=36

module purge
source /projects/gas2fuels/load_OF9_pbe
TMPDIR=/tmp/scratch/
cp system/fvSchemes.second system/fvSchemes
cp system/controlDict.second system/controlDict
srun -n 36 multiphaseEulerFoam -parallel -fileHandler collated
reconstructPar -newTimes
