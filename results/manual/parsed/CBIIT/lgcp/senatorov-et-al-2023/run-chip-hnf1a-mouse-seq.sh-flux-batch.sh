#!/bin/bash
#FLUX: --job-name=misunderstood-onion-0976
#FLUX: -c=12
#FLUX: --queue=ccr
#FLUX: -t=259200
#FLUX: --priority=16

module purge
module load nextflow
module load singularity
module load graphviz
nextflow run nf-core/chipseq -r 2.0.0 --input /data/capaldobj/lgcp/senatorov-et-al-2023/design-hnf1a-chip.csv \
-profile biowulf \
--aligner bwa \
--genome GRCm38 \
--igenomes_base 's3://ngi-igenomes/igenomes' \
--narrow_peak \
--read_length 75 \
--outdir '/data/capaldobj/incoming-nih-dme/CS035088-chip-seq-ilya-hnf1a/chipseq-results/'
