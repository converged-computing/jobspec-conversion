#!/bin/bash
#FLUX: --job-name=chocolate-buttface-5160
#FLUX: --urgency=16

module load gcc/9.2.0 openmpi/3.1.6 python/3.7.7 snakemake/6.0.5
cd /scratch/aob2x/DESTv2/snpCalling
snakemake --profile /scratch/aob2x/CompEvoBio_modules/utils/snpCalling/slurm --ri
