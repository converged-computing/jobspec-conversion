#!/bin/bash
#SBATCH --output=run_first_half_marcc.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --mem=10G
#SBATCH --time=00:15:00

export _JAVA_OPTIONS='-Xms3g -Xmx4g'

ORIG_DIR=$PWD
module load java
export _JAVA_OPTIONS="-Xms3g -Xmx4g"
$ORIG_DIR/Software/bin/nextflow $ORIG_DIR/first_half.nf \
    --annotation "$ORIG_DIR/ref" \
    --sample "paired" \
    --reference "hg38" \
    -profile first_half_marcc
