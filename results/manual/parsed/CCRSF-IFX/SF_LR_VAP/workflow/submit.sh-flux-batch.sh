#!/bin/bash
#FLUX: --job-name=doopy-general-4116
#FLUX: -n=2
#FLUX: --queue=norm
#FLUX: -t=345600
#FLUX: --priority=16

source /mnt/ccrsf-ifx/Software/tools/Anaconda/3.11/etc/profile.d/conda.sh
conda activate snakemake
module load singularity
snakemake --profile slurm --use-conda --use singularity
