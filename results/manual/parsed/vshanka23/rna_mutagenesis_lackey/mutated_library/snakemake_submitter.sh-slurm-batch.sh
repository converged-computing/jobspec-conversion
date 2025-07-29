#!/bin/bash
#SBATCH --job-name=rnamut
#SBATCH --output=/data/Palmetto_sync/Projects/vshanka_rnamut_dna/Ethanol_DMS/mutated/log/rnamut_output_%j.txt
#SBATCH --error=/data/Palmetto_sync/Projects/vshanka_rnamut_dna/Ethanol_DMS/mutated/log/rnamut_error_%j.txt
#SBATCH --mail-user=vshanka@clemson.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2gb
#SBATCH --time=3-00:00:00
#SBATCH --partition=bigmem

cd /data/Palmetto_sync/Projects/vshanka_rnamut_dna/Ethanol_DMS/mutated
source /opt/ohpc/pub/Software/mamba-rocky/etc/profile.d/conda.sh
source /opt/ohpc/pub/Software/mamba-rocky/etc/profile.d/mamba.sh
conda activate snakemake
snakemake \
-s Snakefile_degen \
--profile slurm \
--configfile library.yaml \
--latency-wait 120
