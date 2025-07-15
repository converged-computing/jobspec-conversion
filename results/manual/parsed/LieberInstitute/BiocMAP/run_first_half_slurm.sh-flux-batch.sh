#!/bin/bash
#FLUX: --job-name=hairy-ricecake-2491
#FLUX: --urgency=16

export _JAVA_OPTIONS='-Xms8g -Xmx10g'

ORIG_DIR=$PWD
export _JAVA_OPTIONS="-Xms8g -Xmx10g"
$ORIG_DIR/Software/bin/nextflow $ORIG_DIR/first_half.nf \
    --annotation "$ORIG_DIR/ref" \
    --sample "paired" \
    --reference "hg38" \
    -profile first_half_slurm
