#!/bin/bash
#FLUX: --job-name=SRA_dld
#FLUX: -c=32
#FLUX: -t=86400
#FLUX: --urgency=16

set -euo pipefail
eval "$(conda shell.bash hook)"
conda activate snakemake7
snakemake -s sra_download.snakefile --profile pawsey --local-cores 32
find fastq -type f -not -name \*gz -exec pigz -p 32 {} \;
