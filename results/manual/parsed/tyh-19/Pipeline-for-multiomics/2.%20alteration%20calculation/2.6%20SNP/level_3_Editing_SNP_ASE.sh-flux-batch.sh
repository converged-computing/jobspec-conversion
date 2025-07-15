#!/bin/bash
#FLUX: --job-name=moolicious-egg-2335
#FLUX: --priority=16

dataset=$1
tmp="/data/taoyuhuan/projects/exOmics_RNA/level_3_Editing_SNP_ASE/${dataset}/tmp"
mkdir -p ${tmp}
input="/data/taoyuhuan/projects/exOmics_RNA/${dataset}/output/bam"
output="/data/taoyuhuan/projects/exOmics_RNA/level_3_Editing_SNP_ASE/${dataset}"
mkdir -p ${output}
mkdir -p ${output}/bam_RG
mkdir -p ${output}/bam_Intronspanning
mkdir -p ${output}/REDIportal
mkdir -p ${output}/ASE
mkdir -p ${output}/ASE/dbSNP
mkdir -p ${output}/ASE/COSMIC
mkdir -p ${output}/SNP
mkdir -p ${output}/SNP/tmp
mkdir -p ${output}/matrix
ref="/data/taoyuhuan/projects/exOmics_RNA/bin"
log="/data/taoyuhuan/projects/exOmics_RNA/level_3_Editing_SNP_ASE/${dataset}/log"
mkdir -p ${log}
mkdir -p ${log}/ReadGroup
mkdir -p ${log}/REDIportal
mkdir -p ${log}/ASE
mkdir -p ${log}/ASE/dbSNP
mkdir -p ${log}/ASE/COSMIC
mkdir -p ${log}/SNP
echo "Start Editing ASE SNP analysis for ${dataset} at `date`."
for sample in $(ls ${input} | grep -w $2)
do
echo "Start analysis ${sample} at `date`."
/data/taoyuhuan/tools/gatk-4.1.9.0/gatk AddOrReplaceReadGroups --java-options -Xmx4G \
	--INPUT ${input}/${sample}/2passMode_rmdup.bam \
	--OUTPUT ${output}/bam_RG/${sample}_2passMode_rmdup_RG.bam \
	--TMP_DIR ${tmp} \
	-SO coordinate \
	--RGLB library \
	--RGPL illumina \
	--RGPU HiSeq_X_Ten \
	--RGSM ${sample} > ${log}/ReadGroup/${sample} 2>&1
samtools index ${output}/bam_RG/${sample}_2passMode_rmdup_RG.bam
/data/taoyuhuan/tools/gatk-4.1.9.0/gatk SplitNCigarReads --java-options -Xmx4G \
        --input ${output}/bam_RG/${sample}_2passMode_rmdup_RG.bam \
        --output ${output}/bam_Intronspanning/${sample}_Intronspanning.bam \
        --create-output-bam-index -R ${ref}/genome/fasta/hg38.fa \
        --tmp-dir ${output}/SNP/tmp 2> ${log}/SNP/${sample}.split.log
/data/taoyuhuan/tools/gatk-4.1.9.0/gatk ASEReadCounter --java-options -Xmx4G \
	--input ${output}/bam_Intronspanning/${sample}_Intronspanning.bam \
	--tmp-dir ${tmp} \
	--variant ${ref}/genome/vcf/REDIportal.vcf.gz \
	--reference ${ref}/genome/fasta/hg38.fa \
	--output-format TABLE 2> ${log}/REDIportal/${sample} | gzip -c > ${output}/REDIportal/${sample}.REDI.gz
/data/taoyuhuan/tools/gatk-4.1.9.0/gatk ASEReadCounter --java-options -Xmx4G \
	--input ${output}/bam_Intronspanning/${sample}_Intronspanning.bam \
	--tmp-dir ${tmp} \
	--variant ${ref}/genome/vcf/dbSNP.vcf.gz \
	--reference ${ref}/genome/fasta/hg38.fa \
	--output-format TABLE 2> ${log}/ASE/dbSNP/${sample} | gzip -c > ${output}/ASE/dbSNP/${sample}.dbSNP.gz
/data/taoyuhuan/tools/gatk-4.1.9.0/gatk ASEReadCounter --java-options -Xmx4G \
	--input ${output}/bam_Intronspanning/${sample}_Intronspanning.bam \
	--tmp-dir ${tmp} \
	--variant ${ref}/genome/vcf/COSMIC.vcf.gz \
	--reference ${ref}/genome/fasta/hg38.fa \
	--output-format TABLE 2> ${log}/ASE/COSMIC/${sample} | gzip -c > ${output}/ASE/COSMIC/${sample}.COSMIC.gz
/data/taoyuhuan/tools/gatk-4.1.9.0/gatk HaplotypeCaller --java-options -Xmx4G \
	-R ${ref}/genome/fasta/hg38.fa \
	-I ${output}/bam_Intronspanning/${sample}_Intronspanning.bam -O ${output}/SNP/${sample} \
	--tmp-dir ${output}/SNP/tmp 2>  ${log}/SNP/${sample}.callSNP.log
/data/taoyuhuan/tools/gatk-4.1.9.0/gatk VariantFiltration --java-options -Xmx4G \
	-R ${ref}/genome/fasta/hg38.fa -V ${output}/SNP/${sample} \
	-window 35 -cluster 3 \
	--tmp-dir ${tmp} \
	--filter-name FS20 -filter "FS > 20.0" \
	--filter-name QD2 -filter "QD < 2.0" \
	--filter-name DP10 -filter "DP < 10.0" \
	--filter-name QUAL20 -filter "QUAL < 20.0" -O ${output}/SNP/${sample}.SNP 2> ${log}/SNP/${sample}.filter.log
rm ${output}/SNP/${sample} 
bedtools intersect -v -header -a ${output}/SNP/${sample}.SNP -b ${ref}/genome/vcf/REDIportal.vcf.gz | bgzip -c > ${output}/SNP/${sample}.rmEDIT.SNP.gz
echo "End analysis ${sample} at `date`."
done
echo "Finish Editing ASE SNP analysis for ${dataset} at `date`."
