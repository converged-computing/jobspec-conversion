#!/bin/bash
#SBATCH --output=run_second_half_marcc.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=00:30:00

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
