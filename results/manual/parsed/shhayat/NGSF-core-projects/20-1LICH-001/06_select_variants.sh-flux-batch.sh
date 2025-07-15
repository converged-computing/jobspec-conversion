#!/bin/bash
#FLUX: --job-name=select_variants
#FLUX: -t=1800
#FLUX: --priority=16

module load nixpkgs/16.09 
module load gcc/5.4.0
module load intel/2016.4
module load intel/2017.1
module load bedtools
INPUT_DIR=/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/20-1LICH-001/analysis/removed_shared_varaints_between_uninduced_induced
OUTPUT_DIR1='/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/20-1LICH-001/analysis/filtered_v1'
OUTPUT_DIR2='/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/20-1LICH-001/analysis/filtered_v2'
GENOME='/datastore/NGSF001/analysis/references/human/gencode-30/GRCh38.primary_assembly.genome.fa'
mkdir -p ${OUTPUT_DIR1}
mkdir -p ${OUTPUT_DIR2}
CLONE_ID=$1
SAMPLE_ID=$2
gunzip -k ${INPUT_DIR}/${CLONE_ID}_${SAMPLE_ID}_I.vcf.gz
echo "convert vcf to bed file"
/globalhome/hxo752/HPC/tools/bedops/convert2bed -i vcf < ${INPUT_DIR}/${CLONE_ID}_${SAMPLE_ID}_I.vcf -d >  ${INPUT_DIR}/${CLONE_ID}_${SAMPLE_ID}_I.bed
echo "Base Conversions"
awk -v OFS='\t' '{print $1,$2,$3,$6,$7}' ${INPUT_DIR}/${CLONE_ID}_${SAMPLE_ID}_I.bed | grep -P '\tC\tG$' >> ${OUTPUT_DIR1}/${CLONE_ID}_${SAMPLE_ID}_base_conversion.bed
awk -v OFS='\t' '{print $1,$2,$3,$6,$7}' ${INPUT_DIR}/${CLONE_ID}_${SAMPLE_ID}_I.bed | grep -P '\tC\tT$' >> ${OUTPUT_DIR1}/${CLONE_ID}_${SAMPLE_ID}_base_conversion.bed
awk -v OFS='\t' '{print $1,$2,$3,$6,$7}' ${INPUT_DIR}/${CLONE_ID}_${SAMPLE_ID}_I.bed | grep -P '\tG\tA$' >> ${OUTPUT_DIR2}/${CLONE_ID}_${SAMPLE_ID}_base_conversion.bed
awk -v OFS='\t' '{print $1,$2,$3,$6,$7}' ${INPUT_DIR}/${CLONE_ID}_${SAMPLE_ID}_I.bed | grep -P '\tG\tC$' >> ${OUTPUT_DIR2}/${CLONE_ID}_${SAMPLE_ID}_base_conversion.bed
echo "select 2 bases upstream and downstream of bases"
bedtools flank -i ${OUTPUT_DIR1}/${CLONE_ID}_${SAMPLE_ID}_base_conversion.bed -g /datastore/NGSF001/analysis/references/human/gencode-30/chrom.sizes -b 2 > ${OUTPUT_DIR1}/${CLONE_ID}_${SAMPLE_ID}_flanked_2bp_upstream_downstream.bed
bedtools flank -i ${OUTPUT_DIR2}/${CLONE_ID}_${SAMPLE_ID}_base_conversion.bed -g /datastore/NGSF001/analysis/references/human/gencode-30/chrom.sizes -b 2 > ${OUTPUT_DIR2}/${CLONE_ID}_${SAMPLE_ID}_flanked_2bp_upstream_downstream.bed
echo "extract flanked bases from fasta file"
bedtools getfasta -fi ${GENOME} -bed ${OUTPUT_DIR1}/${CLONE_ID}_${SAMPLE_ID}_flanked_2bp_upstream_downstream.bed -tab > ${OUTPUT_DIR1}/${CLONE_ID}_${SAMPLE_ID}_flanked_bases.txt
bedtools getfasta -fi ${GENOME} -bed ${OUTPUT_DIR2}/${CLONE_ID}_${SAMPLE_ID}_flanked_2bp_upstream_downstream.bed -tab > ${OUTPUT_DIR2}/${CLONE_ID}_${SAMPLE_ID}_flanked_bases.txt
echo "add each second line to first line"
awk '{printf "%s%s",$0,NR%2?"\t":RS}' ${OUTPUT_DIR1}/${CLONE_ID}_${SAMPLE_ID}_flanked_bases.txt > ${OUTPUT_DIR1}/${CLONE_ID}_${SAMPLE_ID}_flanked_bases_v1.txt
awk '{printf "%s%s",$0,NR%2?"\t":RS}' ${OUTPUT_DIR2}/${CLONE_ID}_${SAMPLE_ID}_flanked_bases.txt > ${OUTPUT_DIR2}/${CLONE_ID}_${SAMPLE_ID}_flanked_bases_v1.txt
echo "join C to T/G conversions with their 2upstream and downtream base pairs"
paste --delimiters='\t' ${OUTPUT_DIR1}/${CLONE_ID}_${SAMPLE_ID}_base_conversion.bed ${OUTPUT_DIR1}/${CLONE_ID}_${SAMPLE_ID}_flanked_bases_v1.txt > ${OUTPUT_DIR1}/${CLONE_ID}_${SAMPLE_ID}.txt
echo "join G to A/C conversions with their 2upstream and downtream base pairs"
paste --delimiters='\t' ${OUTPUT_DIR2}/${CLONE_ID}_${SAMPLE_ID}_base_conversion.bed ${OUTPUT_DIR2}/${CLONE_ID}_${SAMPLE_ID}_flanked_bases_v1.txt > ${OUTPUT_DIR2}/${CLONE_ID}_${SAMPLE_ID}_v1.txt
