#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=Draco
#SBATCH --constraint=ntasks-per-node=6

n=6
echo "Copying over useful files"
cp -r software/LCS software/LCS$n
echo "Removing excess files"
rm -rf software/LCS$n/.snakemake &
rm -rf software/LCS$n/outputs/pool_map &
rm -rf software/LCS$n/outputs/pool_mutect &
rm -rf software/LCS$n/outputs/pool_mutect_unused &
rm -rf software/LCS$n/outputs/decompose &
rm software/LCS$n/outputs/variants_table/pool_samples_${plate}.tsv
