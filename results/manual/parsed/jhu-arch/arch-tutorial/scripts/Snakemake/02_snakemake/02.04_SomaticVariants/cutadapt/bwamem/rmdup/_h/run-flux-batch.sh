#!/bin/bash
#FLUX: --job-name=rmdup
#FLUX: -c=4
#FLUX: --queue=defq
#FLUX: -t=7200
#FLUX: --urgency=16

module load snakemake/7.6.0
snakemake --jobs 101 --latency-wait 240 --cluster 'sbatch --parsable --distribution=arbitrary' --snakefile ../_h/snakemake.slurm.script
