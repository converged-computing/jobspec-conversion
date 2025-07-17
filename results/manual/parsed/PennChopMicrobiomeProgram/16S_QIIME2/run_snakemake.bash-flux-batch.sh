#!/bin/bash
#FLUX: --job-name=ornery-muffin-3216
#FLUX: -t=259200
#FLUX: --urgency=16

if [[ ! -f ./config.yaml ]]; then
    echo "Must have a config.yaml to be able to run"
    exit 1
fi
source ~/.bashrc.conda #needed to make "conda" command to work
conda activate qiime2-2023.2
set -xeuo pipefail
snakemake --profile ./
