#!/bin/bash
#SBATCH --job-name=bergamot
#SBATCH --output=job.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=7-00:00:00

set -e # exit on error
set -x # echo commands
[ ! -d firefox-translations-training ] && git clone https://github.com/sign-language-processing/firefox-translations-training.git
cd firefox-translations-training
make conda
conda install -n base -c conda-forge mamba -y
make snakemake
make git-modules
module load singularityce
make pull
