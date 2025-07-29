#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --account=account_name
#SBATCH --output=snakemake.out
#SBATCH --error=snakemake.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00
#SBATCH --partition=partition_name

module load Anaconda3
source activate peakcalling
bash Submit_snakemake.sh "-s Snakefile" "--configfile config.yaml" $*
