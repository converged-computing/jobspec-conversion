#!/bin/bash
#FLUX: --job-name=RNAseq
#FLUX: -c=2
#FLUX: -t=43200
#FLUX: --urgency=16

source $CONDA_ACTIVATE RNAseq
echo "current date"
date
echo "current git branch"
git branch
echo "current git version"
git log -1 --format="%H"
grep "\sfileName2\s" fastqList.txt
if [ "$?" == 0  ]
then
	isPE=true
else
	echo "running single end commands"
fi
fastqFileList=./fastqList.txt
if [ "$isPE" == "true" ]; then
	fastqFile1s=(`cut -f1 $fastqFileList`)
	fastqFile2s=(`cut -f2 $fastqFileList`)
	sampleNames=(`cut -f3 $fastqFileList`)
	repeatNums=(`cut -f4 $fastqFileList`)
	laneNums=(`cut -f5 $fastqFileList`)
else
	fastqFile1s=(`cut -f1 $fastqFileList`)
	sampleNames=(`cut -f2 $fastqFileList`)
	repeatNums=(`cut -f3 $fastqFileList`)
	laneNums=(`cut -f4 $fastqFileList`)
fi
i=${SLURM_ARRAY_TASK_ID}
if [ "${fastqFile2s[$i]}" == "NA" ]; then
	isPE=false
	echo "running single end commands"
else
	echo "running paired end commands"
fi
mRNAonly=false #false or true
fastqFile1=${fastqFile1s[$i]}
if [ "$isPE" == "true" ]; then
	fastqFile2=${fastqFile2s[$i]}
fi
sampleName=${sampleNames[$i]}
repeatNum=${repeatNums[$i]}
laneNum=${laneNums[$i]}
nThreads=${SLURM_CPUS_PER_TASK}
genomeVer=WS275
GENOME_DIR=${HOME}/genomeVer/${genomeVer}
genomeFile=${GENOME_DIR}/sequence/c_elegans.PRJNA13758.${genomeVer}.genomic.fa
chromSizesFile=$GENOME_DIR/annotation/ws235.chrom.sizes
mRNAindex=${GENOME_DIR}/sequence/${genomeVer}_mRNA_index
ncRNAindex=${GENOME_DIR}/sequence/${genomeVer}_ncRNA_index
pseudoIndex=${GENOME_DIR}/sequence/${genomeVer}_pseudogenic_index
tnIndex=${GENOME_DIR}/sequence/${genomeVer}_transposon_index
kmerSize=15
rptIndex=${GENOME_DIR}/sequence/${genomeVer}_repeats_index_${kmerSize}
WORK_DIR=$PWD
QC_DIR=${WORK_DIR}/qc
baseName=${sampleName}_${repeatNum}_${laneNum}
echo "running fastqc on raw data"
mkdir -p ${WORK_DIR}/qc/rawData
fastqc ${fastqFile1} -t $nThreads -o ${WORK_DIR}/qc/rawData
if [ "$isPE" == "true" ]; then
fastqc ${fastqFile2} -t $nThreads -o ${WORK_DIR}/qc/rawData
fi
echo "trimming adaptors with cutadapt"
mkdir -p cutadapt
if [ "$isPE" == "true" ]; then
cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT  -o cutadapt/${baseName}_R1.fastq.gz -p cutadapt/${baseName}_R2.fastq.gz -j $nThreads ${fastqFile1} ${fastqFile2} > ${WORK_DIR}/qc/cutadapt/report_cutadapt_${baseName}.txt
else
cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -o cutadapt/${baseName}_R1.fastq.gz -j $nThreads ${fastqFile1} > ${WORK_DIR}/qc/cutadapt/report_cutadapt_${baseName}.txt
fi
echo "running fastqc on trimmed data"
mkdir -p ${WORK_DIR}/qc/cutadapt
fastqc cutadapt/${baseName}_R1.fastq.gz -t $nThreads -o ${WORK_DIR}/qc/cutadapt
if [ "$isPE" == "true" ]; then
fastqc cutadapt/${baseName}_R2.fastq.gz -t $nThreads -o ${WORK_DIR}/qc/cutadapt
fi
normalisation=RPM #None or RPM
strandedness=Stranded #Stranded or Unstranded
echo "aligning to genome with STAR..."
mkdir -p ${WORK_DIR}/bamSTAR
if [ "$isPE" == "true" ]; then
	STAR --genomeDir ${GENOME_DIR}/sequence  --readFilesIn ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz ${WORK_DIR}/cutadapt/${baseName}_R2.fastq.gz --readFilesCommand zcat --outFileNamePrefix ${WORK_DIR}/bamSTAR/${baseName}_ --runThreadN $nThreads --outSAMmultNmax 1 --alignIntronMax 5000 --quantMode GeneCounts --outSAMtype BAM SortedByCoordinate --outMultimapperOrder Random --outWigType wiggle --outWigStrand $strandedness --outWigNorm $normalisation
