#!/bin/bash
#FLUX: --job-name=NFmaster
#FLUX: --urgency=16

metadata=$1
reference=$2
output=$3
module load NextFlow/19.10.0
nextflow \
-c ~/CODE/core/workflows/singlecellrna/scRNA.config \
run ~/CODE/core/workflows/singlecellrna/scrna_short.nf \
-with-trace \
-with-timeline nf_scRNA_timeline.htm \
-with-report nf_scRNA_report.htm \
--metadata ${metadata} \
--reference ${reference} \
--output_dir ${output}
