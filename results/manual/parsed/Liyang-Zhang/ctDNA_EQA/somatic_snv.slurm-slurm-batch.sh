#!/bin/bash
#FLUX: --job-name=H016
#FLUX: --queue=small
#FLUX: --urgency=16

export IAMGE_NAME='/lustre/home/acct-medkwf/medkwf4/software/CRUK/dockstore-cgpwxs_3.1.7.sif'

tumor=$1
normal=$2
project_dir=$3
baseSuper=`basename ${tumor} .bqsr.bam`
base=$(echo ${baseSuper} | cut -d'_' -f 1)  # get the filename with basename function
echo "base is ${base}"
echo "Tumor sample is ${tumor}"
echo "Normal sample is ${normal}"
genome_19=/lustre/home/acct-medkwf/medkwf/database/GATK/hg19/ucsc.hg19.fasta
mkdir -p ~/results/MRD/samtools/
mkdir -p ~/results/MRD/bam-readcount/
mkdir -p ~/results/MRD/Strelka/${base}/
mkdir -p ~/results/MRD/Mutect2/
mkdir -p ~/results/MRD/VarDict/
mkdir -p ~/results/MRD/bed/
mkdir -p ~/results/MRD/Caveman/
mkdir -p ~/results/MRD/annovar/
mkdir -p ~/results/MRD/varscan2
bam=~/results/MRD/bam_19
varscan=~/results/MRD/varscan2
annovar=~/results/MRD/annovar
samtools=~/results/MRD/samtools
BRC=~/results/MRD/bam-readcount
Strelka=~/results/MRD/Strelka/${base}
Mutect2=~/results/MRD/Mutect2
VarDict=~/results/MRD/VarDict
VarDictPath=/lustre/home/acct-medkwf/medkwf4/software/vardict/share/vardict-2019.06.04-0
bed=~/results/MRD/bed
Caveman=~/results/MRD/Caveman
tumor_mpileup=${varscan}/${base}.tumor.mpileup
normal_mpileup=${varscan}/${base}.normal.mpileup
out_snv=${varscan}/${base}.somatic.vcf
filter_snv=${varscan}/${base}.str10.ps.hc.fs.vcf
normal_tumor_mpileup=${samtools}/${base}.normal-tumor.mpileup
tumor_sorted=${samtools}/${base}.sortedtumor.bam
normal_sorted=${samtools}/${base}.sortednormal.bam
filter_indel=${varscan}/${base}.filterindel.vcf
annovar_aviinput=${annovar}/${base}.snv
annovar_indel_aviinput=${annovar}/${base}.indel
annovar_merged_input=${annovar}/${base}.merge
annovar_annotated=${annovar}/${base}.csv
BRC_list=${BRC}/${base}.variants.sites
BRC_readcount=${BRC}/${base}.readcount
fpfilter=${varscan}/${base}.str10.ps.hc.fs.fpfilter
output_Mutect=${Mutect2}/${base}.mutect2.vcf.gz
normal_name=${Mutect2}/${base}.normalname.txt
tumor_name=${Mutect2}/${base}.tumorname.txt
filter_Mutect=${Mutect2}/${base}.filter.vcf.gz
output_Strelka=${Strelka}/results/variants/somatic.snv.2.vcf
annovar_aviinput_Strelka=${annovar}/${base}.2.strelka
annovar_annotated_Strelka=${annovar}/${base}.2.strelka.csv
output_Mutect2=${Mutect2}/${base}.mutect2.1.vcf
annovar_aviinput_Mutect2=${annovar}/${base}.mutect2
annovar_annotated_Mutect2=${annovar}/${base}.mutect2.csv
output_Varscan=${varscan}/P042.str10.fpf.vcf
output_Varscan_failed=${varscan}/P042.str10.fpf.fail.vcf
annovar_aviinput_Varscan=${annovar}/${base}.Varscan
annovar_annotated_Varscan=${annovar}/${base}.Varscan.csv
tumor_bed=${bed}/${base}.sorted.bed
VarDict_out=${VarDict}/${base}.VarDict.vcf
target_bed=/lustre/home/acct-medkwf/medkwf4/reference/bed/${base}.target.bed
filter_Mutect_Man=${Mutect2}/${base}.filter.2.vcf
out_snv_merge=${varscan}/${base}.snv.hc
module load picard
module load bedtools2
module load miniconda3
source activate dna
module load samtools
export IAMGE_NAME=/lustre/home/acct-medkwf/medkwf4/software/CRUK/dockstore-cgpwxs_3.1.7.sif
cores=4
/lustre/home/acct-medkwf/medkwf4/software/annovar/convert2annovar.pl --format vcf4old --includeinfo --withzyg ${output_Varscan} > ${annovar_aviinput_Varscan}
/lustre/home/acct-medkwf/medkwf4/software/annovar/table_annovar.pl ${annovar_aviinput_Varscan} /lustre/home/acct-medkwf/medkwf4/software/annovar/humandb -buildver hg19 -out ${annovar_annotated_Varscan} -polish -remove -protocol refGene,icgc28,gnomad_exome,EAS.sites.2014_10,avsnp144,EAS.sites.2015_08,cosmic70,nci60  -operation g,f,f,f,f,f,f,f --otherinfo -csvout
