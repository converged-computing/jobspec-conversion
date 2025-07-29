#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --mem=50GB

module load snakemake fastqc bowtie2 samtools subread slurm-drmaa
snakemake --drmaa --jobs=$SLURM_CPUS_PER_TASK -s demo.smk --configfile config.yml
singularity exec -B $PWD:/home/ journee_axe_bioinfo_latest.sif Rscript --vanilla sartools.R
