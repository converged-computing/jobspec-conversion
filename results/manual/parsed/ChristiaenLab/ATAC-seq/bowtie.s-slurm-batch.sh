#!/bin/bash
#FLUX: --job-name=bowtie
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load bowtie2/intel/2.3.2
module load samtools/intel/1.3.1
module load ngsutils/intel/0.5.9
module load picard/2.8.2
module load preseq/intel/2.0.1
module load deeptools/intel/2.4.2
module load  bedtools/intel/2.26.0
module load r/intel/3.4.2
module load trim_galore/0.4.4
module load cutadapt/intel/1.12
RUNDIR=/scratch/kaw504/atacCiona/atac
cd $RUNDIR
N1=$(awk "NR==${SLURM_ARRAY_TASK_ID} {print \$1}" bowtie/fastq.txt)
N2=${N1/n01/n02}
sample=${N1/n01/}
cd bowtie
trim_galore --nextera --paired --gzip --three_prime_clip_R1 1 --three_prime_clip_R2 1 ${sample}.unaligned.1.fastq ${sample}.unaligned.2.fastq
bowtie2 --no-discordant -p 20 --no-mixed -N 1 -X 1000  --un-conc ${sample}.still_unaligned.fastq -x /scratch/kaw504/atacCiona/august/JoinedScaffold -1 ${sample}.unaligned.1_val_1.fq.gz  -2 ${sample}.unaligned.2_val_2.fq.gz -S ${sample}.aligned.sam
samtools view -Sb -q 30 ${sample}.aligned.sam > ${sample}.trimmed.bam
rm ${sample}.aligned.sam
samtools cat -o ${sample}.merged.bam ${sample}_q30.bam ${sample}.trimmed.bam
samtools view -b -F 4 ${sample}.merged.bam > ${sample}.mapped.bam
samtools sort -o ${sample}.srt.bam ${sample}.mapped.bam 
samtools rmdup ${sample}.srt.bam ${sample}.rmd.srt.bam 
java -Xmx10g -jar /share/apps/picard/2.8.2/picard-2.8.2.jar MarkDuplicates INPUT=${sample}.rmd.srt.bam OUTPUT=${sample}_q30_rmdup_sorted.bam METRICS_FILE=${sample}_DEDUPL.out.mat REMOVE_DUPLICATES=true ASSUME_SORTED=true MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=2048
bamutils filter ${sample}_q30_rmdup_sorted.bam  ${sample}_q30_rmdup_KhM0_sorted.bam -excluderef KhM0
samtools index ${sample}_q30_rmdup_KhM0_sorted.bam
samtools flagstat ${sample}.merged.bam > ${sample}.stats
samtools flagstat ${sample}.rmd.srt.bam >> ${sample}.stats
samtools flagstat ${sample}_q30_rmdup_KhM0_sorted.bam >> ${sample}.stats
preseq lc_extrap -P -o ${sample}.txt <( bamToBed -i ${sample}.srt.bam )
java -Xmx10g -jar /share/apps/picard/2.8.2/picard-2.8.2.jar CollectInsertSizeMetrics I=${sample}_q30_rmdup_KhM0_sorted.bam O=${sample}_insert_sizes.txt H=${sample}.pdf
bamCoverage -of bigwig -o ${sample}.bw -b ${sample}_q30_rmdup_KhM0_sorted.bam --ignoreDuplicates -p 20 --minMappingQuality 30 --centerReads -ignore KhM0 --normalizeUsingRPKM
exit 0;
