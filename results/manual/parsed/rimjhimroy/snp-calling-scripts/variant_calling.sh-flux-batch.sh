#!/bin/bash
#FLUX: --job-name=BQSR
#FLUX: -c=8
#FLUX: --queue=all
#FLUX: -t=345600
#FLUX: --urgency=16

export PATH='/software/bin:$PATH;'

start=$(date +%s.%N)
REF=$1
SAMPLE=$2
BASEDIR=$3
PLOIDY=$4
export PATH=/software/bin:$PATH;
module use /software/module/
module add vital-it
module add UHTS/Aligner/bwa/0.7.17
module add UHTS/Analysis/samtools/1.8
module add UHTS/Analysis/picard-tools/2.18.11
module add UHTS/Analysis/GenomeAnalysisTK/4.1.3.0
module add R/latest
mkdir -p ${BASEDIR}/BQSR
cd ${BASEDIR}/BQSR
BAMNAME=$(basename -s .bam ${SAMPLE})
mkdir base_recalibration_${BAMNAME}
cd base_recalibration_${BAMNAME}
mkdir temp
s=$(basename ${REF})
REFNAME=${s%.*}
ln -s ${REF} ${REFNAME}.fa
ln -s ${SAMPLE} ${BAMNAME}.bam
bwa index ${REFNAME}.fa
samtools faidx ${REFNAME}.fa
picard-tools CreateSequenceDictionary R=${REFNAME}.fa O=${REFNAME}.dict
picard-tools BuildBamIndex INPUT=${BAMNAME}.bam
GATK4="java -Xmx25g -Djava.oi.tmpdir=`pwd`/tmp -jar /software/UHTS/Analysis/GenomeAnalysisTK/4.1.3.0/bin/GenomeAnalysisTK.jar "
call="$GATK4 HaplotypeCaller -R ${REFNAME}.fa -I ${BAMNAME}.bam -O ${BAMNAME}_raw_variants_1.vcf.gz -ploidy ${PLOIDY} --native-pair-hmm-threads ${SLURM_CPUS_PER_TASK}"
printf "\n\nStep1:: ${call}\n\n" 
eval $call
call2="$GATK4 SelectVariants -R ${REFNAME}.fa -V ${BAMNAME}_raw_variants_1.vcf.gz -select-type SNP -O ${BAMNAME}_raw_SNPs_1.vcf.gz"
printf "\n\nStep2:: ${call2}\n\n"
eval $call2
call3="$GATK4 SelectVariants -R ${REFNAME}.fa -V ${BAMNAME}_raw_variants_1.vcf.gz -select-type INDEL -O ${BAMNAME}_raw_INDELs_1.vcf.gz"
printf "\n\nStep3:: ${call3}\n\n"
eval $call3
call4="$GATK4 VariantFiltration -R ${REFNAME}.fa -V ${BAMNAME}_raw_SNPs_1.vcf.gz -O ${BAMNAME}_raw_SNPs_2.vcf.gz -filter 'QD < 2.0' --filter-name 'QD2' -filter 'QUAL < 30.0' --filter-name 'QUAL30' -filter 'SOR > 3.0' --filter-name 'SOR3' -filter 'FS > 60.0' --filter-name 'FS60' -filter 'MQ < 40.0' --filter-name 'MQ40' -filter 'MQRankSum < -12.5' --filter-name 'MQRankSum-12.5' -filter 'ReadPosRankSum < -8.0' --filter-name 'ReadPosRankSum-8'"
printf "\n\nStep4:: ${call4}\n\n"
eval $call4
call5="$GATK4 VariantFiltration -R ${REFNAME}.fa -V ${BAMNAME}_raw_INDELs_1.vcf.gz -O ${BAMNAME}_raw_INDELs_2.vcf.gz -filter 'QD < 2.0' --filter-name 'QD2' -filter 'QUAL < 30.0' --filter-name 'QUAL30' -filter 'FS > 200.0' --filter-name 'FS200' -filter 'ReadPosRankSum < -20.0' --filter-name 'ReadPosRankSum-20'"
printf "\n\nStep5:: ${call5}\n\n"
eval $call5
call5_1="$GATK4 SelectVariants --exclude-filtered -R ${REFNAME}.fa -V ${BAMNAME}_raw_SNPs_2.vcf.gz -O ${BAMNAME}_filtered_SNPs_2.vcf.gz"
printf "\n\nStep5_1:: ${call5_1}\n\n"
eval $call5_1
call5_2="$GATK4 SelectVariants --exclude-filtered -R ${REFNAME}.fa -V ${BAMNAME}_raw_INDELs_2.vcf.gz -O ${BAMNAME}_filtered_INDELs_2.vcf.gz"
printf "\n\nStep5_2:: ${call5_2}\n\n"
eval $call5_2
call6="$GATK4 BaseRecalibrator -R ${REFNAME}.fa -I ${BAMNAME}.bam --known-sites ${BAMNAME}_filtered_SNPs_2.vcf.gz --known-sites ${BAMNAME}_filtered_INDELs_2.vcf.gz -O ${BAMNAME}_recal_model_1.grp"
printf "\n\nStep6:: ${call6}\n\n"
eval $call6
call7="$GATK4 ApplyBQSR -R ${REFNAME}.fa -I ${BAMNAME}.bam --bqsr-recal-file ${BAMNAME}_recal_model_1.grp -O ${BAMNAME}_recal_1.bam --emit-original-quals --static-quantized-quals 10 --static-quantized-quals 20 --static-quantized-quals 30 --add-output-sam-program-record --create-output-bam-md5"
printf "\n\nStep7:: ${call7}\n\n"
eval $call7
call8="$GATK4 BaseRecalibrator -R ${REFNAME}.fa -I ${BAMNAME}_recal_1.bam --known-sites ${BAMNAME}_filtered_SNPs_2.vcf.gz --known-sites ${BAMNAME}_filtered_INDELs_2.vcf.gz -O ${BAMNAME}_recal_model_2.grp"
printf "\n\nStep8:: ${call8}\n\n"
eval $call8
call9="$GATK4 AnalyzeCovariates -before ${BAMNAME}_recal_model_1.grp -after ${BAMNAME}_recal_model_2.grp -plots ${BAMNAME}_recalibration_1_2.pdf"
printf "\n\nStep9:: ${call9}\n\n"
eval $call9
call10="$GATK4 HaplotypeCaller -R ${REFNAME}.fa -I ${BAMNAME}_recal_1.bam -O ${BAMNAME}_final_variants.g.vcf.gz -ploidy ${PLOIDY} --pcr-indel-model NONE --native-pair-hmm-threads ${SLURM_CPUS_PER_TASK} -ERC GVCF"
printf "\n\nStep10:: ${call10}\n\n"
eval $call10
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds" $dur
