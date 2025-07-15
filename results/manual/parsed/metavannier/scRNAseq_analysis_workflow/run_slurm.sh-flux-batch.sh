#!/bin/bash
#FLUX: --job-name=expressive-pancake-8337
#FLUX: --priority=16

module purge
module load userspace/all
module load python3/3.6.3
module load singularity/3.5.1
pip install snakemake==6.3.0
snakemake --unlock
snakemake --snakefile Snakefile --use-singularity --use-conda --conda-frontend conda --conda-not-block-search-path-envvars --singularity-args="-B /scratch/$SLURM_JOB_USER/scRNAseq_analysis_workflow/" --cores 24
