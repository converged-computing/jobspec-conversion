#!/bin/bash
#SBATCH --job-name=RES5p
#SBATCH --account=NN8050K
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=17
#SBATCH --mem=2G
#SBATCH --time=00:10:00
#SBATCH --partition=normal

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors
module --quiet purge
module load R/4.1.2-foss-2021b
cd ~/binclassfound
Rscript mcmc_5prior.R ${1} > mcmc_5prior_${1}.Rout 2>&1
