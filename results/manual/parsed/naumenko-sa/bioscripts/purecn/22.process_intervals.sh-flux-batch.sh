#!/bin/bash
#FLUX: --job-name=purecn
#FLUX: --queue=priority
#FLUX: -t=36000
#FLUX: --urgency=16

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
