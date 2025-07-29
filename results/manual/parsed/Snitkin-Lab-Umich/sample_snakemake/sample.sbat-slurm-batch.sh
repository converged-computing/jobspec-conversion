#!/bin/bash
#SBATCH --job-name=sample_snakemake
#SBATCH --account=esnitkin1
#SBATCH --mail-user=UNIQNAME@umich.edu
#SBATCH --mail-type=BEGIN,END,NONE,FAIL,REQUEUE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1g
#SBATCH --time=10:00:00
#SBATCH --partition=standard

cd $SLURM_SUBMIT_DIR
echo $SLURM_SUBMIT_DIR
snakemake --latency-wait 20 --profile config -s snakefile
