#!/bin/bash
#FLUX: --job-name=sortmerna
#FLUX: --queue=high2
#FLUX: -t=36000
#FLUX: --urgency=16

source ~/.bashrc
cd Virome
micromamba activate ViromeDataProcessing
snakemake --snakefile ../scripts/0-preprocessing.smk --profile slurm
snakemake --snakefile ../scripts/1.2-bbcms.smk --profile slurm
