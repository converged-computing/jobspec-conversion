#!/bin/bash
#FLUX: --job-name=bioinf benchmark
#FLUX: -n=20
#FLUX: --queue=physical
#FLUX: -t=86400
#FLUX: --urgency=16

WORK_DIR=/scratch/punim0930/evan/bioinf-io-benchmark
cd $WORK_DIR
module load BWA/0.7.17-intel-2018.u4 SAMtools/1.9-intel-2018.u4 Trimmomatic/0.36-Java-1.8.0_152
TRIMMOMATIC=/usr/local/easybuild/software/Trimmomatic/0.36/
REFERENCE=$WORK_DIR/hg38.fa
READ1=$WORK_DIR/fake_data1.fq
READ2=$WORK_DIR/fake_data2.fq
echo trim started
time java -jar ${TRIMMOMATIC}/trimmomatic-0.36.jar PE -threads `nproc` $READ1 $READ2 -baseout ${WORK_DIR}/output-trimmed.fastq.gz ILLUMINACLIP:${TRIMMOMATIC}/adapters/TruSeq3-PE.fa:1:30:20:4:true
echo trim ended
echo align started
time bwa mem -M -t `nproc` $REFERENCE ${WORK_DIR}/output-trimmed_1P.fastq.gz ${WORK_DIR}/output-trimmed_2P.fastq.gz > ${WORK_DIR}/aln.sam
echo align ended
echo sort started
time samtools sort -@ `nproc` ${WORK_DIR}/aln.sam > ${WORK_DIR}/aln.bam
echo sort ended
echo index started
time samtools index ${WORK_DIR}/aln.bam
echo index ended
