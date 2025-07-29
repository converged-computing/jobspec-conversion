#!/bin/bash
#FLUX: --job-name=bergamot
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --urgency=16

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
