#!/bin/bash
#SBATCH --job-name=meta-TCT-simulations
#SBATCH --account=lp_doctoralresearch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=00:05:00

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module use /apps/leuven/rocky8/icelake/2022b/modules/all
module load GSL
module load CMake
module load  R/4.3.2-foss-2022b
Rscript -e "renv::status()" -e "renv::restore()" - "renv::status()"
