#!/bin/bash
#SBATCH --job-name=lap-estabc
#SBATCH --mail-user=sjennes@emory.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=55G
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=16
#SBATCH --chdir=/suppscr/csde/sjenness/lap

. /suppscr/csde/sjenness/spack/share/spack/setup-env.sh
module load gcc-8.1.0-gcc-4.4.7-eaajvcy
module load r-3.5.1-gcc-8.1.0-unb32sy
Rscript estim.abc.R
