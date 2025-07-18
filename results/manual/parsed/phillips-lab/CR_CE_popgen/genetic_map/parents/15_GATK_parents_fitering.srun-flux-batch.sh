#!/bin/bash
#FLUX: --job-name=parents
#FLUX: -c=5
#FLUX: --queue=phillips
#FLUX: -t=180000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load java easybuild GATK bedtools
module load easybuild  icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 VCFtools/0.1.15-Perl-5.24.1
ref="/projects/phillipslab/shared/ref_genomes/CR_PB_HIC/NCBI/CR.ncbi.softmasked.fasta"
tmp="/projects/phillipslab/ateterina/tmp"
GATK="/projects/phillipslab/ateterina/scripts/gatk-4.1.4.1/gatk"
VCF="Parents_raw.vcf"
cd /projects/phillipslab/ateterina/CR_map/FINAL/Parents
$GATK --java-options "-Xmx15g -Xms10g" SelectVariants  \
        -R $ref -V  $VCF --select-type-to-include SNP --restrict-alleles-to BIALLELIC  \
        -O  ${VCF/raw/raw_snps}
$GATK --java-options "-Xmx15g -Xms10g" VariantFiltration  -R $ref -V ${VCF/raw/raw_snps} --filter-expression ' QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 3.0' --filter-name "basic_snp_filter" -O ${VCF/raw/filt_snps}
grep -P "#|PASS" ${VCF/raw/filt_snps} > ${VCF/raw/filt2_snps}
cp /projects/phillipslab/ateterina/CR_popgen/data/MASKS/CR.repeats.regions.bed /projects/phillipslab/ateterina/CR_map/FINAL/Parents/
bedtools subtract -a ${VCF/raw/filt2_snps} -b CR.repeats.regions.bed > ${VCF/raw/filt2_snps_norep}
grep "#" ${VCF/raw/filt2_snps} > ${VCF/raw/filt2_snps_norep_ok}
cat ${VCF/raw/filt2_snps_norep} >> ${VCF/raw/filt2_snps_norep_ok}
vcftools --vcf ${VCF/raw/filt2_snps_norep_ok}  --max-missing 1.0 --minDP 10 --maxDP 200 --recode --stdout > ${VCF/raw/variant_lib}
grep -v "##" ${VCF/raw/variant_lib} | awk '{print $1"\t"$2-1"\t"$2}' - > ${VCF/raw.vcf/variant_lib.bed}
