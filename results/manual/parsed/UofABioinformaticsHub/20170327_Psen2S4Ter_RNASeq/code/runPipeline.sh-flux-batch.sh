#!/bin/bash
#FLUX: --job-name=outstanding-fudge-8336
#FLUX: -n=12
#FLUX: --queue=batch
#FLUX: -t=7200
#FLUX: --urgency=16

CORES=12
module load FastQC/0.11.7
module load STAR/2.7.0d-foss-2016b
module load SAMtools/1.3.1-GCC-5.3.0-binutils-2.25
module load cutadapt/1.14-foss-2016b-Python-2.7.13
module load Subread/1.5.2-foss-2016b
checkAndMake () {
  echo "Checking if $1 exists"
  if [[ ! -d $1 ]]
    then 
      echo "Creating $1"
      mkdir -p $1
  fi
  if [[ -d $1 ]]
    then
      echo "Found $1"
    else
      echo "$1 could not be created or found"
      exit 1
  fi  
}
PROJROOT=/data/biohub/20170327_Psen2S4Ter_RNASeq/data
REFS=/data/biorefs/reference_genomes/ensembl-release-98/danio_rerio/
if [[ ! -d ${REFS} ]]
then
  echo "Couldn't find ${REFS}"
  exit 1
fi
GTF=${REFS}/Danio_rerio.GRCz11.98.chr.gtf.gz
if [[ ! -f ${GTF} ]]
then
  echo "Couldn't find ${GTF}"
  exit 1
fi
RAWDIR=${PROJROOT}/0_rawData
checkAndMake ${RAWDIR}
checkAndMake ${RAWDIR}/FastQC
TRIMDIR=${PROJROOT}/1_trimmedData
checkAndMake ${TRIMDIR}/fastq
checkAndMake ${TRIMDIR}/FastQC
checkAndMake ${TRIMDIR}/log
ALIGNDIR=${PROJROOT}/2_alignedData
checkAndMake ${ALIGNDIR}
checkAndMake ${ALIGNDIR}/bam
checkAndMake ${ALIGNDIR}/FastQC
checkAndMake ${ALIGNDIR}/log
checkAndMake ${ALIGNDIR}/featureCounts
echo "All directories checked and created"
fastqc -t ${CORES} -o ${RAWDIR}/FastQC --noextract ${RAWDIR}/fastq/*fastq.gz
for R1 in ${RAWDIR}/fastq/*R1.fastq.gz
  do
    R2=${R1%_R1.fastq.gz}_R2.fastq.gz
    echo -e "The R1 file should be ${R1}"
    echo -e "The R2 file should be ${R2}"
    ## Create output filenames
    out1=${TRIMDIR}/fastq/$(basename $R1)
    out2=${TRIMDIR}/fastq/$(basename $R2)
    BNAME=${TRIMDIR}/fastq/$(basename ${R1%_1.fq.gz})
    echo -e "Output file 1 will be ${out1}"
    echo -e "Output file 2 will be ${out2}"
    echo -e "Trimming:\t${BNAME}"
    LOG=${TRIMDIR}/log/$(basename ${BNAME}).info
    echo -e "Trimming info will be written to ${LOG}"
    cutadapt \
      -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
      -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
      -o ${out1} \
      -p ${out2} \
      -m 35 \
      --trim-n \
      --max-n=1 \
      --nextseq-trim=30 \
      ${R1} \
      ${R2} > ${LOG}
  done
fastqc -t ${CORES} -o ${TRIMDIR}/FastQC --noextract ${TRIMDIR}/fastq/*fastq.gz
for R1 in ${TRIMDIR}/fastq/*R1.fastq.gz
 do
 BNAME=$(basename ${R1%_R1.fastq.gz})
 R2=${R1%_R1.fastq.gz}_R2.fastq.gz
 echo -e "STAR will align:\t${R1}"
 echo -e "STAR will also align:\t${R2}"
  STAR \
    --runThreadN ${CORES} \
    --genomeDir ${REFS}/star \
    --readFilesIn ${R1} ${R2} \
    --readFilesCommand gunzip -c \
    --outFileNamePrefix ${ALIGNDIR}/bam/${BNAME} \
    --outSAMtype BAM SortedByCoordinate
 done
mv ${ALIGNDIR}/bam/*out ${ALIGNDIR}/log
mv ${ALIGNDIR}/bam/*tab ${ALIGNDIR}/log
for BAM in ${ALIGNDIR}/bam/*.bam
do
  fastqc -t ${CORES} -f bam_mapped -o ${ALIGNDIR}/FastQC --noextract ${BAM}
  samtools index ${BAM}
done
sampleList=`find ${ALIGNDIR}/bam -name "*out.bam" | tr '\n' ' '`
zcat ${GTF} > temp.gtf
featureCounts -Q 10 \
  -s 2 \
  -T ${CORES} \
  -p \
  --fracOverlap 1 \
  -a temp.gtf \
  -o ${ALIGNDIR}/featureCounts/counts.out ${sampleList}
rm temp.gtf
 ## Storing the output in a single file
cut -f1,7- ${ALIGNDIR}/featureCounts/counts.out | \
  sed 1d > ${ALIGNDIR}/featureCounts/genes.out
for R1 in ${TRIMDIR}/fastq/*R1.fastq.gz
  do
    sbatch ${PROJROOT}/bash/singleKallisto.sh ${R1}
  done
