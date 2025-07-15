#!/bin/bash
#FLUX: --job-name=ET_mapChIPseq
#FLUX: -c=24
#FLUX: --queue=batch
#FLUX: -t=86400
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
source config.txt
OUTDIR="/scratch/evt82290/Run137"
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi
 ml Trim_Galore BWA SAMtools deepTools
 # trim_galore --paired --length 20 --fastqc --gzip -o ${OUTDIR}/TrimmedReads ${FASTQ}/*fastq\.gz
FILES="${OUTDIR}/TrimmedReads/*R1_001_val_1\.fq\.gz" #Don't forget the *
 mkdir "${OUTDIR}/SortedBamFiles"
 mkdir "${OUTDIR}/BigWigs"
 mkdir "${OUTDIR}/Peaks"
for f in $FILES
do
		#${string//substring/replacement}
	file=${f##*/}
	#remove ending from file name to create shorter names for bam files and other downstream output
	name=${file/%_S[1-12]*_L001_R1_001_val_1.fq.gz/}
	read2=$(echo "$f" | sed 's/R1_001_val_1\.fq\.gz/R2_001_val_2\.fq\.gz/g')
	#variable for naming bam file
 	bam="${OUTDIR}/SortedBamFiles/${name}.bam"
	#variable name for bigwig output
	bigwig="${OUTDIR}/BigWigs/${name}"
	#QualityBam="${OUTDIR}/SortedBamFiles/${name}_Q30.bam"
ml SAMtools
bwa mem -M -v 3 -t $THREADS $GENOME $f $read2 | samtools view -bhSu - | samtools sort -@ $THREADS -T $OUTDIR/SortedBamFiles/tempReps -o "$bam" -
samtools index "$bam"
ml deepTools
bamCoverage -p $THREADS $MNase -bs $BIN --normalizeUsing BPM --smoothLength $SMOOTH -of bigwig -b "$bam" -o "${bigwig}.bin_${BIN}.smooth_${SMOOTH}${MN}.bw"
done