else
	STAR --genomeDir ${GENOME_DIR}/sequence  --readFilesIn ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz --readFilesCommand zcat --outFileNamePrefix ${WORK_DIR}/bamSTAR/${baseName}_ --runThreadN $nThreads --outSAMmultNmax 1 --alignIntronMax 5000 --quantMode GeneCounts --outSAMtype BAM SortedByCoordinate --outMultimapperOrder Random --outWigType wiggle --outWigStrand $strandedness --outWigNorm $normalisation
fi
samtools index ${WORK_DIR}/bamSTAR/${baseName}_Aligned.sortedByCoord.out.bam
wigToBigWig ${WORK_DIR}/bamSTAR/${baseName}_Signal.UniqueMultiple.str1.out.wig $chromSizesFile ${WORK_DIR}/bamSTAR/${baseName}_F_UniqueMultiple_${normalisation}.bw
wigToBigWig ${WORK_DIR}/bamSTAR/${baseName}_Signal.Unique.str1.out.wig $chromSizesFile ${WORK_DIR}/bamSTAR/${baseName}_F_Unique_${normalisation}.bw
if [ "$strandedness" == "Stranded" ]; then
	wigToBigWig ${WORK_DIR}/bamSTAR/${baseName}_Signal.UniqueMultiple.str2.out.wig $chromSizesFile ${WORK_DIR}/bamSTAR/${baseName}_R_UniqueMultiple_${normalisation}.bw
	wigToBigWig ${WORK_DIR}/bamSTAR/${baseName}_Signal.Unique.str2.out.wig $chromSizesFile ${WORK_DIR}/bamSTAR/${baseName}_R_Unique_${normalisation}.bw
fi
if [ -e "${WORK_DIR}/bamSTAR/${baseName}_R_UniqueMultiple_${normalisation}.bw" ]; then
	rm ${WORK_DIR}/bamSTAR/${baseName}_Signal.UniqueMultiple.str1.out.wig
	rm ${WORK_DIR}/bamSTAR/${baseName}_Signal.Unique.str1.out.wig
	if [ "$strandedness" == "Stranded" ]; then
		rm ${WORK_DIR}/bamSTAR/${baseName}_Signal.UniqueMultiple.str2.out.wig
		rm ${WORK_DIR}/bamSTAR/${baseName}_Signal.Unique.str2.out.wig
	fi
