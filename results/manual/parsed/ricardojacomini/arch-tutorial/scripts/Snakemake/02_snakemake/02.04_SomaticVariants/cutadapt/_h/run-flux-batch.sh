#!/bin/bash
#FLUX: --job-name=chunky-signal-9111
#FLUX: -c=4
#FLUX: -t=7200
#FLUX: --urgency=16

module load snakemake/7.6.0
snakemake --jobs 200 --latency-wait 240 --cluster 'sbatch --parsable --distribution=arbitrary' --snakefile ../_h/snakemake.slurm.script
