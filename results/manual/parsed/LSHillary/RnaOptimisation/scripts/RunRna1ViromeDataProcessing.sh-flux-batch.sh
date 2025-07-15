#!/bin/bash
#FLUX: --job-name=RNA1snakemake
#FLUX: --queue=high2
#FLUX: --urgency=16

source ~/.bashrc
cd rna1
snakemake --snakefile ../scripts/4-bbmap_index.smk --profile slurm --configfile ../rna1_pipeline_config.yml
