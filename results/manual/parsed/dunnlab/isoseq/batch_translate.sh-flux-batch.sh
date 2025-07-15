#!/bin/bash
#FLUX: --job-name=snake
#FLUX: -c=32
#FLUX: --queue=ycga
#FLUX: -t=86400
#FLUX: --urgency=16

module load miniconda
conda activate isoseq
snakemake --snakefile translate.smk --cores $SLURM_CPUS_PER_TASK --config species=Cyanea_sp transcriptome=W7.clustered.hq.fasta
