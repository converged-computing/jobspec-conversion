#!/bin/bash
#FLUX: --job-name=angry-ricecake-6163
#FLUX: -c=3
#FLUX: --urgency=16

export _JAVA_OPTIONS='-Xms3g -Xmx4g'

ORIG_DIR=$PWD
module load java
export _JAVA_OPTIONS="-Xms3g -Xmx4g"
$ORIG_DIR/Software/bin/nextflow $ORIG_DIR/first_half.nf \
    --annotation "$ORIG_DIR/ref" \
    --sample "paired" \
    --reference "hg38" \
    -profile first_half_marcc
