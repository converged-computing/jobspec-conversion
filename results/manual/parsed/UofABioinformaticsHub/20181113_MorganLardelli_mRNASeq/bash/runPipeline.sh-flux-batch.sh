#!/bin/bash
#FLUX: --job-name=arid-nunchucks-3628
#FLUX: -n=16
#FLUX: --queue=batch
#FLUX: -t=86400
#FLUX: --urgency=16

CORES=16
module load FastQC/0.11.7
module load STAR/2.5.3a-foss-2016b
module load SAMtools/1.3.1-GCC-5.3.0-binutils-2.25
module load AdapterRemoval/2.2.1-foss-2016b
module load GCC/5.4.0-2.26
featureCounts=/data/biohub/local/subread-1.5.2-Linux-x86_64/bin/featureCounts
REFS=/data/biorefs/reference_genomes/ensembl-release-94/danio-rerio/
GTF=${REFS}/Danio_rerio.GRCz11.94.chr.gtf
PROJROOT=/data/biohub/20181113_MorganLardelli_mRNASeq
RAWDATA=${PROJROOT}/0_rawData
mkdir -p ${RAWDATA}/FastQC
TRIMDATA=${PROJROOT}/1_trimmedData
mkdir -p ${TRIMDATA}/fastq
mkdir -p ${TRIMDATA}/FastQC
mkdir -p ${TRIMDATA}/logs
ALIGNDATA=${PROJROOT}/2_alignedData
mkdir -p ${ALIGNDATA}/logs
mkdir -p ${ALIGNDATA}/bams
mkdir -p ${ALIGNDATA}/FastQC
mkdir -p ${ALIGNDATA}/featureCounts
fastqc -t ${CORES} -o ${RAWDATA}/FastQC --noextract ${RAWDATA}/fastq/*fq.gz
for R1 in ${RAWDATA}/fastq/*R1.fq.gz
  do
    echo -e "Currently working on ${R1}"
    # Now create the output filenames
    out1=${TRIMDATA}/fastq/$(basename $R1)
    BNAME=${TRIMDATA}/fastq/$(basename ${R1%_R1.fq.gz})
    echo -e "Output file 1 will be ${out1}"
    echo -e "Trimming:\t${R1}"
    # Trim
    AdapterRemoval \
      --adapter1 AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
      --gzip \
      --trimns \
      --trimqualities \
      --minquality 20 \
      --minlength 35 \
      --threads ${CORES} \
      --basename ${BNAME} \
      --output1 ${out1} \
      --file1 ${R1} 
  done
mv ${TRIMDATA}/fastq/*settings ${TRIMDATA}/logs
fastqc -t ${CORES} -o ${TRIMDATA}/FastQC --noextract ${TRIMDATA}/fastq/*R1.fq.gz
for R1 in ${TRIMDATA}/fastq/*R1.fq.gz
  do
  BNAME=$(basename ${R1%_R1.fq.gz})
  echo -e "STAR will align:\t${R1}"
    STAR \
        --runThreadN ${CORES} \
        --genomeDir ${REFS}/star \
        --readFilesIn ${R1} \
        --readFilesCommand gunzip -c \
        --outFileNamePrefix ${ALIGNDATA}/bams/${BNAME} \
        --outSAMtype BAM SortedByCoordinate 
  done
mv ${ALIGNDATA}/bams/*out ${ALIGNDATA}/logs
mv ${ALIGNDATA}/bams/*tab ${ALIGNDATA}/logs
for BAM in ${ALIGNDATA}/bams/*.bam
 do
   fastqc -t ${CORES} -f bam_mapped -o ${ALIGNDATA}/FastQC --noextract ${BAM}
   samtools index ${BAM}
 done
sampleList=`find ${ALIGNDATA}/bams -name "*out.bam" | tr '\n' ' '`
${featureCounts} -Q 10 \
  -s 1 \
  -T ${CORES} \
  -a ${GTF} \
  -o ${ALIGNDATA}/featureCounts/counts.out ${sampleList}
cut -f1,7- ${ALIGNDATA}/featureCounts/counts.out | \
sed 1d > ${ALIGNDATA}/featureCounts/genes.out
