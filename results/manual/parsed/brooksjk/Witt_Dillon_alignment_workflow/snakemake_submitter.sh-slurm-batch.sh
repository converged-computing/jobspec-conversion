#!/bin/bash
#SBATCH --job-name=<job_name>
#SBATCH --output=<path/to/work/directory>/log/<job_name>_snakefile_.%j.txt
#SBATCH --error=<path/to/work/directory>/log/<job_name>_snakefile_.%j.txt
#SBATCH --mail-user=<user@clemson.edu>
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2gb
#SBATCH --time=2-00:00:00

cd <path/to/working/directory>
source /opt/ohpc/pub/Software/mamba-rocky/etc/profile.d/conda.sh
conda activate snakemake
snakemake \
-s Snakefile \
--profile slurm \
--latency-wait 150 \
-p \
