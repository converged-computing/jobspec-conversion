#!/bin/bash
#SBATCH --job-name=liftover
#SBATCH --output=job_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=15G

input_dir=/ref/mblab/data/llfs/geno_chip
output_dir=lifted_over_vcf
hg19_to_hg38_chain=/ref/mblab/data/human/hg19ToHg38.over.chain.gz
reference=/ref/mblab/data/human/GRCh38/GRCh38.primary_assembly.genome.fa
mkdir $output_dir
input_file=${input_dir}/llfs_gwas.chr${SLURM_ARRAY_TASK_ID}.vcf.gz
output_file=${output_dir}/llfs_gwas.chr${SLURM_ARRAY_TASK_ID}_hg38.vcf
reject_file=${output_dir}/llfs_gwas.chr${SLURM_ARRAY_TASK_ID}_hg38_rejected.vcf
eval $(spack load --sh picard)
picard LiftoverVcf \
     I=${input_file} \
     O=${output_file} \
     CHAIN=${hg19_to_hg38_chain} \
     REJECT=${reject_file} \
     R=$reference
