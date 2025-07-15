#!/bin/bash
#FLUX: --job-name=mergeBAMs
#FLUX: --queue=all
#FLUX: -t=14400
#FLUX: --urgency=16

module load samtools
fn=$1
BAMDIR=$2
OUTDIR=$3
BAMDIR=`echo $BAMDIR | sed -e 's/\/$//'`
OUTDIR=`echo $OUTDIR | sed -e 's/\/$//'`
echo $BAMDIR
echo $OUTDIR
mkdir $OUTDIR'/'$fn'_merged'
find $BAMDIR'/' -path $BAMDIR'/'$fn'*/*.bam' | xargs samtools merge $OUTDIR'/'$fn'_merged/'$fn'_merged.bam' 
echo 'merged '$fn
echo 'done'
