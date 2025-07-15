#!/bin/bash
#FLUX: --job-name=<job_name>
#FLUX: --queue=<controller partition name>
#FLUX: -t=2592000
#FLUX: --priority=16

cd <path to working directory>/
source /opt/ohpc/pub/Software/mamba-rocky/etc/profile.d/conda.sh
source /opt/ohpc/pub/Software/mamba-rocky/etc/profile.d/mamba.sh
conda activate snakemake
snakemake \
-s Snakefile \
--profile slurm \
--configfile config.yaml \
--latency-wait 120
