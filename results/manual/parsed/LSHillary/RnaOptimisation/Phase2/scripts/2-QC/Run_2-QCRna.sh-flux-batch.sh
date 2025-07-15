#!/bin/bash
#FLUX: --job-name=RnaOpt-preprocessing
#FLUX: -c=2
#FLUX: --queue=high2
#FLUX: --urgency=16

source ~/.bashrc
cd RnaVirome
micromamba activate ViromeDataProcessing
snakemake --snakefile ../scripts/2-QC/2-QC_Rna.smk --profile slurm --rerun-triggers mtime
