#!/bin/bash
#FLUX: --job-name=outstanding-bike-4277
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
REFS=/data/biorefs/reference_genomes/ensembl-release-94/danio-rerio/
GTF=${REFS}/Danio-rerio.GRCz11.94.chr.gtf
PROJROOT=/data/biohub/20190129_Lardelli_FMR1_RNASeq
TRIMDATA=${PROJROOT}/1_trimmedData
ALIGNDATA=${PROJROOT}/2_alignedData
mkdir -p ${ALIGNDATA}/logs
mkdir -p ${ALIGNDATA}/bams
mkdir -p ${ALIGNDATA}/FastQC
mkdir -p ${ALIGNDATA}/featureCounts
for R1 in ${TRIMDATA}/fastq/*1.fq.gz
  do
  BNAME=$(basename ${R1%1.fq.gz})
  R2=${R1%1.fq.gz}2.fq.gz
  echo -e "STAR will align:\n\t${R1} amd \n\t${R2}"
    STAR \
        --runThreadN ${CORES} \
        --genomeDir ${REFS}/star \
        --readFilesIn ${R1} ${R2} \
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
