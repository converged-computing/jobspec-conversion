#!/bin/bash
#SBATCH --job-name=tiger_snek
#SBATCH --account=snic2018-3-170
#SBATCH --output=tiger_snek_chunk3_%j.out
#SBATCH --error=tiger_snek_chunk3_%j.error
#SBATCH --mail-user=tilman.ronneburg@imbim.uu.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=15
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00

module load java/sun_jdk1.8.0_151
source activate v3
snakemake --unlock -s ./tiger.snek --configfile config/config_rackham_all_samples.yaml  --rerun-incomplete 
snakemake --keep-going -j 13 -s ./tiger.snek  --configfile config/config_rackham_all_samples.yaml  --rerun-incomplete --use-conda
