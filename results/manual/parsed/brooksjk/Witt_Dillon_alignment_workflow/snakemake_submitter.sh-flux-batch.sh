#!/bin/bash
#FLUX: --job-name=<job_name>
#FLUX: --queue=compute
#FLUX: -t=172800
#FLUX: --urgency=16

cd <path/to/working/directory>
source /opt/ohpc/pub/Software/mamba-rocky/etc/profile.d/conda.sh
conda activate snakemake
snakemake \
-s Snakefile \
--profile slurm \
--latency-wait 150 \
-p \
