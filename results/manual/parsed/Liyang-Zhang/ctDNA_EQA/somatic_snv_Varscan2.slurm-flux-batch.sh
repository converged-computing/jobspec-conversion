#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=64c512g
#FLUX: --priority=16

tumor=$1
normal=$2
baseSuper=`basename ${tumor} .sort.bam`
base=$(echo ${baseSuper} | cut -d'_' -f 2)  # get the filename with basename function
echo "base is ${base}"
echo "Tumor sample is ${tumor}"
echo "Normal sample is ${normal}"
project_dir=/dssg/home/acct-medkwf/medkwf4/results/ctDNA_EQA/${base}
mkdir -p ${project_dir}
working_dir=${project_dir}/Varscan2
mkdir -p ${working_dir}
annovar=${project_dir}/ANNOVAR
mkdir -p ${annovar}
bed=${project_dir}/bed
mkdir -p ${bed}
BRC=${project_dir}/bam-readcount
mkdir -p ${BRC}
genome_19=/dssg/home/acct-medkwf/medkwf4/database/GATK/hg19/ucsc.hg19.fasta
module load miniconda3
source activate dna
cores=4
normal_tumor_mpileup=${working_dir}/${base}.normal-tumor.mpileup
out_snv=${working_dir}/${base}.somatic.vcf
out_snv_merge=${working_dir}/${base}.snv.hc
filter_snv=${working_dir}/${base}.ps.hc.sf.vcf
target_bed=${bed}/${base}.target.bed
BRC_readcount=${BRC}/${base}.readcount
output_Varscan=${working_dir}/${base}.fianl.vcf
output_Varscan_failed=${working_dir}/${base}.final.fail.vcf 
annovar_aviinput_Varscan=${annovar}/${base}.Varscan
annovar_annotated_Varscan=${annovar}/${base}.Varscan.csv
region_bed=/dssg/home/acct-medkwf/medkwf4/reference/bed/602panel/NanOnco_Plus_Panel_v2.0_Covered_b37_cg.parY2X.sort.chr.bed
/dssg/home/acct-medkwf/medkwf4/software/annovar/convert2annovar.pl --format vcf4old --includeinfo --withzyg ${output_Varscan} > ${annovar_aviinput_Varscan}
/dssg/home/acct-medkwf/medkwf4/software/annovar/table_annovar.pl ${annovar_aviinput_Varscan} /dssg/home/acct-medkwf/medkwf4/software/annovar/humandb -buildver hg19 -out ${annovar_annotated_Varscan} -polish -remove -protocol refGene,clinvar_20170905,icgc28,gnomad_exome,EAS.sites.2014_10,avsnp144,EAS.sites.2015_08,cosmic70,nci60  -operation g,f,f,f,f,f,f,f,f --otherinfo -csvout
