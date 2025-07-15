#!/bin/bash
#FLUX: --job-name=tart-butter-6732
#FLUX: -c=12
#FLUX: --queue=ccr
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
module load nextflow
module load singularity
module load graphviz
nextflow run nf-core/chipseq -r 2.0.0 --input /data/capaldobj/lgcp/senatorov-et-al-2023/design-dis-hnf1a-chip.csv \
-profile biowulf \
--aligner bwa \
--genome GRCh37 \
--igenomes_base 's3://ngi-igenomes/igenomes' \
--narrow_peak \
--read_length 75 \
--skip_trimming \
--outdir '/data/capaldobj/incoming-nih-dme/CS035088-chip-seq-ilya-hnf1a/chipseq-disambiguated-results/'
