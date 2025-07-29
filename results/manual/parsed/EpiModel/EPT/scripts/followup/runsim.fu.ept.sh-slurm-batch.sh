#!/bin/bash
#SBATCH --job-name=slurm-test
#SBATCH --mail-user=kweiss2@emory.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=16
#SBATCH --chdir=/gscratch/csde/kweiss2/sti

. /gscratch/csde/sjenness/spack/share/spack/setup-env.sh
module load gcc-8.2.0-gcc-8.1.0-sh54wqg
module load r-3.5.2-gcc-8.2.0-sby3icq
Rscript sim.fu.ept.R
