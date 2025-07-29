#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --output=apaQTLsnake.out
#SBATCH --error=apaQTLsnake.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00
#SBATCH --partition=broadwl

source ~/activate_anaconda.sh
conda activate three-prime-env
bash submit-snakemake.sh $*
