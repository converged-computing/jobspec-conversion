#!/bin/bash
#SBATCH --job-name=SRA_dld
#SBATCH --account=pawsey1018
#SBATCH --output=SRA_dld-%j.out
#SBATCH --error=SRA_dld-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=128GB
#SBATCH --time=1-00:00:00

set -euo pipefail
eval "$(conda shell.bash hook)"
conda activate snakemake7
snakemake -s sra_download.snakefile --profile pawsey --local-cores 32
find fastq -type f -not -name \*gz -exec pigz -p 32 {} \;
