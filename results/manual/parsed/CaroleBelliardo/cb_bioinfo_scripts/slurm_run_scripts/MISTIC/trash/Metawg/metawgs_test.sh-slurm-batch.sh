#!/bin/bash
#SBATCH --job-name=Run1
#SBATCH --output=slurm-run1-%j.out
#SBATCH --error=slurm-run1-%j.err
#SBATCH --mail-user=carole.belliardo@inrae.fr
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=60
#SBATCH --mem=464G
#SBATCH --partition=all

module purge
module load singularity/3.7.3
module load nextflow/21.04.1
cd /kwak/hub/25_cbelliardo/MISTIC/
nextflow run -profile test,genotoul metagwgs/main.nf \
--type 'SR' \
--input 'metagwgs-test-datasets/small/input/samplesheet.csv' \
--skip_host_filter --skip_kaiju --stop_at_clean
