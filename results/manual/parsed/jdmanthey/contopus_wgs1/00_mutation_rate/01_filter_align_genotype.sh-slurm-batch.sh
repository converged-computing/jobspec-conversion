#!/bin/bash
#FLUX: --job-name=bam
#FLUX: -n=36
#FLUX: --queue=quanah
#FLUX: -t=172800
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='/lustre/work/jmanthey/singularity-cachedir'

module load intel java bwa samtools singularity
export SINGULARITY_CACHEDIR="/lustre/work/jmanthey/singularity-cachedir"
workdir=/lustre/scratch/jmanthey/15_contopus/30_mutation_rate
basename_array=$( head -n${SLURM_ARRAY_TASK_ID} ${workdir}/basenames.txt | tail -n1 )
refgenome=/lustre/scratch/jmanthey/15_contopus/30_mutation_rate/GCF_009829145.1_bChiLan1.pri_genomic.fna
/lustre/work/jmanthey/bbmap/bbduk.sh in1=${workdir}/00_fastq/${basename_array}_R1.fastq.gz in2=${workdir}/00_fastq/${basename_array}_R2.fastq.gz out1=${workdir}/01_cleaned/${basename_array}_R1.fastq.gz out2=${workdir}/01_cleaned/${basename_array}_R2.fastq.gz minlen=50 ftl=10 qtrim=rl trimq=10 ktrim=r k=25 mink=7 ref=/lustre/work/jmanthey/bbmap/resources/adapters.fa hdist=1 tbo tpe
bwa mem -t 34 ${refgenome} ${workdir}/01_cleaned/${basename_array}_R1.fastq.gz ${workdir}/01_cleaned/${basename_array}_R2.fastq.gz > ${workdir}/01_bam_files/${basename_array}.sam
samtools view -b -S -o ${workdir}/01_bam_files/${basename_array}.bam ${workdir}/01_bam_files/${basename_array}.sam
rm ${workdir}/01_bam_files/${basename_array}.sam
singularity exec $SINGULARITY_CACHEDIR/gatk_4.2.3.0.sif gatk CleanSam -I ${workdir}/01_bam_files/${basename_array}.bam -O ${workdir}/01_bam_files/${basename_array}_cleaned.bam
rm ${workdir}/01_bam_files/${basename_array}.bam
singularity exec $SINGULARITY_CACHEDIR/gatk_4.2.3.0.sif gatk SortSam -I ${workdir}/01_bam_files/${basename_array}_cleaned.bam -O ${workdir}/01_bam_files/${basename_array}_cleaned_sorted.bam --SORT_ORDER coordinate
rm ${workdir}/01_bam_files/${basename_array}_cleaned.bam
singularity exec $SINGULARITY_CACHEDIR/gatk_4.2.3.0.sif gatk AddOrReplaceReadGroups -I ${workdir}/01_bam_files/${basename_array}_cleaned_sorted.bam -O ${workdir}/01_bam_files/${basename_array}_cleaned_sorted_rg.bam --RGLB 1 --RGPL illumina --RGPU unit1 --RGSM ${basename_array}
rm ${workdir}/01_bam_files/${basename_array}_cleaned_sorted.bam
singularity exec $SINGULARITY_CACHEDIR/gatk_4.2.3.0.sif gatk MarkDuplicates --REMOVE_DUPLICATES true --MAX_FILE_HANDLES_FOR_READ_ENDS_MAP 100 -M ${workdir}/01_bam_files/${basename_array}_markdups_metric_file.txt -I ${workdir}/01_bam_files/${basename_array}_cleaned_sorted_rg.bam -O ${workdir}/01_bam_files/${basename_array}_final.bam
rm ${workdir}/01_bam_files/${basename_array}_cleaned_sorted_rg.bam
samtools index ${workdir}/01_bam_files/${basename_array}_final.bam
bcftools mpileup --skip-indels -C 0 -d 250 --threads 34 -Ou -f ${refgenome} ${workdir}/01_bam_files/${basename_array}_final.bam | bcftools call -m -Ov -o ${workdir}/02_vcf/${basename_array}.vcf
bgzip ${workdir}/02_vcf/${basename_array}.vcf
tabix ${workdir}/02_vcf/${basename_array}.vcf.gz
