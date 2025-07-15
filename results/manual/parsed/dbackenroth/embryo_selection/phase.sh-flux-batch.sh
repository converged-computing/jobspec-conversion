#!/bin/bash
#FLUX: --job-name=nerdy-knife-7347
#FLUX: -c=2
#FLUX: -t=25200
#FLUX: --priority=16

gmapfile=/cs/icore/db2175/bin/Eagle_v2.4/tables/genetic_map_hg19_withX.txt.gz
dir=/vol/sci/bio/data/shai.carmi/db2175/embryo_selection/crohns/
phasingdir=${dir}/phasing/
vcf=${dir}/ToddSamples.vcf.gz
chr=$SLURM_ARRAY_TASK_ID
unphased=${phasingdir}/unphased_${chr}.vcf
phased=${phasingdir}/phased_${chr}
eagle=/cs/icore/db2175/bin/Eagle_v2.4/eagle
bcftools view $vcf --regions $chr -O v -o ${unphased} 
bgzip $unphased
$eagle --numThreads 2 --chrom $chr --geneticMapFile $gmapfile --vcf ${unphased}.gz --outPrefix ${phased}
tabix ${phased}.vcf.gz
