#!/bin/bash
#SBATCH --job-name=LD-Extract-Individuals
#SBATCH --account=sens2017538
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
#SBATCH --partition=core
#SBATCH --array=1-22

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
