#!/bin/bash
#FLUX: --job-name=RnaOpt-preprocessing
#FLUX: -c=2
#FLUX: --queue=high2
#FLUX: --urgency=16

source ~/.bashrc
cd RnaVirome
micromamba activate ViromeDataProcessing
snakemake --snakefile ../scripts/1-Preprocessing/1-PreprocessingRna.smk --profile slurm
