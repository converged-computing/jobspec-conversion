#!/bin/bash
#SBATCH --job-name=crossmap
#SBATCH --output=/home/sodell/projects/biogemma/expression/slurm-logs/out-%A_%a.txt
#SBATCH --error=/home/sodell/projects/biogemma/expression/slurm-logs/error-%A_%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00
#SBATCH --chdir=/home/sodell/projects/biogemma/expression
#SBATCH --array=1-9

chr=$SLURM_ARRAY_TASK_ID
module load bcftools
bcftools reheader -f /group/jrigrp/Share/assemblies/Zea_mays.B73_RefGen_v4.dna.toplevel.fa.fai datasets/ames/AmesTropical_${chr}rarealleles1_v4.vcf.gz -o datasets/ames/AmesTropical_${chr}rarealleles1_v4_reheader.vcf.gz
bcftools sort datasets/ames/AmesTropical_${chr}rarealleles1_v4_reheader.vcf.gz -Oz -o datasets/ames/AmesTropical_${chr}rarealleles1_v4_sorted.vcf.gz
tabix -p vcf datasets/ames/AmesTropical_${chr}rarealleles1_v4_sorted.vcf.gz
bcftools view datasets/ames/AmesTropical_${chr}rarealleles1_v4_sorted.vcf.gz -r $chr -Oz -o datasets/ames/AmesTropical_${chr}rarealleles_v4.vcf.gz
tabix -p vcf datasets/ames/AmesTropical_${chr}rarealleles_v4.vcf.gz
