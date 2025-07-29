#!/bin/bash
#SBATCH --job-name=ProkkaP16NS
#SBATCH --mail-user=liangxu@caltech.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=6-23:10:00

module load parallel/20180222
module load singularity/3.3.0
sh prokka_genomes_P16NS.sh 32 221117-1910.P16N-S.16S.dna-sequences.tsv
