#!/bin/bash
#FLUX: --job-name=faux-lentil-2846
#FLUX: -t=86400
#FLUX: --urgency=16

CORES=16
module load FastQC/0.11.7
module load STAR/2.5.3a-foss-2016b
module load SAMtools/1.3.1-GCC-5.3.0-binutils-2.25
module load AdapterRemoval/2.2.1-foss-2016b
module load GCC/5.4.0-2.26
module load Subread
REFS=/data/biorefs/reference_genomes/ensembl-release-96/danio_rerio
if [ ! -d "${REFS}" ]; then
  echo -e "Couldn't find ${REFS}"
  exit 1
fi
echo -e "Found ${REFS}"
GTF=${REFS}/Danio_rerio.GRCz11.96.chr.gtf.gz
if [ ! -f "${GTF}" ]; then
  echo -e "Couldn't find ${GTF}"
  exit 1
fi
echo -e "Found ${GTF}"
PROJROOT=/data/biohub/2019_Lardelli_AllWT_6month_RNASeq
if [ ! -d "${PROJROOT}" ]; then
  echo -e "Couldn't find ${PROJROOT}"
  exit 1
fi
echo -e "Found ${PROJROOT}"
RAWDATA=${PROJROOT}/0_rawData
mkdir -p ${RAWDATA}/FastQC
if [ ! -d "${RAWDATA}/fastq" ]; then
  echo -e "Couldn't find ${RAWDATA}/fastq"
  exit 1
fi
echo -e "Found ${RAWDATA}/fastq"
TRIMDATA=${PROJROOT}/1_trimmedData
mkdir -p ${TRIMDATA}/fastq
mkdir -p ${TRIMDATA}/FastQC
mkdir -p ${TRIMDATA}/log
ALIGNDATA=${PROJROOT}/2_alignedData
mkdir -p ${ALIGNDATA}/log
mkdir -p ${ALIGNDATA}/bam
mkdir -p ${ALIGNDATA}/FastQC
mkdir -p ${ALIGNDATA}/featureCounts
fastqc -t ${CORES} -o ${RAWDATA}/FastQC --noextract ${RAWDATA}/fastq/*.fq.gz
for R1 in ${RAWDATA}/fastq/*1.fq.gz
  do
    echo -e "Currently working on ${R1}"
    # Now create the output filenames
    out1=${TRIMDATA}/fastq/$(basename $R1)
    BNAME=${TRIMDATA}/fastq/$(basename ${R1%_R1.fq.gz})
    echo -e "Output file 1 will be ${out1}"
    echo -e "Trimming:\t${BNAME}"
    #Trim
    AdapterRemoval \
      --gzip \
      --trimns \
      --trimqualities \
      --minquality 30 \
      --minlength 35 \
      --threads ${CORES} \
      --basename ${BNAME} \
      --output1 ${out1} \
      --file1 ${R1}
  done
mv ${TRIMDATA}/fastq/*settings ${TRIMDATA}/log
fastqc -t ${CORES} -o ${TRIMDATA}/FastQC --noextract ${TRIMDATA}/fastq/*.fq.gz
for R1 in ${TRIMDATA}/fastq/*1.fq.gz
  do
  BNAME=$(basename ${R1%_R1.fq.gz})
  echo -e "STAR will align:\t${R1}"
    STAR \
        --runThreadN ${CORES} \
        --genomeDir ${REFS}/star \
        --readFilesIn ${R1} \
        --readFilesCommand gunzip -c \
        --outFileNamePrefix ${ALIGNDATA}/bam/${BNAME} \
        --outSAMtype BAM SortedByCoordinate
  done
mv ${ALIGNDATA}/bam/*out ${ALIGNDATA}/log
mv ${ALIGNDATA}/bam/*tab ${ALIGNDATA}/log
for BAM in ${ALIGNDATA}/bam/*.bam
 do
   fastqc -t ${CORES} -f bam_mapped -o ${ALIGNDATA}/FastQC --noextract ${BAM}
   samtools index ${BAM}
 done
sampleList=`find ${ALIGNDATA}/bam -name "*out.bam" | tr '\n' ' '`
zcat ${GTF} > temp.gtf
featureCounts -Q 10 \
  -s 0 \
  -T ${CORES} \
  --fracOverlap 1 \
  -a temp.gtf \
  -o ${ALIGNDATA}/featureCounts/counts.out ${sampleList}
rm temp.gtf
cut -f1,7- ${ALIGNDATA}/featureCounts/counts.out | sed 1d > ${ALIGNDATA}/featureCounts/genes.out
