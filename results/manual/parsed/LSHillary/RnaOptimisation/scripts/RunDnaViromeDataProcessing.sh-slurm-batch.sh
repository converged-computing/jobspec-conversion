#!/bin/bash
#FLUX: --job-name=DNAsnakemake
#FLUX: --queue=high2
#FLUX: -t=36000
#FLUX: --urgency=16

source ~/.bashrc
cd dna
micromamba activate ViromeDataProcessing
snakemake --snakefile ../scripts/4-bbmap_dna.smk --profile slurm --configfile ../dna_pipeline_config.yml
