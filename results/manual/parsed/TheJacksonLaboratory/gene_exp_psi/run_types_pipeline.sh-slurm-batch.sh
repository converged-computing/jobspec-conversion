#!/bin/bash
#SBATCH --job-name=pps
#SBATCH --output=ppr-%j.out
#SBATCH --error=ppr-%j.err
#SBATCH --mail-user=guy.karlebach@jax.org
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=31
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=24G
#SBATCH --time=3-00:00:00

cd $SLURM_SUBMIT_DIR
module load singularity
singularity exec sing.sif bash run_snakemake.sh 
