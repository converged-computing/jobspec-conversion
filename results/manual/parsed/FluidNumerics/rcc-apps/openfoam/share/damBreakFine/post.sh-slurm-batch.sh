#!/bin/bash
#SBATCH --output=openfoam-%j.log
#SBATCH --error=openfoam-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

reconstructPar
touch dambreak.foam
