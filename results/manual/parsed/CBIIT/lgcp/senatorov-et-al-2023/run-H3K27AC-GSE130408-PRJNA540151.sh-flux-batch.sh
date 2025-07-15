#!/bin/bash
#FLUX: --job-name=psycho-leader-0037
#FLUX: -c=12
#FLUX: --queue=ccr
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
module load nextflow
module load singularity
module load graphviz
nextflow run nf-core/atacseq -r dev --input /data/capaldobj/lgcp/senatorov-et-al-2023/design-K27ac-GSE130408-PRJNA540151.csv \
-profile biowulf \
-resume \
--aligner bwa \
--genome GRCh37 \
--narrow_peak \
--igenomes_base 's3://ngi-igenomes/igenomes' \
--read_length 75 \
--outdir '/data/LGCP/freedman-chip/lucap-only-k27ac-results/'
