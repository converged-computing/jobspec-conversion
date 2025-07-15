#!/bin/bash
#FLUX: --job-name=freebayes
#FLUX: --queue=general
#FLUX: --urgency=16

hostname
date
module load bedtools
module load bamtools
module load htslib
module load freebayes
OUTDIR=../variants_freebayes
mkdir -p $OUTDIR 
find ../align_pipe/ -name "*bam" >$OUTDIR/bam.list
GEN=/UCHC/PublicShare/CBC_Tutorials/Variant_Detection_Tutorials/Variant-Detection-Introduction-GATK_all/resources_all/Homo_sapiens_assembly38.fasta
OUTLIERWINDOWS=../coverage_stats/coverage_outliers.bed.gz
TARGETS=../coverage_stats/targets.bed
	# coverage limits defined by looking at the distribution of per base coverage
freebayes \
-f $GEN \
--bam-list $OUTDIR/bam.list \
-m 30 \
-q 20 \
--min-coverage 110 \
--skip-coverage 330 \
-t $TARGETS | \
bgzip -c >$OUTDIR/chinesetrio_fb.vcf.gz
	# use bamtools to merge all reads into a single stream, filter on quality, then
	# use bedtools to exclude reads overlapping outlier windows defined previously. 
tabix -p vcf $OUTDIR/chinesetrio_fb.vcf.gz
date
