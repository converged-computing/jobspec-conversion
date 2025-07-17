#!/bin/bash
#FLUX: --job-name=fat-cupcake-1260
#FLUX: -t=8400
#FLUX: --urgency=16

vcf=$1
daner=$2
outfile=$3
plink1.9 --vcf $vcf --maf 0.01 --clump $daner --clump-kb 250 --clump-r2 0.1 --clump-p1 0.05 --out $outfile
