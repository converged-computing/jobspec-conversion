#!/bin/bash
#SBATCH --output=slurm_%x_%j.out
#SBATCH --mail-user=$USER@chop.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=3-00:00:00
#SBATCH --no-requeue

if [[ ! -f ./config.yaml ]]; then
    echo "Must have a config.yaml to be able to run"
    exit 1
fi
source ~/.bashrc.conda #needed to make "conda" command to work
conda activate qiime2-2023.2
set -xeuo pipefail
snakemake --profile ./
