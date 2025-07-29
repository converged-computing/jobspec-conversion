#!/bin/bash
#SBATCH --job-name=purecn
#SBATCH --output=project_%j.out
#SBATCH --error=project_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=10:00:00
#SBATCH --partition=priority

date
. .profile
which Rscript
bname=`basename $1 .bed`
Rscript \
$PURECN/IntervalFile.R \
--infile $1 \
--fasta $bcbio/genomes/Hsapiens/hg38/seq/hg38.fa \
--outfile $bname.txt \
--offtarget \
--genome hg38 \
--export panel.optimized.bed \
--mappability $PURECN/GCA_000001405.15_GRCh38_no_alt_analysis_set_100.bw
date
