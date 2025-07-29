#!/bin/bash
#SBATCH --job-name=manual_annotate
#SBATCH --account=biol4559-aob2x
#SBATCH --output=/scratch/aob2x/compBio_SNP_25Sept2023/logs/manual_annotate.%A_%a.out
#SBATCH --error=/scratch/aob2x/compBio_SNP_25Sept2023/logs/manual_annotate.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load  htslib/1.10.2 bcftools/1.9 intel/18.0 intelmpi/18.0 parallel/20200322 R/3.6.3 samtools vcftools
module load gcc/9.2.0 bedtools/2.29.2
bcftools merge -0 --threads 1 \
-o /scratch/aob2x/compBio_SNP_25Sept2023/dest.expevo.PoolSNP.001.50.11Oct2023.norep.ann.vcf.gz \
/scratch/aob2x/compBio_SNP_25Sept2023/dest.PoolSeq.PoolSNP.001.50.25Sept2023.norep.vcf.gz \
/scratch/aob2x/dest.all.PoolSNP.001.50.8Jun2023.norep.AT_EScorrect.ann.vcf.gz
