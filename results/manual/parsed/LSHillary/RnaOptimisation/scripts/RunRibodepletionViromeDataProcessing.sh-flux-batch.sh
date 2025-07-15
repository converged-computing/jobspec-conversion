#!/bin/bash
#FLUX: --job-name=RIBOsnakemake
#FLUX: --queue=high2
#FLUX: --urgency=16

source ~/.bashrc
cd ribodepletion
micromamba activate ViromeDataProcessing
snakemake --snakefile ../scripts/3.1-genomad_rna.smk --profile slurm --configfile ../ribodepletion/ribodepletion_pipeline_config.yml
