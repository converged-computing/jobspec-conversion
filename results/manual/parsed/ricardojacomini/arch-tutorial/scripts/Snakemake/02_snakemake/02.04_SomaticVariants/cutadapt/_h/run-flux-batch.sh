#!/bin/bash
#FLUX: --job-name=frigid-taco-3771
#FLUX: -c=4
#FLUX: -t=7200
#FLUX: --priority=16

module load snakemake/7.6.0
snakemake --jobs 200 --latency-wait 240 --cluster 'sbatch --parsable --distribution=arbitrary' --snakefile ../_h/snakemake.slurm.script
