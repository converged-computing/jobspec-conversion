#!/bin/bash
#FLUX: --job-name=expensive-motorcycle-4417
#FLUX: --priority=16

module load gcc/9.2.0 openmpi/3.1.6 python/3.7.7 snakemake/6.0.5
cd /scratch/aob2x/DESTv2/snpCalling
snakemake --profile /scratch/aob2x/DESTv2/snpCalling/slurm --ri
