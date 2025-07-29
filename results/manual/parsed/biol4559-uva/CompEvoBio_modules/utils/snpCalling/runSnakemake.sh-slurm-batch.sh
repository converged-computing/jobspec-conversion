#!/bin/bash
#SBATCH --job-name=runSnakemake
#SBATCH --account=biol4559-aob2x
#SBATCH --output=/scratch/aob2x/compBio_SNP_25Sept2023/logs/runSnakemake.%A_%a.out
#SBATCH --error=/scratch/aob2x/compBio_SNP_25Sept2023/logs/runSnakemake.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=3-08:00:00
#SBATCH --constraint=ntasks-per-node=1

module load gcc/9.2.0 openmpi/3.1.6 python/3.7.7 snakemake/6.0.5
cd /scratch/aob2x/DESTv2/snpCalling
snakemake --profile /scratch/aob2x/CompEvoBio_modules/utils/snpCalling/slurm --ri
