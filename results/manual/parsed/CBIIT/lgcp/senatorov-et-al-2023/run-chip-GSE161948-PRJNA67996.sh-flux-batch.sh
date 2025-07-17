#!/bin/bash
#FLUX: --job-name=spicy-milkshake-4573
#FLUX: -c=12
#FLUX: --queue=ccr
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
module load nextflow
module load singularity
module load graphviz
nextflow run nf-core/chipseq -r 2.0.0 --input /data/capaldobj/lgcp/senatorov-et-al-2023/design-GSE161948-PRJNA679976.csv \
-profile biowulf \
-resume \
--aligner bwa \
--genome GRCh37 \
--igenomes_base 's3://ngi-igenomes/igenomes' \
--narrow_peak \
--read_length 150 \
--skip_spp \
--outdir '/data/LGCP/freedman-chip/lucap-chipseq-results/'
