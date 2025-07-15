#!/bin/bash
#FLUX: --job-name=LDmap
#FLUX: -c=16
#FLUX: -t=734400
#FLUX: --priority=16

export OMP_NUM_THREADS='$ncores'

. /local/env/envsnakemake-6.0.5.sh
. /local/env/envsingularity-3.8.5.sh
. /local/env/envconda.sh
dataset=${1}
chrom=${2}
ncores=16
export OMP_NUM_THREADS=$ncores
echo "Run pipeline"
snakemake -s workflow/Snakefile -p -j $ncores --configfile data/${dataset}/config.yaml --use-conda --nolock --rerun-incomplete --printshellcmds --until k_statistics --config dataset=${dataset} chrom=${chrom} cores=$ncores
