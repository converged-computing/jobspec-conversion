#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=15g
#SBATCH --time=02:20:00

vcf=$1
daner=$2
outfile=$3
plink1.9 --vcf $vcf --maf 0.01 --clump $daner --clump-kb 250 --clump-r2 0.1 --clump-p1 0.05 --out $outfile
