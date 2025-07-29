#!/bin/bash
#SBATCH --job-name=whap
#SBATCH --account=project_2001443
#SBATCH --output=/scratch/project_2001443/barriers_introgr_formica/vcf/phasing/whatshap/logs/whatshap_%a.out
#SBATCH --error=/scratch/project_2001443/barriers_introgr_formica/vcf/phasing/whatshap/logs/whatshap_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=25G
#SBATCH --time=1-00:00:00
#SBATCH --array=1-101

export PATH='/projappl/project_2001443/whatshapenv/bin:$PATH" '

cd /scratch/project_2001443/barriers_introgr_formica/vcf/filt
bcftools query -l all_samples.DP8.hwe.AN10.noScaff00.mac2.vcf.gz > all_samples.DP8.hwe.AN10.noScaff00.mac2.ind.list
---
module load biokit
export PATH="/projappl/project_2001443/whatshapenv/bin:$PATH" 
cd /scratch/project_2001443/barriers_introgr_formica/vcf/phasing
BAMDIR=/scratch/project_2001443/barriers_introgr_formica/bam_all
masterVCF=/scratch/project_2001443/barriers_introgr_formica/vcf/filt/all_samples.DP8.hwe.AN10.noScaff00.mac2.vcf.gz
REF=/scratch/project_2001443/reference_genome/Formica_hybrid_v1_wFhyb_Sapis.fa
INDLIST=/scratch/project_2001443/barriers_introgr_formica/vcf/filt/all_samples.DP8.hwe.AN10.noScaff00.mac2.ind.list
ind=$(sed -n "$SLURM_ARRAY_TASK_ID"p $INDLIST)
indbam=${ind%%-*} #in the bam file names, inds sequenced earlier have only numbers as ids, whereas the vcf ids (and INDLIST) contain species info for these. Match these.
bcftools view -s $ind $masterVCF -Ov | perl -npe 's/(.\/.)\:.+\:(.+\:.+\:.+\:.+\:.+\:.+\:.+)/$1\:99\:$2/' | grep -v '^Scaffold00' | bgzip > whatshap/${ind}.GQfixed.vcf.gz &&\
bcftools index -t whatshap/${ind}.GQfixed.vcf.gz
whatshap phase -o whatshap/${ind}.phased.vcf.gz --reference $REF \
               whatshap/${ind}.GQfixed.vcf.gz $BAMDIR/${indbam}_nodupl_*.bam &&\
whatshap stats whatshap/${ind}.phased.vcf.gz --tsv=whatshap/${ind}.phased.tsv
2_whatshap.sh (END)
