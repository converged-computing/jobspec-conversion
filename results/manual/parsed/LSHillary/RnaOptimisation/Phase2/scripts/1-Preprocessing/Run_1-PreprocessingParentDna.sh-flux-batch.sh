#!/bin/bash
#FLUX: --job-name=RnaOpt-preprocessing
#FLUX: -c=2
#FLUX: --queue=high2
#FLUX: --urgency=16

source ~/.bashrc
cd Virome
micromamba activate ViromeDataProcessing
snakemake --snakefile ../scripts/1-Preprocessing/1-PreprocessingDna.smk --profile slurm
