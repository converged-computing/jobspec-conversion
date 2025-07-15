#!/bin/bash
#FLUX: --job-name=4PopSplit
#FLUX: --queue=broadwl
#FLUX: -t=18000
#FLUX: --priority=16

module load python/cpython-3.7.0
module load R
module load htslib/1.4.1
module load samtools
module load bcftools
echo "SLURM_JOBID="$SLURM_JOBID
cat snakefile
snakemake --cores all --rerun-incomplete   
