#!/bin/bash
#FLUX: --job-name=placid-cupcake-5349
#FLUX: --queue=Draco
#FLUX: -t=3600
#FLUX: --urgency=16

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
