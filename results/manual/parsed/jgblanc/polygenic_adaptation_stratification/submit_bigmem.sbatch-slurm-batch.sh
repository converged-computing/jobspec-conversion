#!/bin/bash
#SBATCH --job-name=2PopSplit_Plink
#SBATCH --output=logs/2PopSplit_Plink.out
#SBATCH --error=logs/2PopSplit_Plink.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16000
#SBATCH --time=03:00:00
#SBATCH --partition=bigmem2
#SBATCH --constraint=ntasks-per-node=8

module load python/cpython-3.7.0
module load R
module load htslib/1.4.1
module load samtools
module load bcftools
echo "SLURM_JOBID="$SLURM_JOBID
cat snakefile
snakemake -j8 --rerun-incomplete -s snakefile_2Pop
