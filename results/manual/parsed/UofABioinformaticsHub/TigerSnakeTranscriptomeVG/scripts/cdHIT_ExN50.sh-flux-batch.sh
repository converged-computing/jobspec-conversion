#!/bin/bash
#FLUX: --job-name=chunky-squidward-1352
#FLUX: -t=1800
#FLUX: --urgency=16

TRINITYDIR=/apps/software/Trinity/2.5.1-foss-2016b/trinityrnaseq-Trinity-v2.5.1/util/misc
MATRIXDIR=/home/a1671704/fastdir/Data_TigerSnake/3_transcriptomeAssembly/cdHITandDeNovo/downstreamAnalysis
ASSEMDIR=/home/a1671704/fastdir/Data_TigerSnake/3_transcriptomeAssembly/cdHITandDeNovo
OUTDIR=/home/a1671704/fastdir/Data_TigerSnake/3_transcriptomeAssembly/cdHITandDeNovo/qualityAssessment
${TRINITYDIR}/contig_ExN50_statistic.pl \
  ${MATRIXDIR}/CDHITKallistoAbundance.isoform.TMM.EXPR.matrix \
  ${ASSEMDIR}/collaspedTrinityDeNovo90 | \
  tee ${OUTDIR}/ExN90stats.txt
