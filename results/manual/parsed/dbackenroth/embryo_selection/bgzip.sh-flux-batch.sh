#!/bin/bash
#FLUX: --job-name=doopy-sundae-6111
#FLUX: -t=8400
#FLUX: --urgency=16

parentdir=/vol/sci/bio/data/shai.carmi/db2175/embryo_selection/
dir=${parentdir}/LIJMC
for i in {1..22}
do
  bgzip ${dir}/LIJMC37_phased_${i}.vcf
  tabix ${dir}/LIJMC37_phased_${i}.vcf.gz
done
