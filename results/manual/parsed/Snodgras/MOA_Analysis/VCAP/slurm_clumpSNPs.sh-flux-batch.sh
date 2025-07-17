#!/bin/bash
#FLUX: --job-name=arid-leader-7986
#FLUX: -t=10800
#FLUX: --urgency=16

module use /opt/rit/spack-modules/lmod/linux-rhel7-x86_64/Core/
module load plink
plink --bfile NAM_rils_SNPs_allchr --clump bQTL.padj_probgeno.numeric.bed --clump-kb 0.150 --clump-r2 0.99 --clump-field P --clump-p1 0.1 --clump-p2 0.3 -out NAM_rils_SNPs.padj_probgeno.clumped
