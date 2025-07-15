#!/bin/bash
#FLUX: --job-name=gloopy-toaster-9594
#FLUX: -t=36000
#FLUX: --urgency=16

chmod +x workflow/genesearch.sh
sample="$1"
module load conda
source conda_init.sh
conda activate coco
snakemake --cores 12 ${sample}_tmp/${sample}_megahit
snakemake --cores 12 ${sample}_tmp/${sample}.index.1.bt2
snakemake --cores 12 ${sample}_outputs/${sample}_hgcA_final.txt
