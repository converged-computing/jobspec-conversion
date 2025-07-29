#!/bin/bash
#SBATCH --output=./slurm/logs/%x-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:10:00

export R_LIBS='~/.local/R/$EBVERSIONR/'

module load StdEnv/2020   # This is already loaded, but for future compatibility...
module load gcc/9.3.0
module load python/3.9
module load scipy-stack
export R_LIBS=~/.local/R/$EBVERSIONR/
source ~/env/bin/activate
snakemake -s snakefile_mockcomm_step3summarize.py --configfile configs/mockcomm_Round1.yaml --cores 1
