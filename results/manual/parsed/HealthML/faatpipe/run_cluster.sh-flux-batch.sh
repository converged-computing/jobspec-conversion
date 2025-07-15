#!/bin/bash
#FLUX: --job-name=controljob_%j
#FLUX: --queue=vcpu
#FLUX: -t=172800
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
snakemake_env="install/snakemake"
if [ ! -d $snakemake_env ]; then
    ./install.sh
fi
conda activate snakemake
snakemake --snakefile Snakefile \
          --configfile conf/config.yaml \
	  --profile ./slurm \
          --directory "${PWD}" \
	  "${@}"
