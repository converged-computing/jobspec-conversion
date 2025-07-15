#!/bin/bash
#FLUX: --job-name=carnivorous-motorcycle-1569
#FLUX: -t=172800
#FLUX: --priority=16

CORES=12
module load FastQC/0.11.7
module load SAMtools/1.3.1-GCC-5.3.0-binutils-2.25
module load Subread/1.5.2-foss-2016b
PROJROOT=/data/biohub/202003_Ville_RNAseq/data
ALIGNDIR=${PROJROOT}/2_alignedData
REFS=/data/biorefs/reference_genomes/ensembl-release-98/homo_sapiens/
if [[ ! -d ${REFS} ]]
then
  echo "Couldn't find ${REFS}"
  exit 1
fi
GTF=${REFS}/Homo_sapiens.GRCh38.98.chr.gtf.gz
if [[ ! -f ${GTF} ]]
then
  echo "Couldn't find ${GTF}"
  exit 1
fi
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
