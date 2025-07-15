#!/bin/bash
#FLUX: --job-name=frigid-peanut-3681
#FLUX: -t=86400
#FLUX: --priority=16

numThreads=4
nonChrM=$(cat ${genomeChrFile} | awk '{print $1}' | grep -v chrM | tr '\n' ' ')
module load bwa samtools
queries=($(ls ${inDir}/*.fastq.gz | xargs -n 1 basename | sed 's/_1.fastq.gz//g' | sed 's/_2.fastq.gz//g' | uniq))
tmpDir=${outDir}/samtools_tmp/${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}
pwd; hostname; date
echo "bwa version: "$(bwa)
echo "Samtools version: "$(samtools --version)
echo "Making temporary directories..."
mkdir -p ${tmpDir}
pwd; hostname; date
echo "Aligning reads to the genome..."
echo "bwa version: "$(bwa)
echo "Samtools version: "$(samtools --version)
echo "Processing file: "${queries[$SLURM_ARRAY_TASK_ID]}
echo "Aligning to assembly: "${bwaIndex}
bwa mem \
-t ${numThreads} \
${bwaIndex} \
${inDir}/${queries[$SLURM_ARRAY_TASK_ID]}_R1_trimmed.fastq.gz \
${inDir}/${queries[$SLURM_ARRAY_TASK_ID]}_R2_trimmed.fastq.gz \
> ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}.sam
echo $(date +"[%b %d %H:%M:%S] Making flagstat file from unfiltered sam...")
samtools flagstat -@ ${numThreads} ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}.sam \
> ${reportsDir}/${queries[$SLURM_ARRAY_TASK_ID]}_flagstat.txt
echo $(date +"[%b %d %H:%M:%S] Converting sam to unfiltered bam & sorting")
samtools view -@ ${numThreads} -Sb -q 10 -F 4 ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}.sam \
| samtools sort -@ ${numThreads} -T ${tmpDir} - \
> ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}.sorted.tmp.bam
echo $(date +"[%b %d %H:%M:%S] Indexing unfiltered, sorted bams...")
samtools index \
${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}.sorted.tmp.bam \
> ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}.sorted.tmp.bam.bai
echo $(date +"[%b %d %H:%M:%S] Removing chrM reads and sorting...")
samtools view -b ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}.sorted.tmp.bam ${nonChrM} \
| samtools sort -@ ${numThreads} -T ${tmpDir} - \
> ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}_filtered.sorted.bam
echo $(date +"[%b %d %H:%M:%S] Indexing filtered, sorted bams...")
samtools index ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}_filtered.sorted.bam \
> ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}_filtered.sorted.bam.bai
echo $(date +"[%b %d %H:%M:%S] Making flagstat file from filtered bam...")
samtools flagstat -@ ${numThreads} ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}_filtered.sorted.bam \
> ${reportsDir}/${queries[$SLURM_ARRAY_TASK_ID]}_filtered_flagstat.txt
echo $(date +"[%b %d %H:%M:%S] Calculating percentage of total reads mapping to mitochondrial genome...")
chrMreads=`samtools view -c ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}.sorted.tmp.bam chrM`
totalReads=`samtools view -c ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}.sorted.tmp.bam`
fractionMreads=`echo "100 * ${chrMreads} / ${totalReads}" | bc -l`
touch ${reportsDir}/${queries[$SLURM_ARRAY_TASK_ID]}_chrMreadsFraction.txt
echo ${queries[$SLURM_ARRAY_TASK_ID]} >> ${reportsDir}/${queries[$SLURM_ARRAY_TASK_ID]}_chrMreadsFraction.txt
echo ${totalReads} 'total mapped reads' >> ${reportsDir}/${queries[$SLURM_ARRAY_TASK_ID]}_chrMreadsFraction.txt
echo ${chrMreads} 'mitochondrial reads' >> ${reportsDir}/${queries[$SLURM_ARRAY_TASK_ID]}_chrMreadsFraction.txt
echo ${fractionMreads} 'percentage of mitochondrial reads from total mapped reads' >> ${reportsDir}/${queries[$SLURM_ARRAY_TASK_ID]}_chrMreadsFraction.txt
echo $(date +"[%b %d %H:%M:%S] Removing intermediate files...")
rm ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}.sam
rm ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}.sorted.tmp.bam
rm ${outDir}/${queries[$SLURM_ARRAY_TASK_ID]}.sorted.tmp.bam.bai
rm -r ${tmpDir}
echo $(date +"[%b %d %H:%M:%S] Done")
