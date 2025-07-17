#!/bin/bash
#FLUX: --job-name=LD-Extract-Individuals
#FLUX: -n=10
#FLUX: --queue=core
#FLUX: -t=10800
#FLUX: --urgency=16

chr=$SLURM_ARRAY_TASK_ID
module load bioinfo-tools plink2/2.00-alpha-2-20190429
plink2 \
  --pgen genotypes/chr${chr}.pgen \
  --psam sample_info/samples.fam \
  --pvar genotypes/chr${chr}.dedup.bim \
  --keep sample_info/estimation.ids \
  --maf 0.01 \
  --geno 0.05 \
  --hwe 1e-20 \
  --extract info_snps.txt \
  --make-bed \
  --out reference_genotypes/chr${chr}
