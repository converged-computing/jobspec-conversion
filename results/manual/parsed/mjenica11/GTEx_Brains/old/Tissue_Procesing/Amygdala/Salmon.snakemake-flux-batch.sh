#!/bin/bash
#FLUX: --job-name=Salmon_Amygdala
#FLUX: --urgency=16

source activate salmon_environment
snakemake --snakefile Quantification.snakefile -j 20 --keep-target-files --rerun-incomplete --cluster "sbatch -n 8 -c 1 -t 5:00:00"
