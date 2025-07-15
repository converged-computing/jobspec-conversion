#!/bin/bash
#FLUX: --job-name=goodbye-bike-8769
#FLUX: -t=172800
#FLUX: --urgency=16

module use /opt/rit/spack-modules/lmod/linux-rhel7-x86_64/Core/
module load plink
plink --file NAM_rils_SNPs_chr10.plk --merge-list allfiles.txt --make-bed --out NAM_rils_SNPs_allchr
