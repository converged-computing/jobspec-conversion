#!/bin/bash
#FLUX: --job-name=astute-hope-9146
#FLUX: --urgency=16

BAMDIR=$1
BAMFILES=($(find $BAMDIR -name *.bam))
BAM=${BAMFILES[$SLURM_ARRAY_TASK_ID]}
OUTDIR=$2
BED=$3
GENE_NAMES=$4
NAME=$(echo $BAM | awk -F "/" '{print $NF}' | awk -F "." '{print $1"."$2"."$3}' | sed 's/_L001_R1_001//;s/.fastq//')
mkdir $OUTDIR/Final_bed_files
FILE=$OUTDIR/Final_bed_files/$NAME.virulence.sorted.filtered.final.bed
if [ ! -e $FILE ]; then
	echo "$FILE does not exists, processing it now"
	bedtools genomecov -ibam $BAM -bg > $OUTDIR/$NAME.histogram.bed
	bedtools coverage -a $BED -b $OUTDIR/$NAME.histogram.bed -hist | awk '$4==1' > $OUTDIR/$NAME.virulence_only1.bed
	bedtools coverage -a $BED -b $OUTDIR/$NAME.histogram.bed -hist | awk '$4==0' | awk '$7==1.0000000' > $OUTDIR/$NAME.virulence_only0.bed
	sed 's/\t1.0000000/\t0.0000000/g' $OUTDIR/$NAME.virulence_only0.bed > $OUTDIR/$NAME.virulence_only0_with0.bed
	cat $OUTDIR/$NAME.virulence_only1.bed $OUTDIR/$NAME.virulence_only0_with0.bed > $OUTDIR/$NAME.virulence.bed
	bedtools sort -i $OUTDIR/$NAME.virulence.bed > $OUTDIR/$NAME.virulence.sorted.bed
	awk '{print $1 "\t" $7}' $OUTDIR/$NAME.virulence.sorted.bed | awk '{$1="$NAME"; print ;}' | sed 's/\$NAME/'$NAME'/g' > $OUTDIR/$NAME.virulence.sorted.filtered.bed
	paste <(awk '{print $1 "\t" $2}' $OUTDIR/$NAME.virulence.sorted.filtered.bed ) <(awk -F "\t" '{print $4}' $GENE_NAMES ) > $OUTDIR/Final_bed_files/$NAME.virulence.sorted.filtered.final.bed
	rm $OUTDIR/$NAME.*.bed
else
	echo "$FILE exists!"
fi
