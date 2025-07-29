#!/bin/bash
#FLUX: --job-name=GATK4
#FLUX: --queue=phillips
#FLUX: -t=864000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load java easybuild GATK bedtools
module load easybuild  icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 VCFtools/0.1.15-Perl-5.24.1
module load java python2
refCEH="/projects/phillipslab/ateterina/CE_haw_subset/ref_245/c_elegans.PRJNA13758.WS245.genomic_masked.fa"
ref="/projects/phillipslab/ateterina/CE_haw_subset/ref_245/c_elegans.PRJNA13758.WS245.genomic.fa"
GATK="/projects/phillipslab/ateterina/scripts/gatk-4.1.4.1/gatk"
VCF="CE_population_raw.vcf"
cd /projects/phillipslab/ateterina/CE_haw_subset/data/BAMS
$GATK --java-options "-Xmx15g -Xms10g" \
              GatherVcfs \
                -I CR_full_output.I.vcf \
                -I CR_full_output.II.vcf \
                -I CR_full_output.III.vcf \
                -I CR_full_output.IV.vcf \
                -I CR_full_output.V.vcf \
                -I CR_full_output.X.vcf \
              --OUTPUT CE_population_raw.vcf
$GATK --java-options "-Xmx15g -Xms10g" SelectVariants  \
      -R $ref -V  $VCF --select-type-to-include INDEL  \
      -O  ${VCF/raw/raw_indels}
$GATK --java-options "-Xmx15g -Xms10g" VariantFiltration  \
      -R $ref -V ${VCF/raw/raw_indels} \
      --filter-name "basic_indel_filter" \
      --filter-expression 'QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0 || SOR > 10.0' \
      -O ${VCF/raw/filt_indels}
grep "PASS" ${VCF/raw/filt_indels} |grep -v "#" - | awk '{print $1"\t"$2-1"\t"$2}' - |bedtools slop -i - -b 10 -g ${ref}.fai > CE_indel_mask.bed
$GATK --java-options "-Xmx15g -Xms10g" SelectVariants  \
      -R $ref -V  $VCF --select-type-to-include SNP --restrict-alleles-to BIALLELIC  \
      -O  ${VCF/raw/raw_snps}
$GATK --java-options "-Xmx15g -Xms10g" VariantFiltration  \
      -R $ref -V ${VCF/raw/raw_snps} --filter-expression ' QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 3.0' --filter-name "basic_snp_filter" \
      -O ${VCF/raw/filt_snps}
grep -P "#|PASS" ${VCF/raw/filt_snps} > ${VCF/raw/filt2_snps}
$GATK --java-options "-Xmx15g -Xms10g" SelectVariants  \
           -R $ref -V  $VCF --select-type-to-include SNP --select-type-to-include MIXED --select-type-to-include MNP --select-type-to-include INDEL  \
                  -O  ${VCF/raw/raw_complex}
module load bedtools
awk '{print $1"\t"$2-1"\t"$2}' ${VCF/raw/filt2_snps} | grep -v "#" - > ${VCF/raw.vcf/filt2_snps.bed}
awk '{print $1"\t"$2-1"\t"$2}' ${VCF/raw/raw_complex} | grep -v "#" - | bedtools subtract -a - -b ${VCF/raw.vcf/filt2_snps.bed} > ${VCF/raw.vcf/raw_complex.bed}
vcftools --vcf CE_population_raw.vcf --max-missing 0.5 --minDP 5 --maxDP 100 --recode --stdout |grep -v "#" - | awk '{print $1"\t"$2-1"\t"$2}' - >CE_intervals_cov_by10-100_0.5.txt
bedtools merge -i  CE_intervals_cov_by5-100_0.5.txt >  CE_intervals_cov_by5-100_0.5.m.txt
awk '{print $1"\t"1"\t"$2}' ${ref}.fai > CE_genome.txt
bedtools subtract -a CE_genome.txt -b CE_intervals_cov_by5-100_0.5.m.txt >CE_region_with_bad_cov5-100_0.5.bed
python2 /projects/phillipslab/ateterina/scripts/generate_masked_ranges.py $refCEH |grep -v "MtDNA" - > CE.repeats.regions.nomt.bed
cat CE_region_with_bad_cov5-100_0.5.bed CE_indel_mask.bed CE.repeats.regions.nomt.bed ${VCF/raw.vcf/raw_complex.bed}|sort -k1,1 -k2,2n - | bedtools merge  -i -  >CE_mask_these_region5-100_0.5.bed
bedtools subtract -a ${VCF/raw/filt2_snps} -b CE_mask_these_region5-100_0.5.bed > ${VCF/raw/filt_snps_5-100_0.5}
grep "#" ${VCF/raw/filt2_snps} > ${VCF/raw/filt_snps_5-100_0.5_fin}
cat ${VCF/raw/filt_snps_5-100_0.5} >> ${VCF/raw/filt_snps_5-100_0.5_fin}
