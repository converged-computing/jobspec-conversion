#!/bin/bash
#SBATCH --job-name=main
#SBATCH --output=logs/main.out
#SBATCH --error=logs/main.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module load gcc/12.1.0
module load python/3.10.5
module load plink/2.0
module load gcta/1.94.1
module load R
module load bcftools
module load samtools
echo "SLURM_JOBID="$SLURM_JOBID
cat snakefile_4PopSplit
snakemake -s snakefile_4PopSplit_TS --unlock
snakemake --profile cluster-setup/ -s snakefile_4PopSplit_TS --rerun-triggers mtime  --rerun-incomplete
