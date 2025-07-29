#!/bin/bash
#FLUX: --job-name=pusheena-puppy-0698
#FLUX: -n=2
#FLUX: --queue=norm
#FLUX: -t=345600
#FLUX: --urgency=16

source /mnt/ccrsf-ifx/Software/tools/Anaconda/3.11/etc/profile.d/conda.sh
conda activate snakemake
module load singularity
snakemake --profile slurm --use-conda --use singularity
