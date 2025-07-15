#!/bin/bash
#FLUX: --job-name=preprocess
#FLUX: -c=4
#FLUX: -t=2376000
#FLUX: --urgency=16

. /local/env/envsnakemake-6.0.5.sh
. /local/env/envsingularity-3.8.5.sh
. /local/env/envconda.sh
dataset=${1}
ncores=4
echo "Run pipeline"
snakemake -s data_preprocessing.snake -p -j $ncores --configfile data/${dataset}/config.yaml --use-conda --use-singularity --nolock --rerun-incomplete --config dataset=${dataset}
