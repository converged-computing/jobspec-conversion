#!/bin/bash
#FLUX: --job-name=RnaOpt-preprocessing
#FLUX: -c=2
#FLUX: --queue=high2
#FLUX: --urgency=16

source ~/.bashrc
cd MetaT
micromamba activate ViromeDataProcessing
snakemake --snakefile ../scripts/3-Assembly/3-Assembly_MetaT.smk --profile slurm --rerun-triggers mtime
