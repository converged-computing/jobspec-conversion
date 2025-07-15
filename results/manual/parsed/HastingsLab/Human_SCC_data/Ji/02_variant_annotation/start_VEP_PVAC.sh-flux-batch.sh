#!/bin/bash
#FLUX: --job-name=Merge  # Job name
#FLUX: --priority=16

source activate vep_env
module load bcftools-1.14-gcc-11.2.0
snakemake --snakefile VEP_PVACseq.snakefile -j 71 --keep-target-files --rerun-incomplete --cluster "sbatch -q public -p general -n 1 -c 1 --mem=50000 -t 0-10:00:00"