fi
if [ "$isPE" == "true" ]; then
${SALMON_SING} salmon quant -i ${mRNAindex} -l A -1 ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz -2 ${WORK_DIR}/cutadapt/${baseName}_R2.fastq.gz  --validateMappings -p ${nThreads} -o ${WORK_DIR}/salmon/mRNA/${baseName} --seqBias --gcBias --numBootstraps 100
else
${SALMON_SING} salmon quant -i ${mRNAindex} -l A -r ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz --validateMappings -p ${nThreads} -o ${WORK_DIR}/salmon/mRNA/${baseName} --seqBias --gcBias --numBootstraps 100
fi
echo "finished mRNA alignment"
if [[ "${mRNAonly}" == "false" ]]
   then
   # quantify ncRNA transcripts
   if [ "$isPE" == "true" ]; then
    ${SALMON_SING} salmon quant -i ${ncRNAindex} -l A -1 ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz -2 ${WORK_DIR}/cutadapt/${baseName}_R2.fastq.gz --validateMappings -p ${nThreads} -o ${WORK_DIR}/salmon/ncRNA/${baseName} --seqBias --gcBias --numBootstraps 100
   else
    ${SALMON_SING} salmon quant -i ${ncRNAindex} -l A -r ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz --validateMappings -p ${nThreads} -o ${WORK_DIR}/salmon/ncRNA/${baseName} --seqBias --gcBias --numBootstraps 100
   fi
   # quantify pseudoRNA transcripts
   if [ "$isPE" == "true" ]; then
   	${SALMON_SING} salmon quant -i ${pseudoIndex} -l A -1 ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz -2 ${WORK_DIR}/cutadapt/${baseName}_R2.fastq.gz --validateMappings -p ${nThreads} -o ${WORK_DIR}/salmon/pseudoRNA/${baseName} --seqBias --gcBias --numBootstraps 100
   else
    ${SALMON_SING} salmon quant -i ${pseudoIndex} -l A -r ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz --validateMappings -p ${nThreads} -o ${WORK_DIR}/salmon/pseudoRNA/${baseName} --seqBias --gcBias --numBootstraps 100
    fi
   # quantify TnRNA transcripts
   if [ "$isPE" == "true" ]; then
    ${SALMON_SING} salmon quant -i ${tnIndex} -l A -1 ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz -2 ${WORK_DIR}/cutadapt/${baseName}_R2.fastq.gz --validateMappings -p ${nThreads} -o ${WORK_DIR}/salmon/tnRNA/${baseName} --seqBias --gcBias --numBootstraps 100
   else
   	${SALMON_SING} salmon quant -i ${tnIndex} -l A -r ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz --validateMappings -p ${nThreads} -o ${WORK_DIR}/salmon/tnRNA/${baseName} --seqBias --gcBias --numBootstraps 100
   fi
   # quantify repeat transcripts
   if [ "$isPE" == "true" ]; then
    ${SALMON_SING} salmon quant -i ${rptIndex} -l A -1 ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz -2 ${WORK_DIR}/cutadapt/${baseName}_R2.fastq.gz --validateMappings -p ${nThreads} -o ${WORK_DIR}/salmon/rptRNA/${baseName} --seqBias --gcBias --numBootstraps 100
   else
    ${SALMON_SING} salmon quant -i ${rptIndex} -l A -r ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz --validateMappings -p ${nThreads} -o ${WORK_DIR}/salmon/rptRNA/${baseName} --seqBias --gcBias --numBootstraps 100
   fi
   #######################################################
   ## Align to genome with STAR - ungapped repeats      ##
   #######################################################
   # STAR alignment with parameters for ungapped reads (--alignIntronMax 1 means that maximum intron length is 1bp)
   # align to genome
   echo "aligning to genome..."
   mkdir -p ${WORK_DIR}/bamSTARrpts
   if [ "$isPE" == "true" ]; then
