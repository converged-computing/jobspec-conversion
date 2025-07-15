#!/bin/bash
#FLUX: --job-name=outstanding-cat-6708
#FLUX: -t=86400
#FLUX: --urgency=16

numThreads=8
module load bedtools
module load samtools
queries=($(ls ${bamDir}/*.sorted.bam | xargs -n 1 basename | sed 's/.sorted.bam//g'))
pwd; hostname; date
echo "Bedtools version: "$(bedtools --version)
echo "Samtools version: "$(samtools --version)
echo "Processing file: "${bamDir}/${queries[$SLURM_ARRAY_TASK_ID]}
echo $(date +"[%b %d %H:%M:%S] Calculating total reads and peak reads...")
totalReads=`samtools view -c ${bamDir}/${queries[$SLURM_ARRAY_TASK_ID]}.sorted.bam`
echo "Total number of reads: "$(echo $totalReads)
peakReads=`bedtools sort -i ${peakDir}/${queries[$SLURM_ARRAY_TASK_ID]}_mergedpeaks.bed \
| bedtools merge -i - \
| bedtools intersect -u -nonamecheck -a ${bamDir}/${queries[$SLURM_ARRAY_TASK_ID]}.sorted.bam -b - -ubam \
| samtools view -c`
echo "Number of reads in peaks: "$(echo $peakReads)
echo $(date +"[%b %d %H:%M:%S] Calculating FRIP...")
FRIP=`awk "BEGIN {print "${peakReads}"/"${totalReads}"}"`
echo "${queries[$SLURM_ARRAY_TASK_ID]}" > ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}_FRIP.txt
echo "Total number of mapped reads: "$(echo $totalReads) >> ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}_FRIP.txt
echo "Number of mapped reads in peaks: "$(echo $peakReads) >> ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}_FRIP.txt
echo "Fraction of mapped reads in peaks (FRiP): "$(echo $FRIP) >> ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}_FRIP.txt
echo $(date +"[%b %d %H:%M:%S] Done!")
