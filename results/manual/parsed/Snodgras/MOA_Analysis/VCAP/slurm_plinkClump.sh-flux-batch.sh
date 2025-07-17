#!/bin/bash
#FLUX: --job-name=grated-staircase-3944
#FLUX: -t=3600
#FLUX: --urgency=16

module use /opt/rit/spack-modules/lmod/linux-rhel7-x86_64/Core/
module load plink
plink --file NAM_rils_SNPs_allchr.plk --clump bQTL.padj_probgeno.bed
