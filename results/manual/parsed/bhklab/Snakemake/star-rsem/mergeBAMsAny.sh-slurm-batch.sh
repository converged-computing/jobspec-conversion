#!/bin/bash
#SBATCH --job-name=mergeBAMs
#SBATCH --output=/cluster/home/psmirnov/logs/mergeBAMs_%j.log
#SBATCH --mail-user=petr.smirnov@mail.utoronto.ca
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20Gb
#SBATCH --time=04:00:00

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
