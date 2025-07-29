#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/AidanKelley/fourier-stabilization/scripts/pdfrate_brendel.sh
