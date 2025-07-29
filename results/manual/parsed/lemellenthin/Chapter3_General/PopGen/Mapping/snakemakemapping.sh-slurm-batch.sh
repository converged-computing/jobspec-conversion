#!/bin/bash
#SBATCH --job-name=cyaneapopgen
#SBATCH --output=cyaneapopgen_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=4G
#SBATCH --time=2-00:00:00

module purge # Unload any existing modules that might conflict
module load SAMtools
module load BWA
module load picard
module load BCFtools
module load miniconda
module load BEDTools
module load Trimmomatic
module load FastQC
module list
conda activate snakemake
snakemake --scheduler greedy --verbose --rerun-incomplete --cores $SLURM_CPUS_PER_TASK --latency-wait 60
