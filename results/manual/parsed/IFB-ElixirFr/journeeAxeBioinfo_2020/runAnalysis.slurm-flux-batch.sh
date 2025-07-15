#!/bin/bash
#FLUX: --job-name=hello-peanut-9032
#FLUX: -c=30
#FLUX: --queue=fast
#FLUX: --urgency=16

module load snakemake fastqc bowtie2 samtools subread slurm-drmaa
snakemake --drmaa --jobs=$SLURM_CPUS_PER_TASK -s demo.smk --configfile config.yml
singularity exec -B $PWD:/home/ journee_axe_bioinfo_latest.sif Rscript --vanilla sartools.R
