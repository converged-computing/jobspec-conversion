#!/bin/bash
#SBATCH --job-name=<job_name>
#SBATCH --output=<path
#SBATCH --error=<path
#SBATCH --mail-user=<uid@domain.edu>
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2gb
#SBATCH --time=30-00:00:00

cd <path to working directory>/
source /opt/ohpc/pub/Software/mamba-rocky/etc/profile.d/conda.sh
source /opt/ohpc/pub/Software/mamba-rocky/etc/profile.d/mamba.sh
conda activate snakemake
snakemake \
-s Snakefile \
--profile slurm \
--configfile config.yaml \
--latency-wait 120
