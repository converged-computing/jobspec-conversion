#!/bin/bash
#FLUX: --job-name=grated-hippo-9732
#FLUX: -c=30
#FLUX: --queue=fast
#FLUX: --urgency=16

module load snakemake/7.7.0 fastqc bowtie2 samtools subread slurm-drmaa
snakemake --drmaa --jobs=$SLURM_CPUS_PER_TASK -s demo.smk --configfile config.yml
singularity exec -B $PWD:/home/ fair_ebaii_n2_latest.sif Rscript --vanilla sartools.R
