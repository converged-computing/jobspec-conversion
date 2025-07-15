#!/bin/bash
#FLUX: --job-name=Xtx
#FLUX: -t=28800
#FLUX: --urgency=16

plink1=/Genomics/grid/users/alea/programs/plink_1.90
plink2=/Genomics/ayroleslab2/emma/Turkana_Genotyping/1000G_data/bin/plink2
awk '{print "0",$1,$2,$3,$4}' 2023_08_16-1000G_P3_subset_map > tmp
mv tmp 1000G_Phase3_subset_groups
$plink1 --bfile forFst --snps-only --extract forFst.prune.in --make-bed --out forXtx --geno 0.5 --maf 0.05 --freq --within 1000G_Phase3_subset_groups
$plink2 --bfile forFst --snps-only --extract forFst.prune.in  --out forXtx2 --geno 0.25 --maf 0.01 --within 1000G_Phase3_subset_groups POP --fst POP method=hudson 
