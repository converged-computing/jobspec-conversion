#!/bin/bash
#SBATCH --mail-user=email@EMAIL_GOES_HERE.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=1-21:00:00

module load python
if [ ! -d "./venv" ]; then
    python -m venv venv
fi
source venv/bin/activate
if [ ! -f "./venv/bin/snakemake" ]; then
    pip install --upgrade pip
    pip install -r requirements.txt
fi
snakemake --jobs 25 --slurm --default-resources slurm_account=blekhman slurm_partition=blekhman
