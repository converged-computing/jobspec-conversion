#!/bin/bash
#SBATCH --output=./slurm/logs/r2/%x-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=210G
#SBATCH --time=02:40:00

export R_LIBS='~/.local/R/$EBVERSIONR/'

module load StdEnv/2020   # This is already loaded, but for future compatibility...
module load gcc/9.3.0
module load kraken2/2.1.1
module load bbmap/38.86
module load trimmomatic/0.39
module load blast+/2.12.0
module load diamond/2.0.13
module load python/3.9
export R_LIBS=~/.local/R/$EBVERSIONR/
source ~/env/bin/activate
snakemake -s snakefile_mockcomm_R1_step2analyze.py --configfile configs/mockcomm_Round1.yaml --cores all