STAR --genomeDir ${GENOME_DIR}/sequence/repeats  --readFilesIn ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz ${WORK_DIR}/cutadapt/${baseName}_R2.fastq.gz --readFilesCommand zcat --outFileNamePrefix ${WORK_DIR}/bamSTARrpts/rpts_${baseName}_ --runThreadN $nThreads --outFilterMultimapNmax 6000 --outSAMmultNmax 1 --outFilterMismatchNmax 3 --alignIntronMax 1 --quantMode GeneCounts --outSAMtype BAM SortedByCoordinate --outMultimapperOrder Random --winAnchorMultimapNmax 6000 --outWigType wiggle --outWigStrand Unstranded --outWigNorm None
   else
   	STAR --genomeDir ${GENOME_DIR}/sequence/repeats  --readFilesIn ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz --readFilesCommand zcat --outFileNamePrefix ${WORK_DIR}/bamSTARrpts/rpts_${baseName}_ --runThreadN $nThreads --outFilterMultimapNmax 6000 --outSAMmultNmax 1 --outFilterMismatchNmax 3 --alignIntronMax 1 --quantMode GeneCounts --outSAMtype BAM SortedByCoordinate --outMultimapperOrder Random --winAnchorMultimapNmax 6000 --outWigType wiggle --outWigStrand Unstranded --outWigNorm None
   fi
   samtools index ${WORK_DIR}/bamSTARrpts/rpts_${baseName}_Aligned.sortedByCoord.out.bam
   wigToBigWig ${WORK_DIR}/bamSTARrpts/rpts_${baseName}_Signal.UniqueMultiple.str1.out.wig $chromSizesFile ${WORK_DIR}/bamSTARrpts/rpts_${baseName}_UniqueMultiple.bw
   wigToBigWig ${WORK_DIR}/bamSTARrpts/rpts_${baseName}_Signal.Unique.str1.out.wig $chromSizesFile ${WORK_DIR}/bamSTARrpts/rpts_${baseName}_Unique.bw
   if [ -e "${WORK_DIR}/bamSTARrpts/rpts_${baseName}_UniqueMultiple.bw" ]; then
      rm ${WORK_DIR}/bamSTARrpts/rpts_${baseName}_Signal.UniqueMultiple.str1.out.wig
      rm ${WORK_DIR}/bamSTARrpts/rpts_${baseName}_Signal.Unique.str1.out.wig
   fi
   ########
   # Align to genome with bwa aln
   ########
   mkdir -p ${WORK_DIR}/bamBWA
   echo "aligning $baseName to genome with BWA aln..."
   bwa aln -t $nThreads $genomeFile ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz > ${WORK_DIR}/bamBWA/${baseName}_R1.sai
   if [ "$isPE" == "true" ]; then
    bwa aln -t $nThreads $genomeFile ${WORK_DIR}/cutadapt/${baseName}_R2.fastq.gz > ${WORK_DIR}/bamBWA/${baseName}_R2.sai
   	bwa sampe $genomeFile ${WORK_DIR}/bamBWA/${baseName}_R1.sai ${WORK_DIR}/bamBWA/${baseName}_R2.sai ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz ${WORK_DIR}/cutadapt/${baseName}_R2.fastq.gz > ${WORK_DIR}/bamBWA/${baseName}.sam
   else
   	bwa samse $genomeFile ${WORK_DIR}/bamBWA/${baseName}_R1.sai ${WORK_DIR}/cutadapt/${baseName}_R1.fastq.gz > ${WORK_DIR}/bamBWA/${baseName}.sam
   fi
   echo "Removing unmapped reads and converting $baseName SAM to BAM..."
   samtools view -b -F 4 -@ $nThreads ${WORK_DIR}/bamBWA/${baseName}.sam > ${WORK_DIR}/bamBWA/${baseName}.bam
   rm ${WORK_DIR}/bamBWA/${baseName}.sam
   rm ${WORK_DIR}/bamBWA/${baseName}_R1.sai
   if [ "$isPE" == "true" ]; then
   	rm ${WORK_DIR}/bamBWA/${baseName}_R2.sai
   fi
   #gtfFile=${GENOME_DIR}/annotation/c_elegans.PRJNA13758.${genomeVer}.annotations_rpt.gtf
   annotFile_rpt=${GENOME_DIR}/annotation/c_elegans.PRJNA13758.${genomeVer}.annotations_rpt.gtf
   # count reads per feature with htseq
   mkdir -p ${WORK_DIR}/htseq
   htseq-count -f bam -r name -a 0 -m union --nonunique random  ${WORK_DIR}/bamBWA/${baseName}.bam $annotFile_rpt > ${WORK_DIR}/htseq/${baseName}_union_random.txt
   #--additional-attr=gene_name
   samtools sort -T ${WORK_DIR}/bamBWA/${baseName}  -@ $nThreads -o ${WORK_DIR}/bamBWA/${baseName}_sort.bam  ${WORK_DIR}/bamBWA/${baseName}.bam
   samtools index -@ $nThreads ${WORK_DIR}/bamBWA/${baseName}_sort.bam
   rm ${WORK_DIR}/bamBWA/${baseName}.bam
fi
