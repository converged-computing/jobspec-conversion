#!/bin/bash
#FLUX: --job-name=rnamut
#FLUX: --queue=bigmem
#FLUX: -t=259200
#FLUX: --urgency=16

cd /data/Palmetto_sync/Projects/vshanka_rnamut_dna/Ethanol_DMS/mutated
source /opt/ohpc/pub/Software/mamba-rocky/etc/profile.d/conda.sh
source /opt/ohpc/pub/Software/mamba-rocky/etc/profile.d/mamba.sh
conda activate snakemake
snakemake \
-s Snakefile_degen \
--profile slurm \
--configfile library.yaml \
--latency-wait 120
