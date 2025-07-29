#!/bin/bash
#SBATCH --job-name=slurm-test
#SBATCH --mail-user=kweiss2@emory.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G
#SBATCH --constraint=ntasks-per-node=16
#SBATCH --chdir=/suppscr/csde/kweiss2/slurm

. /suppscr/csde/sjenness/spack/share/spack/setup-env.sh
module load gcc-8.2.0-gcc-4.8.5-rhsxipz
module load r-3.5.1-gcc-8.2.0-4suigve
Rscript sim.burn.abcsmc4.syph.R
