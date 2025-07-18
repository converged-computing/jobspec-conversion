#!/bin/bash
#FLUX: --job-name=filt.vcf
#FLUX: --queue=phillips
#FLUX: -t=144000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load java easybuild GATK bedtools
ref="/projects/phillipslab/shared/ref_genomes/CR_PB_HIC/NCBI/CR.ncbi.softmasked.fasta"
refH="/projects/phillipslab/shared/ref_genomes/CR_PB_HIC/NCBI/CR.ncbi.hardmasked.fasta"
GATK="/projects/phillipslab/ateterina/scripts/gatk-4.1.4.1/gatk"
cd /projects/phillipslab/ateterina/CR_popgen/data/reads/BAMS
VCF="CR_WILD_population14_raw.vcf"
$GATK --java-options "-Xmx15g -Xms10g" \
          GatherVcfs \
        -I CR_WILD_full14_output.I.vcf \
        -I CR_WILD_full14_output.II.vcf \
        -I CR_WILD_full14_output.III.vcf \
        -I CR_WILD_full14_output.IV.vcf \
        -I CR_WILD_full14_output.V.vcf \
        -I CR_WILD_full14_output.X.vcf \
         --OUTPUT CR_WILD_population14_raw.vcf
$GATK --java-options "-Xmx15g -Xms10g" SelectVariants  \
    -R $ref -V  $VCF --select-type-to-include INDEL  \
    -O  ${VCF/raw/raw_indels}
$GATK --java-options "-Xmx15g -Xms10g" VariantFiltration  \
    -R $ref -V ${VCF/raw/raw_indels} \
    --filter-name "basic_indel_filter" \
    --filter-expression 'QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0 || SOR > 10.0' \
    -O ${VCF/raw/filt_indels}
grep "PASS" ${VCF/raw/filt_indels} |grep -v "#" - | awk '{print $1"\t"$2-1"\t"$2}' - |bedtools slop -i - -b 10 -g ${ref}.fai > CR_indel_mask_WILD.bed
$GATK --java-options "-Xmx15g -Xms10g" SelectVariants  \
        -R $ref -V  $VCF --select-type-to-include SNP --restrict-alleles-to BIALLELIC  \
        -O  ${VCF/raw/raw_snps}
$GATK --java-options "-Xmx15g -Xms10g" VariantFiltration  -R $ref -V ${VCF/raw/raw_snps} --filter-expression ' QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 3.0' --filter-name "basic_snp_filter" -O ${VCF/raw/filt_snps}
grep -P "#|PASS" ${VCF/raw/filt_snps} > ${VCF/raw/filt2_snps}
$GATK --java-options "-Xmx15g -Xms10g" SelectVariants  \
           -R $ref -V  $VCF --select-type-to-include SNP --select-type-to-include MIXED --select-type-to-include MNP --select-type-to-include INDEL  \
                   -O  ${VCF/raw/raw_complex}
module load bedtools
awk '{print $1"\t"$2-1"\t"$2}' ${VCF/raw/filt2_snps} | grep -v "#" - > ${VCF/raw.vcf/filt2_snps.bed}
awk '{print $1"\t"$2-1"\t"$2}' ${VCF/raw/raw_complex} | grep -v "#" - | bedtools subtract -a - -b ${VCF/raw.vcf/filt2_snps.bed} > ${VCF/raw.vcf/raw_complex.bed}
module load easybuild  icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 VCFtools/0.1.15-Perl-5.24.1
vcftools --vcf CR_WILD_population14_raw.vcf  --max-missing 0.5 --minDP 5 --maxDP 100 --recode --stdout |grep -v "#" - | awk '{print $1"\t"$2-1"\t"$2}' - >CR_intervals_cov_by5-100_0.5_WILD14.txt
module load bedtools
bedtools merge -i  CR_intervals_cov_by5-100_0.5_WILD.txt >  CR_intervals_cov_by5-100_0.5_WILD14.m.txt
awk '{print $1"\t"1"\t"$2}' ${ref}.fai > CR_genome.txt
bedtools subtract -a CR_genome.txt -b CR_intervals_cov_by5-100_0.5_WILD14.m.txt >CR_region_with_bad_cov_5-100_0.5_WILD14.bed
python2 /projects/phillipslab/ateterina/scripts/generate_masked_ranges.py $refH |grep -v "MtDNA" - > CR.repeats.regions.nomt.bed
cat CR_region_with_bad_cov_5-100_0.5_WILD14.bed CR_indel_mask_WILD.bed CR.repeats.regions.nomt.bed |sort -k1,1 -k2,2n - | bedtools merge  -i -  >CR_mask_these_region_5-100_0.5_WILD14.bed
bedtools subtract -a ${VCF/raw/filt2_snps} -b CR_mask_these_region_5-100_0.5_WILD14.bed > ${VCF/raw/filt_snps_5-100_0.5}
grep "#" ${VCF/raw/filt2_snps} > ${VCF/raw/filt_snps_5-100_0.5_fin}
cat ${VCF/raw/filt_snps_5-100_0.5} >> ${VCF/raw/filt_snps_5-100_0.5_fin}
