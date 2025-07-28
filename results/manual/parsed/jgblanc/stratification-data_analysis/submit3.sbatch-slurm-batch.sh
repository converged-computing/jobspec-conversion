#!/bin/bash
#FLUX: --job-name=three
#FLUX: --queue=tier1q
#FLUX: -t=86400
#FLUX: --urgency=16

module load gcc/12.1.0
module load python/3.10.5
module load plink/2.0
module load gcta/1.94.1
module load R
source ../myVilma/bin/activate 
echo "SLURM_JOBID="$SLURM_JOBID
cat snakefile_main_simple3
snakemake --unlock -s snakefile_main_simple3
snakemake --profile cluster-setup/ -s snakefile_main_simple3 --rerun-incomplete
