#!/bin/bash
#SBATCH --job-name=allen_SIMS
#SBATCH --account=b324
#SBATCH --output=./%N.%x.out
#SBATCH --error=./%N.%x.errs
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=24

module purge
module load userspace/all
module load python3/3.6.3
module load singularity/3.5.1
pip install snakemake==6.3.0
snakemake --unlock
snakemake --snakefile Snakefile --use-singularity --use-conda --conda-frontend conda --conda-not-block-search-path-envvars --singularity-args="-B /scratch/$SLURM_JOB_USER/scRNAseq_analysis_workflow/" --cores 24
