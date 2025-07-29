#!/bin/bash
#SBATCH --job-name=pvserver
#SBATCH --output=log.pvserver
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=03:00:00
#SBATCH --partition=k2-medpri,medpri

module load apps/paraview/5.11.2
echo starting xvfb
xvfb-run echo \$DISPLAY
echo svfb finished
