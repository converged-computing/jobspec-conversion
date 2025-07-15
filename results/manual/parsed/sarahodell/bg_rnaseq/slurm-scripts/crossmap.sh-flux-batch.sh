#!/bin/bash
#FLUX: --job-name=ornery-noodle-1638
#FLUX: --urgency=16

chr=$SLURM_ARRAY_TASK_ID
module load bcftools
bcftools reheader -f /group/jrigrp/Share/assemblies/Zea_mays.B73_RefGen_v4.dna.toplevel.fa.fai datasets/ames/AmesTropical_${chr}rarealleles1_v4.vcf.gz -o datasets/ames/AmesTropical_${chr}rarealleles1_v4_reheader.vcf.gz
bcftools sort datasets/ames/AmesTropical_${chr}rarealleles1_v4_reheader.vcf.gz -Oz -o datasets/ames/AmesTropical_${chr}rarealleles1_v4_sorted.vcf.gz
tabix -p vcf datasets/ames/AmesTropical_${chr}rarealleles1_v4_sorted.vcf.gz
bcftools view datasets/ames/AmesTropical_${chr}rarealleles1_v4_sorted.vcf.gz -r $chr -Oz -o datasets/ames/AmesTropical_${chr}rarealleles_v4.vcf.gz
tabix -p vcf datasets/ames/AmesTropical_${chr}rarealleles_v4.vcf.gz
