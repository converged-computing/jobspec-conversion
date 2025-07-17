#!/bin/bash
#FLUX: --job-name=nerdy-malarkey-5979
#FLUX: -t=1800
#FLUX: --urgency=16

export _JAVA_OPTIONS='-Xms8g -Xmx10g'

ORIG_DIR=$PWD
module load java
export _JAVA_OPTIONS="-Xms8g -Xmx10g"
$ORIG_DIR/Software/bin/nextflow $ORIG_DIR/second_half.nf \
    --annotation "$HOME/scratch/nextflow_ref" \
    -w "$HOME/scratch/nextflow_work_second" \
    --output "$HOME/scratch/nextflow_out" \
    --sample "paired" \
    --reference "hg38" \
    -profile second_half_marcc
