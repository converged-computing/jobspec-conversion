#!/bin/bash
#SBATCH --job-name=runSnakemake
#SBATCH --account=berglandlab_standard
#SBATCH --output=/scratch/aob2x/DESTv2_output_26April2023/logs/runSnakemake.%A_%a.out
#SBATCH --error=/scratch/aob2x/DESTv2_output_26April2023/logs/runSnakemake.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=3-08:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1

module load gcc/9.2.0 openmpi/3.1.6 python/3.7.7 snakemake/6.0.5
cd /scratch/aob2x/DESTv2/snpCalling
snakemake --profile /scratch/aob2x/DESTv2/snpCalling/slurm --ri
