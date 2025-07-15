#!/bin/bash
#FLUX: --job-name=creamy-house-6060
#FLUX: -c=30
#FLUX: --queue=fast
#FLUX: --priority=16

module load snakemake/7.7.0 fastqc bowtie2 samtools subread slurm-drmaa
snakemake --drmaa --jobs=$SLURM_CPUS_PER_TASK -s demo.smk --configfile config.yml
singularity exec -B $PWD:/home/ fair_ebaii_n2_latest.sif Rscript --vanilla sartools.R
